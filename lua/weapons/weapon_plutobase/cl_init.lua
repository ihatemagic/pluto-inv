include "shared.lua"

local function ReadMod()
	local name = net.ReadString()
	local tier = net.ReadUInt(4)
	local desc = net.ReadString()
	local rolls

	local fn
	if (net.ReadBool()) then
		fn = net.ReadFunction()
		rolls = {}
		for i = 1, net.ReadUInt(8) do
			rolls[i] = net.ReadDouble()
		end
	end

	return {
		Name = name,
		Tier = tier,
		Desc = desc,
		Mod = {
			ModifyWeapon = fn
		},
		Rolls = rolls,
	}
end

net.Receive("pluto_wpn_db", function(len)
	local ent = net.ReadInt(32)

	local PlutoData = {
		Type = "Weapon",
	}

	local modifiers = {
		implicit = {},
		prefix   = {},
		suffix   = {},
	}

	PlutoData.Tier = net.ReadString()
	PlutoData.Color = net.ReadColor()
	PlutoData.PrintName = net.ReadString()
	PlutoData.Mods = modifiers

	for ind = 1, net.ReadUInt(8) do
		modifiers.prefix[ind] = ReadMod()
	end

	for ind = 1, net.ReadUInt(8) do
		modifiers.suffix[ind] = ReadMod()
	end

	pluto.wpn_db[ent] = PlutoData

	function PlutoData:GetPrintName()
		return self.PrintName
	end

	local found
	for _, e in pairs(ents.GetAll()) do
		if (e.GetPlutoID and e:GetPlutoID() == ent) then
			found = e
			break
		end
	end

	if (IsValid(found)) then
		found:ReceivePlutoData()
	end
end)

hook.Add("TTTPrepareRound", "pluto_wpn_db", function()
	pluto.wpn_db = {}
end)


DEFINE_BASECLASS "weapon_tttbase_old"

function SWEP:Initialize()
	BaseClass.Initialize(self)
	self:PlutoInitialize()
end

function SWEP:DisplayPlutoData()
	local data = self:GetInventoryItem()
	data.ClassName = self:GetClass()
	pprintf("%s %s", data.Tier, self.PrintName)

	for type, list in pairs(data.Mods) do
		if (#list == 0) then
			continue
		end

		pprintf("    %s", type)

		for _, item in ipairs(list) do
			pprintf("        %s tier %i - %s", item.Name, item.Tier, item.Desc)
		end
	end
	MsgN ""

	self.Showcase = pluto.ui.showcase(data)
	self.Showcase.Start = CurTime()

	local t = self.Showcase.Think
	function self.Showcase:Think()
		if (t) then
			t(self)
		end

		local diff = CurTime() - self.Start
		local frac = 1
		if (diff < 0.2) then
			frac = (diff / 0.2) ^ 0.5
		elseif (diff > 2) then
			frac = 0
			self:Remove()
		elseif (diff > 1.8) then
			frac = 1 - ((diff - 1.8) / 0.2) ^ 0.5
		end

		self:SetPos(ScrW() * 2 / 3 - self:GetWide() / 2, ScrH() - self:GetTall() * frac)
	end

	local s = self.Showcase
end

function SWEP:Deploy()
	local data = self:GetInventoryItem()

	if (data and IsFirstTimePredicted()) then
		self:DisplayPlutoData()
	end

	return BaseClass.Deploy(self)
end

function SWEP:Holster(w)
	if (IsValid(self.Showcase)) then
		self.Showcase:Remove()
	end

	return BaseClass.Holster(self, w)
end
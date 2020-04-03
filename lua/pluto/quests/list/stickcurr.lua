QUEST.Name = "Currency Revealer"
QUEST.Description = "Reveal any currency to everyone by throwing a sticky grenade on them"
QUEST.Color = Color(254, 233, 105)

function QUEST:GetRewardText(seed)
	return "random grenade"
end

function QUEST:Init(data)
	local done = {}
	data:Hook("TTTGrenadeStuck", function(data, gren)
		local parent = gren:GetParent()
		if (gren:GetOwner() ~= data.Player) then
			return
		end

		if (not IsValid(parent)) then
			return
		end

		if (parent:GetClass() ~= "pluto_currency") then
			return
		end

		if (done[parent]) then
			return
		end

		done[parent] = true

		data:UpdateProgress(1)
	end)
end

function QUEST:Reward(data)
	local trans, new_item = pluto.inv.generatebuffergrenade(data.Player)
	trans:Run()

	data.Player:ChatPrint("You have received a ", new_item, white_text, " for completing ", self.Color, self.Name, white_text, "!")
end

function QUEST:IsType(type)
	return false
end

function QUEST:GetProgressNeeded(type)
	return math.random(6, 8)
end
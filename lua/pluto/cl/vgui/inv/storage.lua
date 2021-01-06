local PANEL = {}

local item_size = 56
local inner_area = 5
local outer_area = 10

function PANEL:Init()
	self:SetWide(item_size * 6 + inner_area * 5 + outer_area * 2)
	self.UpperArea = self:Add "EditablePanel"
	self.UpperArea:Dock(TOP)
	self.UpperArea:SetTall(22)

	self.Upper = self.UpperArea:Add "ttt_curved_panel"
	self.Upper:Dock(LEFT)
	self.Upper:SetWide(100)
	self.Upper:DockPadding(0, 4, 0, 3)

	self.UpperLabel = self.Upper:Add "pluto_label"
	self.UpperLabel:SetContentAlignment(5)
	self.UpperLabel:SetFont "pluto_inventory_font"
	self.UpperLabel:SetTextColor(Color(255, 255, 255))
	self.UpperLabel:SetRenderSystem(pluto.fonts.systems.shadow)
	self.UpperLabel:Dock(FILL)

	self.Container = self:Add "pluto_inventory_component"
	DEFINE_BASECLASS "pluto_inventory_component"
	self.Container:Dock(FILL)
	self.ItemContainer = self.Container:Add "EditablePanel"
	self.ItemContainer:SetSize(item_size * 6 + inner_area * 5, item_size * 6 + inner_area * 5)

	function self.Container.PerformLayout(s, w, h)
		BaseClass.PerformLayout(s, w, h)
		self.ItemContainer:Center()
	end

	self.ItemRows = {}
	self.Items = {}
	self.ItemHighlights = {}

	for i = 1, 6 do
		local row = self.ItemContainer:Add "EditablePanel"
		self.ItemRows[i] = row

		for j = 1, 6 do
			local item = row:Add "pluto_inventory_item"
			item:SetCanPickup()
			table.insert(self.Items, item)
			item:Dock(LEFT)
			if (j ~= 6) then
				item:DockMargin(0, 0, inner_area, 0)
			end
		end

		row:Dock(TOP)
		row:SetTall(56)
		if (i ~= 6) then
			row:DockMargin(0, 0, 0, inner_area)
		end
	end


	self.Container:SetCurveTopLeft(false)
	self.Upper:SetCurveBottomLeft(false)
	self.Upper:SetCurveBottomRight(false)

	self:SetText "Storage"
end

function PANEL:AddTab(tab)
	if (not self.ActiveTab) then
		self:PopulateFromTab(tab)
		self.ActiveTab = tab
	end
end

function PANEL:SetText(t)
	self.UpperLabel:SetText(t)
	
	local surface = self.UpperLabel:GetRenderSystem() or surface
	surface.SetFont(self.UpperLabel:GetFont())
	local tw, th = surface.GetTextSize(t)

	self.Upper:SetWide(tw + 24)
end

function PANEL:PopulateFromTab(tab)
	self.ItemHighlights = {}
	local tabtype = pluto.tabs[tab.Type]
	if (not tabtype) then
		ErrorNoHalt("unknown how to handle tab type " .. tab.Type)
		return
	end

	for i = 1, 36 do
		local item = tab.Items[i]
		self.Items[i]:SetUpdateFrom(tab.ID, i)
		self.Items[i]:SetItem(item)

		self.Items[i].CanClickWith = function(s, other)
			return tabtype.canaccept(i, other.Item)
		end
	end
	pluto.ui.realpickedupitem = nil
	if (IsValid(pluto.ui.pickedupitem)) then
		local p = pluto.ui.pickedupitem
		if (p.TabID  == tab.ID) then
			pluto.ui.realpickedupitem = self.Items[p.TabIndex]
		end
	end
end

function PANEL:SetCurve(curve)
	self.Container:SetCurve(curve)
	self.Upper:SetCurve(curve)
end

function PANEL:SetColor(col)
	self.Container:SetColor(col)
	self.Upper:SetColor(col)
end

function PANEL:SetStorageHandler(pnl)
	self.Handler = pnl
end

function PANEL:OnMouseWheeled(wheel)
	if (IsValid(self.Handler)) then
		self.Handler:HandleStorageScroll(wheel)
	end
end

function PANEL:HighlightItem(item)
	table.insert(self.ItemHighlights, {
		StartTime = CurTime(),
		TabIndex = item,
		Lifetime = 2,
	})
end

function PANEL:PaintOver()
	for i = #self.ItemHighlights, 1, -1 do
		local item = self.ItemHighlights[i]
		if (item.StartTime + item.Lifetime < CurTime()) then
			table.remove(self.ItemHighlights, i)
			continue
		end
		
		local pnl = self.Items[item.TabIndex]
		local frac = (CurTime() - item.StartTime) / item.Lifetime

		local x, y = self:ScreenToLocal(pnl:LocalToScreen(0, 0))
		local w, h = pnl:GetSize()
		surface.SetDrawColor(255, 255, 255, (1 - frac) * 255)
		surface.DrawOutlinedRect(x, y, w, h, 4)
	end
end

vgui.Register("pluto_storage_area", PANEL, "EditablePanel")

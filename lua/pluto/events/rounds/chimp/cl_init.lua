surface.CreateFont("chimp_header", {
	font = "Lato",
	size = math.max(24, ScrH() * 0.05),
})
surface.CreateFont("chimp_small", {
	font = "Roboto",
	size = math.max(16, ScrH() * 0.025),
})

local function RenderHeader()
	local y = ScrH() / 10
	local _, h = draw.SimpleTextOutlined("The chimps are trying to decide who is the Monke King", "chimp_header", ScrW() / 2, y, ttt.roles.Monke.Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(12, 13, 15))
	y = y + h

	local _, h = draw.SimpleTextOutlined("Collect the most bananas to rise up above the rest of the chimps", "chimp_small", ScrW() / 2, y, white_text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(12, 13, 15))
end

local function RenderRole()
	local ply = ttt.GetHUDTarget()
	if (not IsValid(ply) or not ply:Alive()) then
		return
	end

	local data = ply:GetRoleData()

	local y = ScrH() / 10
	local x = ScrW() / 2

	local _, h = draw.SimpleTextOutlined("Monke... Want... BANNA!", "chimp_header", x, y, ttt.roles.Monke.Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(12, 13, 15))
	y = y + h

	_, h = draw.SimpleTextOutlined("Find yummy banna! Grab yummy banna!", "chimp_small", x, y, white_text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(12, 13, 15))
	y = y + h

	_, h = draw.SimpleTextOutlined("Kill monke to steal yummy banna!", "chimp_small", x, y, white_text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(12, 13, 15))
	y = y + h
end

local function RenderStats(state)
	local y = ScrH() / 5
	local x = 4
	if (state.current_leader) then
		local _, h = draw.SimpleTextOutlined(state.current_leader, "chimp_small", x, y, ttt.roles["Banna Boss"].Color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(12, 13, 15))
		y = y + h
	end

	if (state.currency_left) then
		local _, h = draw.SimpleTextOutlined(string.format("%i banna left", state.currency_left), "chimp_small", x, y, ttt.roles.Child.Color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(12, 13, 15))
		y = y + h
	end

	if (state.currency_collected) then
		local _, h = draw.SimpleTextOutlined(string.format("%i banna finded", state.currency_collected), "chimp_small", x, y, ttt.roles.Monke.Color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(12, 13, 15))
		y = y + h
	end
end

net.Receive("chimp_data", function()
	if (not pluto.rounds.state) then
		return
	end

	local str = net.ReadString()
	if (str == "currency_left" or str == "currency_collected") then
		pluto.rounds.state[str] = net.ReadUInt(32)
	elseif (str == "current_leader") then
		pluto.rounds.state[str] = net.ReadString()
	end
end)

function ROUND:Prepare(state)
	state.Start = CurTime()
end

ROUND:Hook("HUDPaint", function(self, state)
	if (not pluto.rounds.state) then
		return
	end

	if (ttt.GetRoundState() == ttt.ROUNDSTATE_PREPARING) then
		RenderHeader(state)
	elseif (ttt.GetRoundState() == ttt.ROUNDSTATE_ACTIVE) then
		RenderRole(state)
		RenderStats(state)
	end
end)

ROUND:Hook("TTTBeginRound", function(self, state)
	EmitSound("pluto/dkrap.ogg", vector_origin, -2, CHAN_STATIC, 1)
end)

function ROUND:NotifyPrepare()
	chat.AddText(white_text, "In the distance, you start to hear shrieks... ", ttt.roles.Monke.Color, "OOK! OOK! AH AH AH!")
end
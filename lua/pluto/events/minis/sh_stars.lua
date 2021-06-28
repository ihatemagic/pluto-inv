-- Author: add___123

local name = "stars"

if (SERVER) then
	hook.Add("TTTBeginRound", "pluto_shooting_stars", function()
        if (not pluto.rounds or not pluto.rounds.minis or not pluto.rounds.minis[name]) then
            return
        end

		pluto.rounds.minis[name] = nil

		pluto.rounds.Notify("It's shooting stars!", pluto.currency.byname.stardust.Color)

		local count = #player.GetHumans()

		timer.Create("pluto_shooting_stars", math.max(3, 2 + count / 8), math.max(20 - count / 6, 15), function()
			for _, ply in pairs(player.GetHumans()) do
				if (not ply:Alive()) then
					continue
				end
				local e = pluto.currency.spawnfor(ply, "_shootingstar", nil, true)
				local target = ply:GetPos() + Vector(math.random(-80, 80), math.random(-80, 80), 0)
				local start = target + Vector(math.random(-500, 500), math.random(-500, 500), 350)
				e.SkipCrossmap = true
				e:SetPos(start)
				e:SetMovementType(CURRENCY_MOVEVECTOR)
				e:SetMovementVector((target - start):GetNormalized() * 2.5)
				e:Update()
			end
		end)
	end)
else

end
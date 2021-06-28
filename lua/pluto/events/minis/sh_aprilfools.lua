-- Author: Meepen

local name = "aprilfools"

if (SERVER) then
	hook.Add("TTTBeginRound", "pluto_mini_aprilfools", function()
        if (not pluto.rounds or not pluto.rounds.minis or not pluto.rounds.minis[name]) then
            return
        end

		pluto.rounds.minis[name] = nil

		--hook.Remove("TTTBeginRound", "pluto_mini_aprilfools")
		for _, ply in pairs(player.GetAll()) do
			for bone = 0, ply:GetBoneCount() - 1 do
				ply:ManipulateBoneJiggle(bone, 1)
			end
		end
	end)
else

end

-- Author: add___123

local name = "luck"

local time_limit = 20

if (SERVER) then
    util.AddNetworkString("pluto_mini_" .. name)

    local time = 0
    local player_times = {}
    local player_scores = {}
    local luck_active = false

    hook.Add("TTTBeginRound", "pluto_mini_" .. name, function()
        if (not pluto.rounds.minis[name]) then
            return
        end

		pluto.rounds.minis[name] = nil

        for k, ply in ipairs(player.GetAll()) do
            net.Start("pluto_mini_" .. name)
            net.Send(ply)  
            player_times[ply] = CurTime() + time_limit
            player_scores[ply] = 0
        end

        luck_active = true

        hook.Add("TTTEndRound", "pluto_mini_" .. name, function()
            hook.Remove("TTTEndRound", "pluto_mini_" .. name)
            player_times = {}
            player_scores = {}
            luck_active = false
        end)
    end)

    net.Receive("pluto_mini_" .. name, function(len, ply)
        if (not IsValid(ply) or not ply:Alive() or not luck_active) then
            return 
        end

        if (not player_times[ply] or player_times[ply] < CurTime()) then
            return
        end

        if (not player_scores[ply]) then
            player_scores[ply] = 0
        end

        if (math.random() < 0.4 + player_scores[ply]) then
            ply:Kill()
            pluto.rounds.Notify(ply:Nick() .. " has pushed their luck too far!", Color(200, 25, 50), nil, true)
        else
            pluto.db.instance(function(db)
                pluto.inv.addcurrency(db, ply, "tp", 5)
                pluto.rounds.Notify(ply:Nick() .. " has received 5 vials of refinium!", pluto.currency.byname.tp.Color, ply, true)
                net.Start("pluto_mini_" .. name)
                net.Send(ply)
                player_times[ply] = CurTime() + time_limit
                player_scores[ply] = player_scores[ply] + 0.1
            end)
        end
    end)
else
    net.Receive("pluto_mini_" .. name, function()
        local luckbutton = vgui.Create "pluto_mini_button"
        luckbutton:ChangeText "Press to push your luck! Danger of death."
        luckbutton:ChangeMini "luck"

        timer.Simple(time_limit - 1, function()
            if (IsValid(luckbutton)) then
                luckbutton:Remove()
            end
        end)
    end)
end
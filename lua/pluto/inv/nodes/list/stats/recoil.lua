local NODE = pluto.nodes.get "recoil"

NODE.Name = "Recoil Management"

function NODE:GetDescription(node)
	return string.format("Recoil is %.2f%% easier to control", 4 + node.node_val1 * 12)
end

function NODE:ModifyWeapon(node, wep)
	wep:DefinePlutoOverrides "ViewPunchAngles"
	wep.Pluto.ViewPunchAngles = wep.Pluto.ViewPunchAngles - (4 + node.node_val1 * 12) / 100
end

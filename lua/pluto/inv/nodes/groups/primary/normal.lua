local GROUP = pluto.nodes.groups.get("normal", 0)

GROUP.Guaranteed = {}

GROUP.SmallNodes = {
	damage = {
		Shares = 1,
		Max = 2,
	},
	distance = 2,
	firerate = {
		Shares = 1,
		Max = 2
	},
	mag = 1,
	recoil = 1,
	reloading = 1
}

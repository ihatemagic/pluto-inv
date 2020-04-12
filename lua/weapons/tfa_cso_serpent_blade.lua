SWEP.Base = "weapon_ttt_crowbar"
SWEP.Category = "TFA CS:O"
SWEP.PrintName = "Serpent Blade"

SWEP.ViewModel = "models/weapons/tfa_cso/c_serpent_blade.mdl"
SWEP.WorldModel = "models/weapons/tfa_cso/w_serpent_blade.mdl"
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 85
SWEP.UseHands = true
SWEP.Secondary.Animation = ACT_VM_RELOAD
SWEP.Secondary.Delay = 1.5


SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = -11,
		Right = 3,
		Forward = 4,
	},
	Ang = {
		Up = 90,
		Right = -10,
		Forward = 175
	},
	Scale = 1.35
}

sound.Add({
	['name'] = "SerpentBlade.Draw",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/tfa_cso/serpentblade/draw.ogg" },
	['pitch'] = {100,100}
})
sound.Add({
	['name'] = "SerpentBlade.Slash1",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/tfa_cso/serpentblade/slash_1.ogg" },
	['pitch'] = {100,100}
})
sound.Add({
	['name'] = "SerpentBlade.Slash2",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/tfa_cso/serpentblade/slash_2.ogg" },
	['pitch'] = {100,100}
})
sound.Add({
	['name'] = "SerpentBlade.Stab",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/tfa_cso/serpentblade/stab.ogg" },
	['pitch'] = {100,100}
})
sound.Add({
	['name'] = "SerpentBlade.HitFleshSlash1",
	['channel'] = CHAN_WEAPON,
	['sound'] = { "weapons/tfa_cso/serpentblade/hit.ogg"},
	['pitch'] = {100,100}
})
sound.Add({
	['name'] = "SerpentBlade.HitWall",
	['channel'] = CHAN_WEAPON,
	['sound'] = { "weapons/tfa_cso/serpentblade/wall.ogg" },
	['pitch'] = {100,100}
})


DEFINE_BASECLASS(SWEP.Base)
function SWEP:PrimaryAttack()
	BaseClass.PrimaryAttack(self)
	self:SetBulletsShot(self:GetBulletsShot() + 1)
end

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)
	self:NetVar("Secondary", "Float", math.huge)
end

function SWEP:MeleeAnimation(tr_main)
	local num = self:GetBulletsShot() % 2
	local stuff = {
		[0] = ACT_VM_PRIMARYATTACK,
		ACT_VM_SECONDARYATTACK
	}
	self:SendWeaponAnim(stuff[num])
end

function SWEP:SecondaryAttack()
	if (self:GetNextPrimaryFire() >= CurTime()) then
		return
	end

	self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
	self:SetSecondary(CurTime() + 0.58)
	self:SendWeaponAnim(ACT_VM_RELOAD)
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
end

function SWEP:Think()
	BaseClass.Think(self)
	if (self:GetSecondary() < CurTime()) then
		-- do attack
		self:SetSecondary(math.huge)
		local owner = self:GetOwner()
		owner:LagCompensation(true)
	
		local spos = owner:GetShootPos()
		local sdest = spos + owner:GetAimVector() * 120
	
		local tr_main = util.TraceLine {
			start = spos,
			endpos = sdest,
			filter = owner,
			mask = MASK_SHOT_HULL
		}

		owner:LagCompensation(false)

		self:HitEffects(tr_main)
		if (IsValid(tr_main.Entity)) then
			self:DoHit(tr_main.Entity, tr_main, 60)
		end
	end
end

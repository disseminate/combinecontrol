AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Knife";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 20;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/cstrike/c_knife_t.mdl";
SWEP.WorldModel 	= "models/weapons/w_knife_t.mdl";

SWEP.Firearm				= false;
SWEP.Melee					= true;

SWEP.Primary.Automatic		= true;

SWEP.HoldType = "knife";
SWEP.HoldTypeHolster = "normal";

SWEP.Holsterable = true;

SWEP.HolsterPos = Vector( 0, -11.6, 0 );
SWEP.HolsterAng = Vector( 0, 0, 0 );

SWEP.AimPos = Vector( 4.47, 8.04, -6.25 );
SWEP.AimAng = Vector( 11.25, 56.25, 24.11 );

SWEP.Itemize = true;
SWEP.ItemDescription = "It's a regular knife.";
SWEP.ItemWeight = 1;
SWEP.ItemFOV = 19;
SWEP.ItemCamPos = Vector( -0.89, 50, -0.89 );
SWEP.ItemLookAt = Vector( 0, 0, 8.04 );

SWEP.ItemBulkPrice		= 700;
SWEP.ItemLicense		= LICENSE_BLACK;

SWEP.SecondaryBlock = true;
SWEP.BlockMul = 0.5;

SWEP.Length = 50;
SWEP.SwingSound = { "weapons/knife/knife_slash1.wav", "weapons/knife/knife_slash2.wav" };
SWEP.HitFleshSound = { "weapons/knife/knife_hit1.wav", "weapons/knife/knife_hit2.wav", "weapons/knife/knife_hit3.wav", "weapons/knife/knife_hit4.wav" };
SWEP.HitWallSound = Sound( "weapons/knife/knife_hitwall1.wav" );
SWEP.DamageMul = 10;
SWEP.HitDelay = 0.5;
SWEP.MissDelay = 0.8;
SWEP.DamageType = DMG_SLASH;

function SWEP:AddViewKick()
	
	self.Owner:ViewPunch( Angle( 1.5, -1.5, 0 ) );
	
end
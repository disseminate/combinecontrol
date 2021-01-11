AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= ".357 Magnum";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 3;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_357.mdl";
SWEP.WorldModel 	= "models/weapons/w_357.mdl";

SWEP.Firearm				= true;

SWEP.Primary.ClipSize 		= 6;
SWEP.Primary.DefaultClip 	= 6;
SWEP.Primary.Ammo			= "cc_357";
SWEP.Primary.InfiniteAmmo	= true;
SWEP.Primary.Automatic		= false;
SWEP.Primary.Sound			= "Weapon_357.Single";
SWEP.Primary.Damage			= 30;
SWEP.Primary.Force			= 12;
SWEP.Primary.Accuracy		= 0.05;
SWEP.Primary.Delay			= 0.75;
SWEP.Primary.ViewPunch		= Angle( -8, 0, 0 );
SWEP.Primary.ReloadSound	= "Weapon_357.Reload";

SWEP.HoldType = "revolver";
SWEP.HoldTypeHolster = "normal";

SWEP.Holsterable = true;
SWEP.HolsterUseAnim = true;

SWEP.HolsterPos = Vector();
SWEP.HolsterAng = Vector();

SWEP.AimPos = Vector( -4.59, 0.7, 0 );
SWEP.AimAng = Vector( 0, 0, 1.36 );

SWEP.Itemize = true;
SWEP.ItemDescription = "A Colt Python revolver. Chambered for the .357 Magnum cartridge. Quick, accurate, and deadly - this is one bigass gun.";
SWEP.ItemWeight = 5;
SWEP.ItemFOV = 18;
SWEP.ItemCamPos = Vector( 2.13, 50, -0.93 );
SWEP.ItemLookAt = Vector( 6.6, 0, 0 );

SWEP.ItemBulkPrice		= 4000;
SWEP.ItemLicense		= LICENSE_BLACK;

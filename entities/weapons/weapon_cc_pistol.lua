AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Combine Standard Issue Sidearm";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 2;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_pistol.mdl";
SWEP.WorldModel 	= "models/weapons/w_pistol.mdl";

SWEP.Firearm				= true;

SWEP.Primary.ClipSize 		= 18;
SWEP.Primary.DefaultClip 	= 18;
SWEP.Primary.Ammo			= "cc_pistol";
SWEP.Primary.InfiniteAmmo	= true;
SWEP.Primary.Automatic		= false;
SWEP.Primary.Sound			= "Weapon_Pistol.Single";
SWEP.Primary.Damage			= 5;
SWEP.Primary.Force			= 0.73;
SWEP.Primary.Accuracy		= 0.1;
SWEP.Primary.Delay			= 0.05;
SWEP.Primary.ReloadSound	= "Weapon_Pistol.Reload";

SWEP.HoldType = "revolver";
SWEP.HoldTypeHolster = "normal";

SWEP.Holsterable = true;
SWEP.HolsterUseAnim = true;

SWEP.HolsterPos = Vector();
SWEP.HolsterAng = Vector();

SWEP.AimPos = Vector( -5.92, 3.12, -4.34 );
SWEP.AimAng = Vector( 0.11, -1.28, 1.66 );

SWEP.Itemize = true;
SWEP.ItemDescription = "The Combine variant of the USP Match is chambered for 9x19mm Parabellum rounds. It's the Combine Civil Authority's standard sidearm.";
SWEP.ItemWeight = 2;
SWEP.ItemFOV = 13;
SWEP.ItemCamPos = Vector( -3.34, 50, -5.8 );
SWEP.ItemLookAt = Vector( 0, 0, -1.32 );

SWEP.ItemBulkPrice		= 1500;
SWEP.ItemLicense		= LICENSE_BLACK;

function SWEP:AddViewKick()
	
	self.Owner:ViewPunch( Angle( math.Rand( 0.25, 0.5 ), math.Rand( -0.6, 0.6 ), 0 ) );
	
end


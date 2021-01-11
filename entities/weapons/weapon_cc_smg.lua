AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "SMG";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 4;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_smg1.mdl";
SWEP.WorldModel 	= "models/weapons/w_smg1.mdl";

SWEP.Firearm				= true;

SWEP.Primary.ClipSize 		= 45;
SWEP.Primary.DefaultClip 	= 45;
SWEP.Primary.Ammo			= "cc_smg";
SWEP.Primary.InfiniteAmmo	= true;
SWEP.Primary.Automatic		= true;
SWEP.Primary.Sound			= "Weapon_SMG1.Single";
SWEP.Primary.Damage			= 4;
SWEP.Primary.Force			= 0.73;
SWEP.Primary.Accuracy		= 0.1;
SWEP.Primary.Delay			= 0.075;
SWEP.Primary.ViewPunch		= Angle( -1, 0, 0 );
SWEP.Primary.ReloadSound	= "Weapon_SMG1.Reload";

SWEP.HoldType = "smg";
SWEP.HoldTypeHolster = "passive";

SWEP.Holsterable = true;

SWEP.HolsterPos = Vector( 8.04, -2.67, -9.82 );
SWEP.HolsterAng = Vector( 4.83, 46.61, 4.83 );

SWEP.AimPos = Vector( -6.48, 1.56, -3.49 );
SWEP.AimAng = Vector( -2.3, -0.23, 0.01 );

SWEP.Itemize = true;
SWEP.ItemDescription = "The H&K MP7 has become the firearm of choice for use by the Combine Civil Authority.";
SWEP.ItemWeight = 6;
SWEP.ItemFOV = 25;
SWEP.ItemCamPos = Vector( -2.94, 50, 0.27 );
SWEP.ItemLookAt = Vector( -1.44, 0, 0 );

SWEP.ItemBulkPrice		= 3000;
SWEP.ItemLicense		= LICENSE_BLACK;

function SWEP:AddViewKick()
	
	--self.Owner:ViewPunch( Angle( -1, math.Rand( -0.5, 0.5 ), 0 ) );
	self:DoMachineGunKick( 0.5, 1, self.Primary.Delay, 2 );
	
end

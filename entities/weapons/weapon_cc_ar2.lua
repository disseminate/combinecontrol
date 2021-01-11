AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "AR2";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 5;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_irifle.mdl";
SWEP.WorldModel 	= "models/weapons/w_irifle.mdl";

SWEP.Firearm				= true;

SWEP.Primary.ClipSize 		= 30;
SWEP.Primary.DefaultClip 	= 30;
SWEP.Primary.Ammo			= "cc_ar2";
SWEP.Primary.InfiniteAmmo	= true;
SWEP.Primary.Automatic		= true;
SWEP.Primary.Sound			= "Weapon_AR2.Single";
SWEP.Primary.Damage			= 8;
SWEP.Primary.Force			= 0.73;
SWEP.Primary.Accuracy		= 0.1;
SWEP.Primary.Delay			= 0.1;
SWEP.Primary.ViewPunch		= Angle( -2, 0, 0 );
SWEP.Primary.ReloadSound	= "Weapon_AR2.Reload";
SWEP.Primary.TracerName		= "AR2Tracer";

SWEP.HoldType = "ar2";
SWEP.HoldTypeHolster = "passive";

SWEP.Holsterable = true;

SWEP.HolsterPos = Vector( 13.11, -4.69, -25.91 );
SWEP.HolsterAng = Vector( 6.19, 80.14, 0 );

SWEP.AimPos = Vector( -5.8, 1.29, -5.18 );
SWEP.AimAng = Vector( 0, 0, 0 );

SWEP.Itemize = true;
SWEP.ItemDescription = "The Overwatch Standard Issue Pulse Rifle. Using deadly pulse rounds, the AR2 rifle is designed for use exclusively by the Combine Overwatch Transhuman Arm.";
SWEP.ItemWeight = 7;
SWEP.ItemFOV = 43;
SWEP.ItemCamPos = Vector( -1.12, 50, -0.82 );
SWEP.ItemLookAt = Vector( 5.09, 0, 0 );

function SWEP:AddViewKick()
	
	--self.Owner:ViewPunch( Angle( -2, math.Rand( -0.5, 0.5 ), 0 ) );
	self:DoMachineGunKick( 0.5, 8, self.Primary.Delay, 5 );
	
end


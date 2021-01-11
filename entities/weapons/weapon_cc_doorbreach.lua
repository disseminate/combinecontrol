AddCSLuaFile();

SWEP.Base			= "weapon_cc_shotgun";

SWEP.PrintName 		= "Door Breaching Shotgun";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 8;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_shotgun.mdl";
SWEP.WorldModel 	= "models/weapons/w_shotgun.mdl";

SWEP.Firearm				= true;

SWEP.Primary.ClipSize 		= 6;
SWEP.Primary.DefaultClip 	= 6;
SWEP.Primary.Ammo			= "cc_shotgun";
SWEP.Primary.InfiniteAmmo	= true;
SWEP.Primary.Automatic		= false;
SWEP.Primary.Sound			= "Weapon_Shotgun.Single";
SWEP.Primary.Damage			= 8;
SWEP.Primary.Force			= 2;
SWEP.Primary.NumBullets		= 1;
SWEP.Primary.Accuracy		= 0.08716;
SWEP.Primary.Delay			= 0.7;
SWEP.Primary.ViewPunch		= Angle( -10, 0, 0 );
SWEP.Primary.ReloadSound	= "Weapon_Shotgun.Reload";

SWEP.HoldType = "shotgun";
SWEP.HoldTypeHolster = "passive";

SWEP.Holsterable = true;
SWEP.HolsterUseAnim = true;

SWEP.HolsterPos = Vector();
SWEP.HolsterAng = Vector();

SWEP.AimPos = Vector( -8.95, 4.19, -6.76 );
SWEP.AimAng = Vector( 0, 0, 0 );

SWEP.Itemize = true;
SWEP.ItemDescription = "This shotgun is loaded with door breaching rounds instead of buckshot. Designed to blow open doors without risk of ricochet, it does what's on the label.";
SWEP.ItemWeight = 10;
SWEP.ItemFOV = 37;
SWEP.ItemCamPos = Vector( -0.79, 50, 5.13 );
SWEP.ItemLookAt = Vector( 0, 0, 0 );

function SWEP:ShootBullet( damage, force, n, aimcone )
	
	local bullet 	= { };
	bullet.Num 		= n or 1;
	bullet.Src 		= self.Owner:GetShootPos();
	bullet.Dir 		= self.Owner:GetAimVector();
	bullet.Spread 	= Vector( aimcone, aimcone, 0 );
	bullet.Tracer	= 1;
	bullet.Force	= force;
	bullet.Damage	= damage;
	bullet.AmmoType = "Pistol";
	
	bullet.Callback = function( ply, tr, dmg )
		
		if( CLIENT ) then return end
		
		if( tr.Entity and tr.Entity:IsValid() ) then
			
			if( tr.Entity:GetPos():Distance( ply:GetShootPos() ) > 150 ) then return end
			
			if( tr.Entity:GetClass() == "prop_door_rotating" ) then
				
				GAMEMODE:ExplodeDoor( tr.Entity, tr.Normal );
				
			end
			
		end
		
	end
	
	self.Owner:FireBullets( bullet );
	
end

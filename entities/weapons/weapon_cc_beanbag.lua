AddCSLuaFile();

SWEP.Base			= "weapon_cc_shotgun";

SWEP.PrintName 		= "Beanbag Shotgun";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 7;

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
SWEP.Primary.Damage			= 0;
SWEP.Primary.Force			= 1;
SWEP.Primary.NumBullets		= 1;
SWEP.Primary.Accuracy		= 0.16;
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
SWEP.ItemDescription = "This shotgun is loaded with beanbag rounds instead of buckshot. The beanbag isn't nearly as lethal, but is certain to make you fall over.";
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
			
			if( tr.Entity:GetPos():Distance( ply:GetShootPos() ) > 840 ) then return end
			
			if( tr.Entity:IsPlayer() ) then
				
				tr.Entity:TakeCDamage( 100 );
				
			elseif( tr.Entity:GetClass() == "prop_ragdoll" and tr.Entity:PropFakePlayer() and tr.Entity:PropFakePlayer():IsValid() ) then
				
				tr.Entity:PropFakePlayer():TakeCDamage( 100 );
				
			elseif( tr.Entity:IsVehicle() and tr.Entity:GetDriver() and tr.Entity:GetDriver():IsValid() ) then
				
				tr.Entity:GetDriver():TakeCDamage( 100 );
				
			end
			
		end
		
	end
	
	self.Owner:FireBullets( bullet );
	
end

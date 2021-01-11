AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Flare Gun";
SWEP.Slot 			= 1;
SWEP.SlotPos 		= 3;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_pistol.mdl";
SWEP.WorldModel 	= "models/weapons/w_pistol.mdl";

SWEP.Firearm				= true;

SWEP.Primary.ClipSize 		= 1;
SWEP.Primary.DefaultClip 	= 1;
SWEP.Primary.Ammo			= "cc_pistol";
SWEP.Primary.InfiniteAmmo	= true;
SWEP.Primary.Automatic		= false;
SWEP.Primary.Sound			= "Weapon_FlareGun.Single";
SWEP.Primary.Damage			= 5;
SWEP.Primary.Force			= 0.73;
SWEP.Primary.Accuracy		= 0.1;
SWEP.Primary.Delay			= 0.05;
SWEP.Primary.ViewPunch		= Angle( -16, 0, 0 );
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
SWEP.ItemDescription = "The Combine Standard Flare Gun is a tactical device used to signal a position of interest to other units instantly.";
SWEP.ItemWeight = 2;
SWEP.ItemFOV = 13;
SWEP.ItemCamPos = Vector( -3.34, 50, -5.8 );
SWEP.ItemLookAt = Vector( 0, 0, -1.32 );

SWEP.FlammableMaterials = {
	MAT_ALIENFLESH,
	MAT_ANTLION,
	MAT_BLOODYFLESH,
	MAT_EGGSHELL,
	MAT_FLESH,
	MAT_FOLIAGE,
	MAT_VENT,
	MAT_WOOD
};

function SWEP:PrimaryUnholstered()
	
	if( self:CanPrimaryAttack() ) then
		
		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay );
		
		self.CanReload = true;
		
		self.Weapon:EmitSound( self.Primary.Sound );
		
		self:ShootEffects();
		
		local vecShoot = self.Owner:GetVelocity() * 0.5 + self.Owner:GetAimVector() * 2000;
		
		local e = EffectData();
			e:SetOrigin( self.Owner:GetShootPos() );
			e:SetStart( vecShoot );
		util.Effect( "cc_e_flare", e );
		
		local trace = { };
		trace.start = self.Owner:GetShootPos();
		trace.endpos = trace.start + self.Owner:GetAimVector() * 400;
		trace.filter = self.Owner;
		
		local tr = util.TraceLine( trace );
		
		if( SERVER and tr.Entity and tr.Entity:IsValid() and !tr.Entity:IsPlayer() ) then
			
			if( table.HasValue( self.FlammableMaterials, tr.MatType ) ) then
				
				tr.Entity:Ignite( math.random( 15, 30 ), 0 );
				
			end
			
		end
		
		self:TakePrimaryAmmo( 1 );
		
		self.Owner:ViewPunch( self.Primary.ViewPunch );
		
		self:Idle();
		
	end
	
end

AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Rocket-Propelled Grenade Launcher";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 14;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_rpg.mdl";
SWEP.WorldModel 	= "models/weapons/w_rocket_launcher.mdl";

SWEP.HoldType = "rpg";
SWEP.HoldTypeHolster = "passive";

SWEP.Holsterable = true;
SWEP.Firearm = true;

SWEP.Primary.ClipSize 		= 1;
SWEP.Primary.DefaultClip 	= 0;
SWEP.Primary.InfiniteAmmo	= true;

SWEP.HolsterPos = Vector( 17.61, -6.85, -21.95 );
SWEP.HolsterAng = Vector( -27.25, 58.67, -0.03 );

SWEP.AimPos = Vector();
SWEP.AimAng = Vector();

SWEP.Itemize = true;
SWEP.ItemDescription = "A rocket-propelled grenade launcher. Used for anti-armored combat.";
SWEP.ItemWeight = 9;
SWEP.ItemFOV = 50;
SWEP.ItemCamPos = Vector( 21.85, 50, 0 );
SWEP.ItemLookAt = Vector( 18.77, 0, 4.15 );

function SWEP:CreateMissile( pos, ang )
	
	self.Missile = ents.Create( "rpg_missile" );
	self.Missile:SetPos( pos );
	self.Missile:SetAngles( ang );
	self.Missile:SetOwner( self.Owner );
	self.Missile:Spawn();
	self.Missile:Activate();
	self.Missile:SetSaveValue( "m_flDamage", 200 );
	
	local fwd = ang:Forward();
	
	self.Missile:SetVelocity( fwd * 300 + Vector( 0, 0, 128 ) );
	
	return self.Missile;
	
end

function SWEP:PrimaryUnholstered()
	
	if( !self:CanPrimaryAttack() ) then return end
	
	if( SERVER ) then
		
		local muzzlePoint = self.Owner:GetShootPos() + self.Owner:GetForward() * 12 + self.Owner:GetRight() * 6 + self.Owner:GetUp() * 3;
		
		local vecAngles = self.Owner:GetAimVector():Angle();
		
		self:CreateMissile( muzzlePoint, vecAngles );
		
	end
	
	self:SendWeaponAnimShared( ACT_VM_PRIMARYATTACK );
	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	
	self:PlaySound( "Weapon_RPG.Single" );
	
	self:TakePrimaryAmmo( 1 );
	self:SetNextPrimaryFire( CurTime() + 0.5 );
	self:Idle();
	
end

function SWEP:Reload()
	
	if( self:Clip1() == 0 and self.Owner:HasItem( "rpg" ) ) then
		
		self:SetClip1( 1 );
		
		if( SERVER ) then
			
			self.Owner:RemoveItem( self.Owner:GetInventoryItem( "rpg" ) );
			
		end
		
		self:SendWeaponAnimShared( ACT_VM_RELOAD );
		self.Owner:SetAnimation( PLAYER_RELOAD );
		
		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
		
	end
	
end
AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Stunbaton";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 1;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_stunstick.mdl";
SWEP.WorldModel 	= "models/weapons/w_stunbaton.mdl";

SWEP.Firearm				= false;

SWEP.Primary.ClipSize 		= 1;
SWEP.Primary.DefaultClip 	= 1;
SWEP.Primary.Ammo			= "cc_none";
SWEP.Primary.Automatic		= true;

SWEP.HoldType = "melee";
SWEP.HoldTypeHolster = "normal";

SWEP.Holsterable = true;
SWEP.HolsterUseAnim = true;

SWEP.HolsterPos = Vector();
SWEP.HolsterAng = Vector();

SWEP.AimPos = Vector( -18.21, 6.34, -2.16 );
SWEP.AimAng = Vector( 7.24, 0, -71.13 );

SWEP.SecondaryBlock = true;
SWEP.BlockMul = 0.3;

SWEP.Itemize = true;
SWEP.ItemDescription = "A stunstick. Crowd-control bludgeon of choice of the Combine Civil Authority.";
SWEP.ItemWeight = 2;
SWEP.ItemFOV = 14;
SWEP.ItemCamPos = Vector( 50, 50, 50 );
SWEP.ItemLookAt = Vector( 0, 0, 0 );

SWEP.ItemBulkPrice		= 1000;
SWEP.ItemLicense		= LICENSE_BLACK;

SWEP.InfoText = [[Holstered - Primary: Nothing.
Holstered - Secondary: Nothing.
Unholstered - Primary: Swing.
Unholstered - Secondary: Block.]];

SWEP.HitSounds = {
	"weapons/stunstick/stunstick_fleshhit1.wav",
	"weapons/stunstick/stunstick_fleshhit2.wav"
}

SWEP.SwingSounds = {
	"weapons/stunstick/stunstick_swing1.wav",
	"weapons/stunstick/stunstick_swing2.wav"
}

function SWEP:Precache()
	
	for _, v in pairs( self.HitSounds ) do
		
		util.PrecacheSound( v );
		
	end
	
	for _, v in pairs( self.SwingSounds ) do
		
		util.PrecacheSound( v );
		
	end
	
end

function SWEP:PrimaryUnholstered()
	
	self:SetNextPrimaryFire( CurTime() + 0.6 );
	
	if( self.Owner:KeyDown( IN_ATTACK2 ) ) then return end
	
	self:PlaySound( table.Random( self.SwingSounds ), 74, math.random( 90, 110 ) );
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	
	local trace = { };
	trace.start = self.Owner:GetShootPos();
	trace.endpos = trace.start + self.Owner:GetAimVector() * 50;
	trace.filter = self.Owner;
	trace.mins = Vector( -8, -8, -8 );
	trace.maxs = Vector( 8, 8, 8 );
	
	local tr = util.TraceHull( trace );
	
	if( tr.Hit ) then
		
		self:SendWeaponAnimShared( ACT_VM_HITCENTER );
		
	else
		
		self:SendWeaponAnimShared( ACT_VM_MISSCENTER );
		
	end
	
	self:Idle();
	
	self.Owner:ViewPunch( Angle( 9, 6, 0 ) );
	
	self:HitDamage();
	
end

function SWEP:HitDamage()
	
	if( CLIENT ) then return end
	
	local trace = { };
	trace.start = self.Owner:GetShootPos();
	trace.endpos = trace.start + self.Owner:GetAimVector() * 50;
	trace.filter = self.Owner;
	trace.mins = Vector( -8, -8, -8 );
	trace.maxs = Vector( 8, 8, 8 );
	
	local tr = util.TraceHull( trace );
	
	if( tr.Hit ) then
		
		self:PlaySound( table.Random( self.HitSounds ), 74, math.random( 90, 110 ) );
		
		if( tr.Entity and tr.Entity:IsValid() ) then
			
			if( !self.Owner.NextStrength ) then self.Owner.NextStrength = 0 end
			
			if( CurTime() >= self.Owner.NextStrength ) then
				
				self.Owner:SetStrength( math.Clamp( self.Owner:Strength() + GAMEMODE:ScaledStatIncrease( self.Owner, self.Owner:Strength() ) * 0.05, 0, 100 ) );
				self.Owner:UpdateCharacterField( "StatStrength", tostring( self.Owner:Strength() ), true );
				
				self.Owner.NextStrength = CurTime() + 10;
				
			end
			
			local blockmul = 1;
			
			if( tr.Entity:IsPlayer() ) then
				
				if( tr.Entity:GetActiveWeapon() and tr.Entity:GetActiveWeapon():IsValid() ) then
					
					if( tr.Entity:GetActiveWeapon().IsBlocking and tr.Entity:GetActiveWeapon():IsBlocking() ) then
						
						blockmul = tr.Entity:GetActiveWeapon().BlockMul;
						
					end
					
				end
				
			end
			
			if( tr.Entity:IsPlayer() ) then
				
				local dmg = ( 25 + math.Round( self.Owner:Strength() * 0.2 ) ) * blockmul;
				
				if( tr.Entity:HasTrait( TRAIT_CONDUCTOR ) ) then dmg = dmg * 1.25; end
				if( tr.Entity:HasTrait( TRAIT_ROCKY ) ) then dmg = dmg * 0.75; end
				if( tr.Entity:HasTrait( TRAIT_LOYALIST ) ) then dmg = dmg * 2; end
				
				tr.Entity:TakeCDamage( math.floor( dmg ) );
				
				local dmg = DamageInfo();
				dmg:SetAttacker( self.Owner );
				dmg:SetDamage( 0 );
				dmg:SetDamageForce( tr.Normal * 100 );
				dmg:SetDamagePosition( tr.HitPos );
				dmg:SetDamageType( DMG_SHOCK );
				dmg:SetInflictor( self );
				
				tr.Entity:DispatchTraceAttack( dmg, tr );
				
				net.Start( "nFlashRed" );
				net.Send( tr.Entity );
				
			elseif( tr.Entity:GetClass() == "prop_ragdoll" and tr.Entity:PropFakePlayer() and tr.Entity:PropFakePlayer():IsValid() ) then
				
				local dmg = ( 25 + math.Round( self.Owner:Strength() * 0.2 ) ) * blockmul;
				
				if( tr.Entity:PropFakePlayer():HasTrait( TRAIT_CONDUCTOR ) ) then dmg = dmg * 1.25; end
				if( tr.Entity:PropFakePlayer():HasTrait( TRAIT_ROCKY ) ) then dmg = dmg * 0.75; end
				if( tr.Entity:PropFakePlayer():HasTrait( TRAIT_LOYALIST ) ) then dmg = dmg * 2; end
				
				tr.Entity:PropFakePlayer():TakeCDamage( math.floor( dmg ) );
				
			elseif( tr.Entity:IsVehicle() and tr.Entity:GetDriver() and tr.Entity:GetDriver():IsValid() ) then
				
				local dmg = ( 25 + math.Round( self.Owner:Strength() * 0.2 ) ) * blockmul;
				
				if( tr.Entity:GetDriver():HasTrait( TRAIT_CONDUCTOR ) ) then dmg = dmg * 1.25; end
				if( tr.Entity:GetDriver():HasTrait( TRAIT_ROCKY ) ) then dmg = dmg * 0.75; end
				if( tr.Entity:GetDriver():HasTrait( TRAIT_LOYALIST ) ) then dmg = dmg * 2; end
				
				tr.Entity:GetDriver():TakeCDamage( math.floor( dmg ) );
				
			else
				
				local dmg = DamageInfo();
				dmg:SetAttacker( self.Owner );
				dmg:SetDamage( 10 * blockmul );
				dmg:SetDamageForce( tr.Normal * 100 );
				dmg:SetDamagePosition( tr.HitPos );
				dmg:SetDamageType( DMG_SHOCK );
				dmg:SetInflictor( self );
				
				if( tr.Entity.DispatchTraceAttack ) then
					
					tr.Entity:DispatchTraceAttack( dmg, tr );
					
				end
				
			end
			
		end
		
	end
	
end

function SWEP:AddViewKick()
	
	self.Owner:ViewPunch( Angle( math.Rand( 1, 2 ), math.Rand( -2, -1 ), 0 ) );
	
end

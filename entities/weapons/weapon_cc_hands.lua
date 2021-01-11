AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Hands";
SWEP.Slot 			= 1;
SWEP.SlotPos 		= 1;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_arms_citizen.mdl";
SWEP.WorldModel 	= "";

SWEP.HoldType = "fist";
SWEP.HoldTypeHolster = "normal";

SWEP.DrawAnim = "fists_draw";
SWEP.HolsterAnim = "fists_holster";

SWEP.Holsterable = true;
SWEP.HolsterUseAnim = true;

SWEP.HolsterPos = Vector();
SWEP.HolsterAng = Vector();

SWEP.AimPos = Vector( -2.93, 2.81, -4.24 );
SWEP.AimAng = Vector( -0.81, 0, 0 );

SWEP.SecondaryBlock = true;
SWEP.BlockMul = 0.5;

SWEP.InfoText = [[Holstered - Primary: Knock on doors.
Holstered - Secondary: Nothing.
Unholstered - Primary: Punch.
Unholstered - Secondary: Block.
Reload: Ram door.]];

SWEP.UnholsterText = "Your fists are raised! Press B to put them down.";

SWEP.AttackAnims = { 
	{ "fists_left", Angle( 0, -10, 0 ) },
	{ "fists_right", Angle( 0, 10, 0 ) },
	{ "fists_uppercut", Angle( -7, 2, 0 ) } };
	
SWEP.HitSounds = {
	"npc/vort/foot_hit.wav",
	"weapons/crossbow/hitbod1.wav",
	"weapons/crossbow/hitbod2.wav"
}

SWEP.SwingSounds = {
	"npc/vort/claw_swing1.wav",
	"npc/vort/claw_swing2.wav"
}

function SWEP:Initialize()
	
	self:SetWeaponHoldType( self.HoldType );
	self:SetWeaponHoldTypeHolster( self.HoldTypeHolster );
	
	if( !GAMEMODE.DoorRammingEnabled ) then
		
		self.InfoText = [[Holstered - Primary: Knock on doors.
Holstered - Secondary: Nothing.
Unholstered - Primary: Punch.
Unholstered - Secondary: Block.]];
		
	end
	
end

function SWEP:Precache()
	
	util.PrecacheSound( "physics/wood/wood_crate_impact_hard2.wav" );
	
	util.PrecacheSound( "doors/door_latch3.wav" );
	util.PrecacheSound( "doors/door_locked2.wav" );
	
	for _, v in pairs( self.HitSounds ) do
		
		util.PrecacheSound( v );
		
	end
	
	for _, v in pairs( self.SwingSounds ) do
		
		util.PrecacheSound( v );
		
	end
	
end

function SWEP:IdleNow()
	
	local vm = self.Owner:GetViewModel();
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) );
	
end

function SWEP:PreDrawViewModel( vm, wep, ply )

	vm:SetMaterial( "engine/occlusionproxy" ) -- Hide that view model with hacky material

end

function SWEP:PrimaryHolstered()
	
	local tr = GAMEMODE:GetHandTrace( self.Owner );
	
	if( tr.Entity and tr.Entity:IsValid() and tr.Entity:IsDoor() ) then
		
		self:PlaySound( "physics/wood/wood_crate_impact_hard2.wav", 70, math.random( 95, 105 ) );
		
		self:SetNextPrimaryFire( CurTime() + 0.1 );
		
	end
	
end

function SWEP:PrimaryUnholstered()
	
	if( self.Owner:KeyDown( IN_ATTACK2 ) ) then return end
	
	self:SetNextPrimaryFire( CurTime() + 0.6 );
	self:SetNextSecondaryFire( CurTime() + 0.6 );
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	
	self:PlaySound( table.Random( self.SwingSounds ), 74, math.random( 90, 110 ) );
	
	local vm = self.Owner:GetViewModel();
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_01" ) );
	
	local anim = table.Random( self.AttackAnims );
	
	timer.Simple( 0, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		
		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence( vm:LookupSequence( anim[1] ) );
		
		self:Idle();
	end )
	
	timer.Simple( 0.1, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		
		self.Owner:ViewPunch( anim[2] );
	end )
	
	timer.Simple( 0.15, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		
		self:FistDamage();
	end )
	
end

function SWEP:FistDamage()
	
	if( CLIENT ) then return end
	
	self.Owner:LagCompensation( true );
	
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
				
				self.Owner:SetStrength( math.Clamp( self.Owner:Strength() + GAMEMODE:ScaledStatIncrease( self.Owner, self.Owner:Strength() ) * 0.025, 0, 100 ) );
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
			
			if( GAMEMODE.FistsHaveEffectOnPlayers ) then
				
				if( tr.Entity:IsPlayer() ) then
					
					local dmg = ( 5 + math.Round( self.Owner:Strength() * 0.05 ) ) * blockmul;
					
					if( tr.Entity:HasTrait( TRAIT_CONDUCTOR ) ) then dmg = dmg * 1.25; end
					if( tr.Entity:HasTrait( TRAIT_ROCKY ) ) then dmg = dmg * 0.75; end
					
					tr.Entity:TakeCDamage( math.floor( dmg ) );
					
					net.Start( "nFlashRed" );
					net.Send( tr.Entity );
					
				elseif( tr.Entity:GetClass() == "prop_ragdoll" and tr.Entity:PropFakePlayer() and tr.Entity:PropFakePlayer():IsValid() ) then
					
					local dmg = ( 5 + math.Round( self.Owner:Strength() * 0.05 ) ) * blockmul;
					
					if( tr.Entity:PropFakePlayer():HasTrait( TRAIT_CONDUCTOR ) ) then dmg = dmg * 1.25; end
					if( tr.Entity:PropFakePlayer():HasTrait( TRAIT_ROCKY ) ) then dmg = dmg * 0.75; end
					
					tr.Entity:PropFakePlayer():TakeCDamage( math.floor( dmg ) );
					
				elseif( tr.Entity:IsVehicle() and tr.Entity:GetDriver() and tr.Entity:GetDriver():IsValid() ) then
					
					local dmg = ( 5 + math.Round( self.Owner:Strength() * 0.05 ) ) * blockmul;
					
					if( tr.Entity:GetDriver():HasTrait( TRAIT_CONDUCTOR ) ) then dmg = dmg * 1.25; end
					if( tr.Entity:GetDriver():HasTrait( TRAIT_ROCKY ) ) then dmg = dmg * 0.75; end
					
					tr.Entity:GetDriver():TakeCDamage( math.floor( dmg ) );
					
				end
				
			end
			
			local dmg = DamageInfo();
			dmg:SetAttacker( self.Owner );
			dmg:SetDamage( 0 );
			dmg:SetDamageForce( Vector( 0, 0, 1 ) );
			dmg:SetDamagePosition( tr.Entity:GetPos() );
			dmg:SetDamageType( DMG_CLUB );
			dmg:SetInflictor( self );
			
			tr.Entity:TakeDamageInfo( dmg );
			
		end
		
	end
	
	self.Owner:LagCompensation( false );
	
end

function SWEP:Reload()
	
	if( !GAMEMODE.DoorRammingEnabled ) then return end
	
	if( !self.NextReload ) then self.NextReload = CurTime() end
	
	if( CurTime() < self.NextReload ) then return end
	
	local tr = GAMEMODE:GetHandTrace( self.Owner, 128 );
	tr.Normal.z = 0;
	
	if( self.Owner:PassedOut() ) then return end
	if( self.Owner:TiedUp() ) then return end
	if( self.Owner:MountedGun() and self.Owner:MountedGun():IsValid() ) then return end
	if( self.Owner:Crouching() ) then return end
	if( !self.Owner:OnGround() ) then return end
	if( self.Owner:GetVelocity():Length() > 50 ) then return end
	
	if( tr.Entity and tr.Entity:IsValid() and ( tr.Entity:GetClass() == "prop_door_rotating" or ( tr.Entity:GetClass() == "func_door_rotating" and tr.Entity:DoorType() != DOOR_COMBINEOPEN ) ) and tr.Fraction > 0.2 ) then
		
		if( self.Owner:Strength() < 40 and !GAMEMODE:LookupCombineFlag( self.Owner:ActiveFlag() ) ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're not strong enough to ram this door!", { CB_ALL, CB_IC } );
				
			end
			
			self.NextReload = CurTime() + 2;
			return;
			
		end
		
		if( SERVER ) then
			
			self.Owner:SetAnimation( PLAYER_ATTACK1 );
			
			self.NextReload = CurTime() + 2;
			
			if( self.Owner:Health() > 40 ) then
				
				self.Owner:TakeDamage( 5, tr.Entity, tr.Entity );
				net.Start( "nFlashRed" );
				net.Send( self.Owner );
				
			end
			
			self.Owner:SetVelocity( tr.Normal * 1000 );
			self.Owner:ViewPunch( Angle( -25, 0, 0 ) );
			
			tr.Entity:EmitSound( "physics/wood/wood_crate_impact_hard" .. table.Random( { "1", "4", "5" } ) .. ".wav" );
			
			local n = math.ceil( 10 - ( self.Owner:Strength() * 0.08 ) );
			
			if( !tr.Entity:GetSaveTable().m_bLocked ) then
				
				n = math.ceil( 2 - ( self.Owner:Strength() * 0.01 ) );
				
			end
			
			if( math.random( 1, n ) == 1 ) then
				
				tr.Entity:EmitSound( "physics/wood/wood_crate_break" .. math.random( 1, 5 ) .. ".wav" );
				
				tr.Entity:Fire( "Unlock" );
				
				timer.Simple( 0, function()
					
					if( tr.Entity and tr.Entity:IsValid() and self and self:IsValid() and self.Owner and self.Owner:IsValid() ) then
						
						tr.Entity:Input( "Use", self.Owner, self );
						
					end
					
				end );
				
			end
			
		end
		
	end
	
end

function SWEP:SecondaryUnholstered()
	
	
	
end

function SWEP:HolsterChild()
	
	self:OnRemove();
	
end

function SWEP:OnRemove()
	
	if( self.Owner and self.Owner:IsValid() ) then
		
		local vm = self.Owner:GetViewModel();
		
		if( vm and vm:IsValid() ) then
			
			vm:SetMaterial( "" );
			
		end
		
	end
	
	timer.Stop( "cc_weapon_idle" .. self:EntIndex() );

end

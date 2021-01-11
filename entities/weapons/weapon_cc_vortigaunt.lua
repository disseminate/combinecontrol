AddCSLuaFile();

PrecacheParticleSystem( "vortigaunt_charge_token" );
PrecacheParticleSystem( "vortigaunt_beam" );

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Vortigaunt";
SWEP.Slot 			= 1;
SWEP.SlotPos 		= 1;

SWEP.UseHands		= false;
SWEP.ViewModel 		= "";
SWEP.WorldModel 	= "";

SWEP.HoldType = "normal";
SWEP.HoldTypeHolster = "normal";

SWEP.Holsterable = true;

SWEP.InfoText = [[Holstered - Primary: Knock on doors.
Unholstered - Primary: Punch.
Unholstered - Secondary: Zap.]];

SWEP.AttackAnims = { 
	{ "MeleeHigh1", Angle( 0, 10, 0 ) },
	{ "MeleeHigh2", Angle( 0, -10, 0 ) },
	{ "MeleeHigh3", Angle( 5, 5, 0 ) } };

function SWEP:Precache()
	
	util.PrecacheSound( "physics/wood/wood_crate_impact_hard2.wav" );
	
	util.PrecacheSound( "NPC_Vortigaunt.Swing" );
	util.PrecacheSound( "NPC_Vortigaunt.Claw" );
	util.PrecacheSound( "NPC_Vortigaunt.ZapPowerup" );
	util.PrecacheSound( "npc/vort/attack_shoot.wav" );
	
end

function SWEP:PrimaryHolstered()
	
	local tr = GAMEMODE:GetHandTrace( self.Owner );
	
	if( tr.Entity and tr.Entity:IsValid() and tr.Entity:IsDoor() ) then
		
		self:PlaySound( "physics/wood/wood_crate_impact_hard2.wav", 100, math.random( 95, 105 ) );
		
		self:SetNextPrimaryFire( CurTime() + 0.1 );
		
	end
	
end

function SWEP:PrimaryUnholstered()
	
	if( !self.Owner:OnGround() ) then return end
	
	self:SetNextPrimaryFire( CurTime() + 1.3 );
	self:SetNextSecondaryFire( CurTime() + 1.3 );
	GAMEMODE:FreezePlayer( self.Owner, 1.3 );
	
	local anim = table.Random( self.AttackAnims );
	
	self.Owner:PlayVCD( anim[1] );
	self.Owner:SetSequence( self.Owner:LookupSequence( anim[1] ) );
	
	timer.Simple( 0.2, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		
		self:PlaySound( "NPC_Vortigaunt.Swing", 100, 100 );
	end )
	
	timer.Simple( 0.3, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		
		self.Owner:ViewPunch( anim[2] );
	end )
	
	timer.Simple( 0.35, function()
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
		
		self:PlaySound( "NPC_Vortigaunt.Claw", 100, 100 );
		
		if( tr.Entity and tr.Entity:IsValid() ) then
			
			if( !self.Owner.NextStrength ) then self.Owner.NextStrength = 0 end
			
			if( CurTime() >= self.Owner.NextStrength ) then
				
				self.Owner:SetStrength( math.Clamp( self.Owner:Strength() + GAMEMODE:ScaledStatIncrease( self.Owner, self.Owner:Strength() ) * 0.05, 0, 100 ) );
				self.Owner:UpdateCharacterField( "StatStrength", tostring( self.Owner:Strength() ), true );
				
				self.Owner.NextStrength = CurTime() + 10;
				
			end
			
			local dmg = DamageInfo();
			dmg:SetAttacker( self.Owner );
			dmg:SetDamage( 0 );
			dmg:SetDamageForce( tr.Normal * 10000 );
			dmg:SetDamagePosition( tr.HitPos );
			dmg:SetDamageType( DMG_GENERIC );
			dmg:SetInflictor( self );
			
			if( tr.Entity:IsNPC() ) then
				
				dmg:SetDamage( 25 );
				
			end
			
			if( tr.Entity.DispatchTraceAttack ) then
				
				tr.Entity:DispatchTraceAttack( dmg, tr );
				
			end
			
		end
		
	end
	
	self.Owner:LagCompensation( false );
	
end

function SWEP:SecondaryHolstered()
end

function SWEP:SecondaryUnholstered()
	
	if( !self.Owner:OnGround() ) then return end
	
	self:SetNextPrimaryFire( CurTime() + 1.5 );
	self:SetNextSecondaryFire( CurTime() + 1.5 );
	GAMEMODE:FreezePlayer( self.Owner, 1.5 );
	
	self.Owner:PlayVCD( "g_zapattack1" );
	self:PlaySound( "NPC_Vortigaunt.ZapPowerup" );
	self.Owner:ViewPunch( Angle( -15, 0, 0 ) );
	
	if( CLIENT and LocalPlayer():GetViewEntity() != self.Owner ) then
		
		ParticleEffectAttach( "vortigaunt_charge_token", PATTACH_POINT_FOLLOW, self.Owner, 3 );
		ParticleEffectAttach( "vortigaunt_charge_token", PATTACH_POINT_FOLLOW, self.Owner, 4 );
		
	end
	
	timer.Simple( 0.3, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		
		self:StopSound( "NPC_Vortigaunt.ZapPowerup" );
		self:Zap();
		self.Owner:ViewPunch( Angle( 20, 0, 0 ) );
	end )
	
	timer.Simple( 1, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		
		self.Owner:StopParticles();
	end )
	
end

function SWEP:Zap()
	
	if( CLIENT ) then return end
	
	local tr = GAMEMODE:GetHandTrace( self.Owner, 500 );
	
	util.ParticleTracerEx( "vortigaunt_beam", tr.StartPos, tr.HitPos + tr.Normal * -32, false, self.Owner:EntIndex(), 3 );
	self:PlaySound( "npc/vort/attack_shoot.wav", 80, math.random( 130, 160 ) );
	
	local enttab = ents.FindInSphere( tr.HitPos, 64 );
	
	for _, v in pairs( enttab ) do
		
		if( v == self.Owner ) then continue; end
		
		local dmg = DamageInfo();
		dmg:SetAttacker( self.Owner );
		dmg:SetDamage( 50 );
		dmg:SetDamageForce( tr.Normal * 150000 );
		dmg:SetDamagePosition( tr.HitPos );
		dmg:SetDamageType( DMG_SHOCK );
		dmg:SetInflictor( self );
		
		if( v.DispatchTraceAttack ) then
			
			v:DispatchTraceAttack( dmg, tr );
			
		end
		
		if( v:IsDoor() and v:DoorType() == DOOR_COMBINEOPEN ) then
			
			v:Fire( "Open" );
			v:EmitSound( "AlyxEMP.Discharge" );
			
		end
		
		if( v:GetClass() == "func_button" ) then
			
			v:Fire( "Use" );
			v:EmitSound( "AlyxEMP.Discharge" );
			
		end
		
	end
	
end

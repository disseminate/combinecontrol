AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Grenade";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 9;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_grenade.mdl";
SWEP.WorldModel 	= "models/weapons/w_grenade.mdl";

SWEP.HoldType = "grenade";
SWEP.HoldTypeHolster = "normal";

SWEP.Holsterable = true;

SWEP.HolsterPos = Vector( -0, -12.94, 0 );
SWEP.HolsterAng = Vector( 0, 0, 0 );

SWEP.AimPos = Vector();
SWEP.AimAng = Vector();

SWEP.Itemize = true;
SWEP.ItemDescription = "A fragmentation grenade. A favorite of the Combine Overwatch Transhuman Arm.";
SWEP.ItemWeight = 2;
SWEP.ItemFOV = 8;
SWEP.ItemCamPos = Vector( 50, 50, 50 );
SWEP.ItemLookAt = Vector( 0, 0, 4.65 );

SWEP.GrenadeClass = "cc_grenade_frag";

function SWEP:DeployChild()
	
	self.Redraw = false;
	
end

function SWEP:Holster()
	
	if( self.NoHolster ) then return false end
	
	self.Redraw = false;
	
	timer.Stop( "cc_weapon_idle" .. self:EntIndex() );
	
	self:HolsterChild();
	return true;
	
end

function SWEP:PrimaryUnholstered()
	
	if( self.Redraw ) then return end
	if( self.NoHolster ) then return end
	
	self.NoHolster = true;
	self.Thrown = false;
	
	self:SendWeaponAnimShared( ACT_VM_PULLBACK_HIGH );
	self.NextAct = CurTime() + self.Weapon:SequenceDuration();
	
	self:SetNextPrimaryFire( CurTime() + math.huge );
	
end

function SWEP:SecondaryUnholstered()
	
	if( self.Redraw ) then return end
	if( self.NoHolster ) then return end
	
	self.NoHolster = true;
	self.Thrown = false;
	self.AttackLow = true;
	
	self:SendWeaponAnimShared( ACT_VM_PULLBACK_LOW );
	self.NextAct = CurTime() + self.Weapon:SequenceDuration();
	
	self:SetNextSecondaryFire( CurTime() + math.huge );
	
end

function SWEP:DoReload()
	
	if( self.Redraw and self:GetNextPrimaryFire() <= CurTime() and self:GetNextSecondaryFire() <= CurTime() ) then
		
		self:SendWeaponAnimShared( ACT_VM_DRAW );
		self:SetNextPrimaryFire( CurTime() + self.Weapon:SequenceDuration() );
		self:SetNextSecondaryFire( CurTime() + self.Weapon:SequenceDuration() );
		
		self.AttackLow = false;
		self.NoHolster = false;
		self.Thrown = false;
		self.Redraw = false;
		
	end
	
end

function SWEP:CheckThrowPosition( eye, src )
	
	local trace = { };
	trace.start = eye;
	trace.endpos = src;
	trace.mins = Vector( -4, -4, -4 );
	trace.maxs = Vector( 4, 4, 4 );
	trace.filter = ply;
	local tr = util.TraceHull( trace );
	
	if( tr.Hit ) then
		
		return tr.HitPos;
		
	end
	
	return src;
	
end

function SWEP:Throw()
	
	if( CLIENT ) then return end
	
	local vecEye = self.Owner:EyePos();
	local vForward = self.Owner:GetForward();
	local vRight = self.Owner:GetRight();
	
	local vecSrc = vecEye + vForward * 18 + vRight * 8;
	
	vecSrc = self:CheckThrowPosition( vecEye, vecSrc );
	vForward.z = vForward.z + 0.1;
	
	local vecThrow = self.Owner:GetVelocity();
	vecThrow = vecThrow + vForward * 1200 * ( ( self.Owner:Strength() + 50 ) / 150 );
	
	local grenade = ents.Create( self.GrenadeClass );
	grenade:SetPos( vecSrc );
	grenade:SetAngles( Angle() );
	grenade:SetVelocity( vecThrow );
	grenade:Spawn();
	grenade:Activate();
	grenade:SetTimer( 3 );
	grenade.Thrower = self.Owner;
	
	if( grenade and grenade:IsValid() ) then
		
		local phys = grenade:GetPhysicsObject();
		
		if( phys and phys:IsValid() ) then
			
			phys:SetVelocity( vecThrow );
			phys:AddAngleVelocity( Vector( 600, math.random( -1200, 1200 ), 0 ) );
			
		end
		
	end
	
	self.Redraw = true;
	
	self:EmitSound( "WeaponFrag.Throw" );
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	
end

function SWEP:Lob()
	
	if( CLIENT ) then return end
	
	local vecEye = self.Owner:EyePos();
	local vForward = self.Owner:GetForward();
	local vRight = self.Owner:GetRight();
	
	local vecSrc = vecEye + vForward * 18 + vRight * 8 + Vector( 0, 0, -8 );
	
	vecSrc = self:CheckThrowPosition( vecEye, vecSrc );
	
	local vecThrow = self.Owner:GetVelocity();
	vecThrow = vecThrow + vForward * 350 * ( ( self.Owner:Strength() + 50 ) / 150 ) + Vector( 0, 0, 50 );
	
	local grenade = ents.Create( self.GrenadeClass );
	grenade:SetPos( vecSrc );
	grenade:SetAngles( Angle() );
	grenade:SetVelocity( vecThrow );
	grenade:Spawn();
	grenade:Activate();
	grenade:SetTimer( 3 );
	grenade.Thrower = self.Owner;
	
	if( grenade and grenade:IsValid() ) then
		
		local phys = grenade:GetPhysicsObject();
		
		if( phys and phys:IsValid() ) then
			
			phys:SetVelocity( vecThrow );
			phys:AddAngleVelocity( Vector( 200, math.random( -600, 600 ), 0 ) );
			
		end
		
	end
	
	self.Redraw = true;
	
	self:EmitSound( "WeaponFrag.Roll" );
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	
end

function SWEP:Roll()
	
	if( CLIENT ) then return end
	
	local vecSrc = self.Owner:GetPos() + Vector( 0, 0, 4 );
	local vecFacing = self.Owner:GetAimVector();
	vecFacing.z = 0;
	vecFacing:Normalize();
	
	local trace = { };
	trace.start = vecSrc;
	trace.endpos = vecSrc + Vector( 0, 0, -16 );
	trace.filter = self.Owner;
	
	local tr = util.TraceLine( trace );
	
	if( tr.Fraction != 1.0 ) then
		
		local tangent = vecFacing:Cross( tr.Normal );
		vecFacing = tr.Normal:Cross( tangent );
		
	end
	
	vecSrc = vecSrc + vecFacing * 18;
	
	vecSrc = self:CheckThrowPosition( self.Owner:GetPos() + Vector( 0, 0, 32 ), vecSrc );
	
	local vecThrow = self.Owner:GetVelocity();
	vecThrow = vecThrow + vecFacing * 700 * ( ( self.Owner:Strength() + 100 ) / 200 );
	local orientation = Angle( 0, self.Owner:GetAngles().y, -90 );
	
	local grenade = ents.Create( self.GrenadeClass );
	grenade:SetPos( vecSrc );
	grenade:SetAngles( orientation );
	grenade:SetVelocity( vecThrow );
	grenade:Spawn();
	grenade:Activate();
	grenade:SetTimer( 3 );
	grenade.Thrower = self.Owner;
	
	if( grenade and grenade:IsValid() ) then
		
		local phys = grenade:GetPhysicsObject();
		
		if( phys and phys:IsValid() ) then
			
			phys:SetVelocity( vecThrow );
			phys:AddAngleVelocity( Vector( 0, 0, 720 ) );
			
		end
		
	end
	
	self.Redraw = true;
	
	self:EmitSound( "WeaponFrag.Roll" );
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	
end

function SWEP:ThinkChild()
	
	if( self.NextAct and CurTime() >= self.NextAct and !self.Thrown ) then
		
		if( self.AttackLow ) then
			
			if( self.Owner:Crouching() ) then
				
				self:SendWeaponAnimShared( ACT_VM_SECONDARYATTACK );
				self.NextAct = CurTime() + self:SequenceDuration() - 0.2;
				
			else
				
				self:SendWeaponAnimShared( ACT_VM_HAULBACK );
				self.NextAct = CurTime() + self:SequenceDuration() - 0.2;
				
			end
			
		else
			
			self:SendWeaponAnimShared( ACT_VM_THROW );
			self.NextAct = CurTime() + self:SequenceDuration() - 0.2;
			
		end
		
		self.Thrown = true;
		
	end
	
	if( self.Redraw ) then
		
		self:DoReload();
		
	end
	
	if( self.NextAct and CurTime() >= self.NextAct and self.Thrown ) then
		
		self.NextAct = nil;
		
		if( self.AttackLow ) then
			
			if( self.Owner:Crouching() ) then
				
				self:Roll();
				
			else
				
				self:Lob();
				
			end
			
		else
			
			self:Throw();
			
		end
		
		if( SERVER ) then
			
			if( !self.Owner.NextStrength ) then self.Owner.NextStrength = 0 end
			
			if( CurTime() >= self.Owner.NextStrength ) then
				
				self.Owner:SetStrength( math.Clamp( self.Owner:Strength() + GAMEMODE:ScaledStatIncrease( self.Owner, self.Owner:Strength() ) * 0.05, 0, 100 ) );
				self.Owner:UpdateCharacterField( "StatStrength", tostring( self.Owner:Strength() ), true );
				
				self.Owner.NextStrength = CurTime() + 10;
				
			end
			
			self.Owner:RemoveItem( self.Owner:GetInventoryItem( self:GetClass() ) );
			
		end
		
		self:SetNextPrimaryFire( CurTime() + 0.5 );
		self:SetNextSecondaryFire( CurTime() + 0.5 );
		
	end
	
	self:NextThink( CurTime() )
	
end
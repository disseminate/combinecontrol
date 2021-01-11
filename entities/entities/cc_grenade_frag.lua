AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName		= "";
ENT.Author			= "";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= false;
ENT.AdminSpawnable		= false;

function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:SetTimer( dDelay )
	
	self.DetonateTime = CurTime() + dDelay;
	self:NextThink( CurTime() );
	
	--CreateEffects()
	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetModel( "models/Weapons/w_grenade.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON );
	
	self.Damage = 150;
	self.Radius = 250;
	
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:Wake();
		
	end
	
end

function ENT:OnTakeDamage( dmginfo )

	self:TakePhysicsDamage( dmginfo );
	
end
--[[
function ENT:PhysicsUpdate( phys )
	
	self.BaseClass:PhysicsUpdate( phys );
	
	local vel = phys:GetVelocity();
	local angVel = phys:GetAngleVelocity();
	
	local start = self:GetPos();
	
	local trace = { };
	trace.start = start;
	trace.endpos = start + vel * FrameTime();
	trace.filter = { self.Thrower, self }; --CTraceFilterCollisionGroupDelta filter( this, GetCollisionGroup(), COLLISION_GROUP_NONE );
	trace.mask = CONTENTS_HITBOX + CONTENTS_MONSTER + CONTENTS_SOLID;
	
	local tr = util.TraceLine( trace );
	
	if( tr.StartSolid ) then
		
		if( !self.InSolid ) then
			
			vel = vel * -0.2;
			phys:SetVelocity( vel );
			
		end
		
		self.InSolid = true;
		return;
		
	end
	
	self.InSolid = false;
	
	if( tr.Hit ) then
		
		local dir = vel;
		dir:Normalize();
		
		--CTakeDamageInfo info( this, GetThrower(), pPhysics->GetMass() * vel, GetAbsOrigin(), 0.1f, DMG_CRUSH );
		--tr.m_pEnt->TakeDamage( info );
		
		vel = -2 * tr.Normal * vel:DotProduct( tr.Normal ) + vel;
		
		vel = vel * 0.2;
		angVel = angVel * -0.5;
		
		phys:SetVelocity( vel );
		--phys:AddAngleVelocity( phys:GetAngleVelocity() * -1 );
		phys:AddAngleVelocity( angVel );
		
	end
	
end
--]]
function ENT:Explode( tr )
	
	if( tr.Fraction != 1.0 ) then
		
		self:SetPos( tr.HitPos + tr.Normal * 0.6 );
		
	end
	
	util.ScreenShake( self:GetPos(), 25, 150, 1, 750 );
	
	local explo = ents.Create( "env_explosion" );
	explo:SetOwner( self.Thrower );
	explo:SetPos( self:GetPos() );
	explo:SetKeyValue( "iMagnitude", self.Damage );
	explo:SetKeyValue( "iRadiusOverride", self.Radius );
	explo:Spawn();
	explo:Activate();
	explo:Fire( "Explode" );
	
	self:Remove();
	
end

function ENT:Detonate()
	
	self:NextThink( CurTime() + 1 );
	
	local spot = self:GetPos() + Vector( 0, 0, 8 );
	
	local trace = { };
	trace.start = self:GetPos();
	trace.endpos = spot + Vector( 0, 0, -32 );
	trace.filter = self;
	
	local tr = util.TraceLine( trace );
	
	if( tr.StartSolid ) then
		
		local trace = { };
		trace.start = self:GetPos();
		trace.endpos = self:GetPos() + Vector( 0, 0, -32 );
		trace.filter = self;
		
		tr = util.TraceLine( trace );
		
	end
	
	self:Explode( tr );
	
end

function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( CurTime() > self.DetonateTime ) then
		
		self:Detonate();
		
	end
	
	self:NextThink( CurTime() + 0.1 );
	
end

function ENT:CanPhysgun()
	
	return false;
	
end

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
	
	self.BeepTime = CurTime();
	self.DetonateTime = CurTime() + dDelay;
	self.BeepFinishTime = self.DetonateTime - 0.3;
	
	self:NextThink( CurTime() );
	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetModel( "models/Weapons/w_slam.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON );
	
	self:SetTimer( 5 );
	
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:EnableMotion( false );
		
	end
	
end

function ENT:OnTakeDamage( dmginfo )

	
	
end

function ENT:Explode()
	
	local explo = ents.Create( "env_explosion" );
	explo:SetPos( self:GetPos() );
	explo:SetKeyValue( "spawnflags", "1" );
	explo:Spawn();
	explo:Activate();
	explo:Fire( "Explode" );
	
	self:Remove();
	
end

function ENT:Beep()
	
	self.BeepTime = CurTime() + 1;
	
	self:EmitSound( "buttons/blip1.wav" );
	
end

function ENT:BeepFinish()
	
	self.BeepFinishTime = math.huge;
	
	self:EmitSound( "buttons/blip1.wav", 150, 100 );
	
end

function ENT:Detonate()
	
	self:NextThink( CurTime() + 1 );
	
	self:Explode();
	
end

function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( CurTime() > self.BeepTime ) then
		
		self:Beep();
		
	end
	
	if( CurTime() > self.BeepFinishTime ) then
		
		self:BeepFinish();
		
	end
	
	if( CurTime() > self.DetonateTime ) then
		
		self:Detonate();
		
	end
	
end

function ENT:CanPhysgun()
	
	return false;
	
end

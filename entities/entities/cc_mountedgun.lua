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

ENT.AutomaticFrameAdvance	= true;

function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:SetupDataTables()
	
	self:NetworkVar( "Entity", 0, "Player" );
	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetModel( "models/props_combine/bunker_gun01.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	
	self:SetMoveType( MOVETYPE_NONE );
	self:SetUseType( SIMPLE_USE );
	
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:EnableCollisions( false );
		
	end
	
end

function ENT:Aim()
	
	local trace = { };
	trace.start = self:GetPos();
	trace.endpos = trace.start + self:GetPlayer():GetAimVector();
	trace.filter = { self, self:GetPlayer() };
	
	local tr = util.TraceLine( trace );
	
	local vecAim = self:GetPos() - tr.HitPos - self:GetForward();
	local localAim = self:WorldToLocalAngles( vecAim:Angle() );
	
	local ang = localAim.y; -- -90 to 90
	if( ang < 0 ) then
		ang = 180 + ang;
	else
		ang = ang - 180;
	end
	
	return localAim.p * -1, ang * 1.5;
	
end

function ENT:FireBullet()
	
	local attach = self:GetAttachment( self:LookupAttachment( "muzzle" ) );
	
	local bullet = { };
	bullet.Num = 1;
	bullet.Src = attach.Pos;
	bullet.Dir = attach.Ang:Forward();
	bullet.Spread = Vector( math.Rand( -0.05, 0.05 ), math.Rand( -0.05, 0.05 ), 0 );
	bullet.Tracer = 1;
	bullet.TracerName = "AR2Tracer";
	bullet.Force = 10;
	bullet.Damage = 5;
	
	self:FireBullets( bullet );
	
end

function ENT:Think()
	
	if( self:GetPlayer() and self:GetPlayer():IsValid() ) then
		
		if( self:GetPlayer():GetPos():Distance( self:GetPos() ) > 80 or !self:GetPlayer():Alive() ) then
			
			self:GetPlayer():SetMountedGun( NULL );
			self:SetPlayer( NULL );
			return;
			
		end
		
		local p, y = self:Aim();
		
		self:SetPoseParameter( "aim_yaw", math.Clamp( y, -60, 60 ) );
		self:SetPoseParameter( "aim_pitch", math.Clamp( p, -35, 50 ) );
		
		if( self:GetPlayer():KeyDown( IN_ATTACK ) ) then
			
			if( !self.NextFire ) then self.NextFire = 0; end
			
			if( CurTime() >= self.NextFire ) then
				
				self:FireBullet();
				self:EmitSound( "Weapon_functank.Single" );
				self.NextFire = CurTime() + 0.066;
				
			end
			
		end
		
	end
	
	self:NextThink( CurTime() );
	return true;
	
end

function ENT:Use( ply )
	
	if( SERVER ) then
		
		if( self:GetPlayer() and self:GetPlayer():IsValid() ) then
			
			self:GetPlayer():SetMountedGun( NULL );
			self:SetPlayer( NULL );
			
			self:ResetSequence( self:LookupSequence( "retract" ) );
			
		else
			
			for _, v in pairs( GAMEMODE.HandsWeapons ) do
				
				if( ply:HasWeapon( v ) ) then
					
					ply:SelectWeapon( v );
					break;
					
				end
				
			end
			
			ply:SetHolstered( true );
			
			ply:SetMountedGun( self );
			self:SetPlayer( ply );
			
			self:EmitSound( "Func_Tank.BeginUse" );
			self:ResetSequence( self:LookupSequence( "activate" ) );
			
		end
		--self:SetPoseParameter( "aim_yaw", 0 );
		--self:SetPoseParameter( "aim_pitch", 0 );
		
	end
	
end

function ENT:CanPhysgun()
	
	return false;
	
end

function ENT:Draw()
	
	self:DrawModel();
	
	if( self:GetPlayer() and self:GetPlayer():IsValid() ) then
		
		local p, y = self:Aim();
		
		self:SetPoseParameter( "aim_yaw", math.Clamp( y, -60, 60 ) );
		self:SetPoseParameter( "aim_pitch", math.Clamp( p, -35, 50 ) );
		
	end
	
end

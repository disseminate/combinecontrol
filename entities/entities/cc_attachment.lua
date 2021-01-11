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

function ENT:SetupDataTables()
	
	self:NetworkVar( "String", 0, "PlayerAttachment" );
	self:NetworkVar( "String", 1, "PlayerBone" );
	self:NetworkVar( "Entity", 0, "Wearer" );
	self:NetworkVar( "Vector", 0, "OriginOffset" );
	self:NetworkVar( "Angle", 0, "AngleOffset" );
	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:PhysicsInit( SOLID_NONE );
	
end

function ENT:Think()
	
	if( self:GetWearer() and self:GetWearer():IsValid() ) then
		
		self:SetPos( self:GetWearer():EyePos() );
		self:SetAngles( self:GetWearer():EyeAngles() );
		
	else
		
		self:Remove();
		
	end
	
end

function ENT:Draw()
	
	if( EyePos():Distance( LocalPlayer():EyePos() ) < 5 ) then return end
	
	local pos = nil;
	local ang = nil;
	
	if( self:GetWearer() and self:GetWearer():IsValid() ) then
		
		pos = self:GetWearer():EyePos();
		ang = self:GetWearer():EyeAngles();
		
		if( self:GetPlayerAttachment() ) then
			
			local data = self:GetWearer():GetAttachment( self:GetWearer():LookupAttachment( self:GetPlayerAttachment() ) );
			
			if( data ) then
				
				pos = data.Pos;
				ang = data.Ang;
				
			end
			
		end
		
		if( self:GetPlayerBone() ) then
			
			local p, a = self:GetWearer():GetBonePosition( self:GetWearer():LookupBone( self:GetPlayerBone() ) );
			
			if( p and a ) then
				
				pos = p;
				ang = a;
				
			end
			
		end
		
	end
	
	local offang = self:GetAngleOffset();
	
	if( offang ) then
		
		ang:RotateAroundAxis( ang:Forward(), offang.p );
		ang:RotateAroundAxis( ang:Right(), offang.y );
		ang:RotateAroundAxis( ang:Up(), offang.r );
		
	end
	
	local offvec = self:GetOriginOffset();
	
	if( offvec ) then
		
		pos = pos + ang:Forward() * offvec.x;
		pos = pos + ang:Right() * offvec.y;
		pos = pos + ang:Up() * offvec.z;
		
	end
	
	if( pos and ang ) then
		
		self:SetRenderOrigin( pos );
		self:SetRenderAngles( ang );
		
	end
	
	self:DrawModel();
	
end

function ENT:CanPhysgun()
	
	return false;
	
end

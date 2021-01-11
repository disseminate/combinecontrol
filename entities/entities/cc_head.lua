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

function ENT:Initialize()
	
	if( CLIENT ) then
		
		return;
		
	end
	
	self:AddEffects( EF_BONEMERGE + EF_BONEMERGE_FASTCULL + EF_PARENT_ANIMATES + EF_NOSHADOW );
	self:PhysicsInit( SOLID_NONE );
	self:SetSolid( SOLID_NONE );
	self:SetMoveType( MOVETYPE_NONE );
	
end

function ENT:Think()
	
	if( self:GetParent() and self:GetParent():IsValid() ) then
		
		if( self:GetParent():GetNoDraw() ) then
			
			self:SetNoDraw( true );
			
		else
			
			self:SetNoDraw( false );
			
		end
		
	end
	
end

function ENT:ConvertRelativeToEyes( pos )
	
	local attach = self:LookupAttachment( "eyes" );
	if( attach == 0 ) then return end
	
	local p = self:GetAttachment( attach );
	if( !p ) then return end
	
	local lpos, _ = WorldToLocal( pos, Angle(), p.Pos, p.Ang );
	
	return lpos;
	
end

function ENT:CanPhysgun()
	
	return false;
	
end

local matWhite = Material( "models/wireframe" );

function ENT:Draw()
	
	if( self:GetParent() and self:GetParent():IsValid() and self:GetParent():Alive() and self:GetParent():ShrinkHead() ) then
		
		if( self.ReadyForBones ) then
			
			if( !self.DidBonePositions ) then
				
				self.DidBonePositions = true;
				
				local function ShrinkBody( ent, n )
					
					if( ent:GetParent() and ent:GetParent():IsValid() and ent:GetParent():Alive() ) then
						
						if( ent:GetParent():ShrinkHead() ) then
							
							for i = 0, n do
								
								if( ent:GetBoneName( i ) == "ValveBiped.Bip01_Head1" ) then
									
									local matrix = ent:GetBoneMatrix( i );
									
									if( matrix ) then
										
										matrix:Scale( Vector( 1 / 0.1, 1 / 0.1, 1 / 0.1 ) );
										ent:SetBoneMatrix( i, matrix );
										
									end
									
								else
									
									local matrix = ent:GetBoneMatrix( i );
									
									if( matrix ) then
										
										matrix:Scale( Vector( 0.1, 0.1, 0.1 ) );
										ent:SetBoneMatrix( i, matrix );
										
									end
									
								end
								
							end
							
						end
						
					end
					
				end
				
				self:AddCallback( "BuildBonePositions", ShrinkBody );
				
			end
			
			if( !self:GetParent().DidBonePositions ) then
				
				self:GetParent().DidBonePositions = true;
				
				local function ShrinkHead( ent, n )
					
					if( ent:ShrinkHead() ) then
						
						local headid = ent:LookupBone( "ValveBiped.Bip01_Head1" );
						local head = ent:GetBoneMatrix( headid );
						
						if( head ) then
							
							head:Scale( Vector( 0.1, 0.1, 0.1 ) );
							ent:SetBoneMatrix( headid, head );
							
						end
						
					end
					
				end
				
				self:GetParent():AddCallback( "BuildBonePositions", ShrinkHead );
				
			end
			
		end
		
		local pos = self:GetParent():EyePos() + self:GetParent():GetAimVector() * 32768;
		
		local targ = self:ConvertRelativeToEyes( pos );
		if( targ ) then
			self:SetEyeTarget( targ );
		end
		
		self:DrawModel();
		
	end
	
	self:DrawShadow( false );
	
end

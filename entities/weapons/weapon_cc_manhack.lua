AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Tactical Viscerator";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 13;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "";
SWEP.WorldModel 	= "models/manhack.mdl";

SWEP.RepositionToHand = true;

SWEP.HoldType = "grenade";
SWEP.HoldTypeHolster = "grenade";

SWEP.Holsterable = false;

SWEP.AimPos = Vector();
SWEP.AimAng = Vector();

SWEP.Itemize = true;
SWEP.ItemDescription = "The Tactical Viscerator is a robotic flying device used to eliminate non-Combine targets in hard-to-reach areas. It's locked to targeting any organic except those with Combine biosignal transmitters.";
SWEP.ItemWeight = 5;
SWEP.ItemFOV = 11;
SWEP.ItemCamPos = Vector( 50, 50, 50 );
SWEP.ItemLookAt = Vector( 0, 0, 0 );

function SWEP:PrimaryUnholstered()
	
	if( SERVER ) then
	
		local vecSrc = self.Owner:GetShootPos() + self.Owner:GetForward() * 10 + self.Owner:GetRight() * 16 + self.Owner:GetUp() * 24;
		
		local trace = { };
		trace.start = self.Owner:GetShootPos();
		trace.endpos = vecSrc;
		trace.mins = Vector( -8, -8, -8 );
		trace.maxs = Vector( 8, 8, 8 );
		trace.filter = self.Owner;
		local tr = util.TraceHull( trace );
		
		if( tr.Hit ) then
			
			vecSrc = tr.HitPos;
			
		end
		
		local ent = ents.Create( "npc_manhack" );
		ent:SetPos( vecSrc );
		ent:SetAngles( self.Owner:GetAimVector():Angle() );
		
		if( !self.Owner:HasAnyCombineFlag() ) then
			
			ent:SetNPCHatesFlaggedCPs( 1 );
			
		else
			
			ent:SetNPCHatesUnflaggedCPs( 1 );
			ent:SetNPCHatesCitizens( 1 );
			ent:SetNPCHatesRebels( 1 );
			
		end
		
		ent:Spawn();
		ent:Activate();
		ent:Fire( "Kill", "", 1200 );
		
		if( ent and ent:IsValid() ) then
			
			local phys = ent:GetPhysicsObject();
			
			if( phys and phys:IsValid() ) then
				
				phys:SetVelocity( self.Owner:GetVelocity() + self.Owner:GetAimVector() * ( 100 + ( 700 * self.Owner:Strength() / 100 ) ) );
				
			end
			
		end
		
		if( !self.Owner.NextStrength ) then self.Owner.NextStrength = 0 end
		
		if( CurTime() >= self.Owner.NextStrength ) then
			
			self.Owner:SetStrength( math.Clamp( self.Owner:Strength() + GAMEMODE:ScaledStatIncrease( self.Owner, self.Owner:Strength() ) * 0.05, 0, 100 ) );
			self.Owner:UpdateCharacterField( "StatStrength", tostring( self.Owner:Strength() ), true );
			
			self.Owner.NextStrength = CurTime() + 10;
			
		end
		
	end
	
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() + 1 );
	self:SetNextSecondaryFire( CurTime() + self:SequenceDuration() + 1 );
	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	
	self.RemoveTime = CurTime();
	
	self:PlaySound( "WeaponFrag.Throw" );
	
end

function SWEP:ThinkChild()
	
	if( SERVER ) then
		
		if( self.RemoveTime and CurTime() >= self.RemoveTime ) then
			
			self.RemoveTime = nil;
			self.Owner:RemoveItem( self.Owner:GetInventoryItem( self:GetClass() ) );
			
		end
		
	end
	
end

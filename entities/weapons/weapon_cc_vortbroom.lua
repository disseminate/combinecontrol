AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Broom";
SWEP.Slot 			= 1;
SWEP.SlotPos 		= 3;

SWEP.UseHands		= false;
SWEP.ViewModel 		= "models/props_c17/pushbroom.mdl";
SWEP.WorldModel 	= "models/props_c17/pushbroom.mdl";

SWEP.HoldType = "normal";
SWEP.HoldTypeHolster = "normal";

SWEP.Holsterable = false;

SWEP.InfoText = [[Primary: Sweep.]];

SWEP.Itemize = true;
SWEP.ItemDescription = "Perfect for sweeping things.";
SWEP.ItemWeight = 2;
SWEP.ItemFOV = 50;
SWEP.ItemCamPos = Vector( -28.7, 50, 8.11 );
SWEP.ItemLookAt = Vector( 4.18, 1.52, -0.91 );
SWEP.ItemProcessEntity = function( self, e )
	
	e:PhysicsInitBox( Vector( -8, -8, -8 ), Vector( 8, 8, 8 ) );
	e:PhysWake();
	
end

SWEP.UnholsterText = "You're holding a broom.";

function SWEP:Precache()
	
	
	
end

function SWEP:PrimaryHolstered()
	
	
	
end

function SWEP:PrimaryUnholstered()
	
	GAMEMODE:FreezePlayer( self.Owner, 2 );
	self.Owner:PlayVCD( "g_sweep" );
	
	self:SetNextPrimaryFire( CurTime() + 2 );
	
	if( CLIENT ) then return end
	
	local pos = self.Owner:GetPos() + self.Owner:GetForward() * 16;
	
	for _, v in pairs( ents.FindInSphere( self.Owner:GetPos(), 32 ) ) do
		
		if( v != self.Owner ) then
			
			local ang = self.Owner:EyeAngles();
			ang.p = 0;
			ang.r = 0;
			
			local vec = ang:Forward() * 80;
			
			if( ( v:GetClass() == "prop_physics" or v:GetClass() == "prop_physics_multiplayer" ) and v:GetPhysicsObject() and v:GetPhysicsObject():IsValid() ) then
				
				v:GetPhysicsObject():SetVelocity( vec );
				
			end
			
		end
		
	end
	
end

function SWEP:SecondaryHolstered()
	
	
	
end

function SWEP:SecondaryUnholstered()
	
	
	
end

function SWEP:CalcIron()
	
	self.IronNetPos = Vector( 6.94, -19.36, 50 );
	self.IronNetAng = Vector( -21.08, 1.42, -38.54 );
	
end

function SWEP:DrawWorldModel()
	
	local hand = self.Owner:GetAttachment( self.Owner:LookupAttachment( "cleaver_attachment" ) );
	
	if( hand ) then
		
		self:SetRenderOrigin( hand.Pos );
		self:SetRenderAngles( hand.Ang );
		
	end
	
	self:DrawModel();
	
end
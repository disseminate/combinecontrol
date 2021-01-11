AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Medkit";
SWEP.Slot 			= 1;
SWEP.SlotPos 		= 2;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_medkit.mdl";
SWEP.WorldModel 	= "models/weapons/w_medkit.mdl";

SWEP.HoldType = "slam";
SWEP.HoldTypeHolster = "slam";

SWEP.InfoText = [[Primary: Apply to yourself.
Secondary: Apply to another.]];

SWEP.Holsterable = false;

SWEP.AimPos = Vector();
SWEP.AimAng = Vector();

SWEP.Itemize = true;
SWEP.ItemDescription = "A medical kit full of medigel.";
SWEP.ItemWeight = 4;
SWEP.ItemFOV = 9;
SWEP.ItemCamPos = Vector( 50, 50, 50 );
SWEP.ItemLookAt = Vector( 0, 0, 0 );

SWEP.ItemBulkPrice		= 100;
SWEP.ItemLicense		= LICENSE_MISC;

function SWEP:HolsterChild()
	
	if( self.RemoveTime and CurTime() <= self.RemoveTime ) then return true end
	
end

function SWEP:PrimaryUnholstered()
	
	if( SERVER ) then
		
		self.Owner:SetHealth( math.min( self.Owner:Health() + 50, 100 ) );
		
	end
	
	self.Owner:SetLastLegShot( CurTime() - 20 );
	
	self:SendWeaponAnimShared( ACT_VM_PRIMARYATTACK );
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() + 0.5 );
	self:SetNextSecondaryFire( CurTime() + self:SequenceDuration() + 0.5 );
	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	
	self.RemoveTime = CurTime() + 0.5;
	
	self:PlaySound( "items/smallmedkit1.wav" );
	self:Idle();
	
end

function SWEP:SecondaryUnholstered()
	
	local ent = GAMEMODE:GetHandTrace( self.Owner, 100 ).Entity;
	
	if( ent and ent:IsValid() and ent:IsPlayer() ) then
		
		if( SERVER ) then
			
			ent:SetHealth( math.min( ent:Health() + 50, 100 ) );
			
		end
		
		ent:SetLastLegShot( CurTime() - 20 );
		
		self:SendWeaponAnimShared( ACT_VM_PRIMARYATTACK );
		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() + 0.5 );
		self:SetNextSecondaryFire( CurTime() + self:SequenceDuration() + 0.5 );
		self.Owner:SetAnimation( PLAYER_ATTACK1 );
		
		self.RemoveTime = CurTime() + 0.5;
		
		self:PlaySound( "items/smallmedkit1.wav" );
		self:Idle();
		
	else
		
		self:SetNextPrimaryFire( CurTime() + 0.5 );
		self:SetNextSecondaryFire( CurTime() + 0.5 );
		self:PlaySound( "items/medshotno1.wav" );
		
	end
	
end

function SWEP:ThinkChild()
	
	if( SERVER ) then
		
		if( self.RemoveTime and CurTime() >= self.RemoveTime ) then
			
			self.RemoveTime = nil;
			self.Owner:RemoveItem( self.Owner:GetInventoryItem( self:GetClass() ) );
			
		end
		
	end
	
end

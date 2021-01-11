AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Stalker";
SWEP.Slot 			= 1;
SWEP.SlotPos 		= 1;

SWEP.UseHands		= false;
SWEP.ViewModel 		= "";
SWEP.WorldModel 	= "";

SWEP.HoldType = "normal";
SWEP.HoldTypeHolster = "normal";

SWEP.Holsterable = false;

SWEP.InfoText = [[Secondary: Scream.]];

function SWEP:Precache()
end

function SWEP:PrimaryHolstered()
end

function SWEP:ThinkChild()
end

function SWEP:PrimaryUnholstered()
end

function SWEP:SecondaryHolstered()
	
	if( !self.NextScream ) then self.NextScream = 0 end
	
	if( CurTime() >= self.NextScream ) then
		
		self.NextScream = CurTime() + 5;
		self:PlaySound( "npc/stalker/go_alert2.wav" );
		
	end
	
end

function SWEP:SecondaryUnholstered()
end

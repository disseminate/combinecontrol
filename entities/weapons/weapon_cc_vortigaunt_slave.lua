AddCSLuaFile();

SWEP.Base			= "weapon_cc_vortigaunt";

SWEP.PrintName 		= "Vortigaunt";
SWEP.Slot 			= 1;
SWEP.SlotPos 		= 1;

SWEP.UseHands		= false;
SWEP.ViewModel 		= "";
SWEP.WorldModel 	= "";

SWEP.HoldType = "normal";
SWEP.HoldTypeHolster = "normal";

SWEP.Holsterable = true;

SWEP.InfoText = [[Holstered - Primary: Knock on doors.
Unholstered - Primary: Punch.]];

function SWEP:Precache()
	
	util.PrecacheSound( "physics/wood/wood_crate_impact_hard2.wav" );
	
end

function SWEP:SecondaryUnholstered()
end

AddCSLuaFile();

SWEP.Base			= "weapon_cc_grenade";

SWEP.PrintName 		= "Flashbang";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 10;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_grenade.mdl";
SWEP.WorldModel 	= "models/weapons/w_grenade.mdl";

SWEP.HoldType = "grenade";
SWEP.HoldTypeHolster = "normal";

SWEP.Holsterable = true;

SWEP.HolsterPos = Vector( -0, -12.94, 0 );
SWEP.HolsterAng = Vector( 0, 0, 0 );

SWEP.AimPos = Vector();
SWEP.AimAng = Vector();

SWEP.Itemize = true;
SWEP.ItemDescription = "A flashbang grenade. Tactical device used to blind and disorient enemies.";
SWEP.ItemWeight = 2;
SWEP.ItemFOV = 8;
SWEP.ItemCamPos = Vector( 50, 50, 50 );
SWEP.ItemLookAt = Vector( 0, 0, 4.65 );

SWEP.GrenadeClass = "cc_grenade_flash";

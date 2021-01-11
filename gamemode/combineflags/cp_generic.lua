FLAG.PrintName 		= "Unit";
FLAG.Flag 			= "B";
FLAG.Color 			= Color( 75, 87, 95, 255 );
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "radio", "zipties", "smallmedkit", "weapon_cc_medkit", "weapon_cc_stunstick", "weapon_cc_flare", "weapon_cc_pistol", "weapon_cc_grenade", "weapon_cc_flashbang", "weapon_cc_manhack" };
FLAG.CharName		= "CCA-C18.$SQUAD-$ID.$CID";
FLAG.CanEditLoans	= true;
FLAG.DemoteTo		= "A";

function FLAG.ModelFunc( ply )
	
	if( ply:Gender() == GENDER_FEMALE ) then
		
		return "models/player/police_fem.mdl";
		
	end
	
	return "models/player/police.mdl";
	
end

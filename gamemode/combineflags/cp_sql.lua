FLAG.PrintName 		= "Squad Leader";
FLAG.Flag 			= "C";
FLAG.Color 			= Color( 60, 20, 20, 255 );
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "radio", "zipties", "smallmedkit", "weapon_cc_medkit", "weapon_cc_stunstick", "weapon_cc_flare", "weapon_cc_pistol", "weapon_cc_smg", "weapon_cc_shotgun", "weapon_cc_doorbreach", "weapon_cc_beanbag", "weapon_cc_grenade", "weapon_cc_flashbang", "weapon_cc_manhack", "combineturret" };
FLAG.CharName		= "CCA-C18.$SQUAD-SqL.$CID";
FLAG.CanJW			= true;
FLAG.CanEditLoans	= true;
FLAG.CanEditCPs		= true;

function FLAG.ModelFunc( ply )
	
	if( ply:Gender() == GENDER_FEMALE ) then
		
		return "models/player/police_fem.mdl";
		
	end
	
	return "models/player/police.mdl";
	
end

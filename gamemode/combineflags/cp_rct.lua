FLAG.PrintName 		= "Recruit";
FLAG.Flag 			= "A";
FLAG.Color 			= Color( 143, 165, 181, 255 );
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "radio", "zipties", "weapon_cc_stunstick" };
FLAG.CharName		= "CCA-C18.RcT.$CID";
FLAG.CanSpawn		= false;
FLAG.CanBroadcast	= false;
FLAG.PromoteTo		= "B";

function FLAG.ModelFunc( ply )
	
	if( ply:Gender() == GENDER_FEMALE ) then
		
		return "models/player/police_fem.mdl";
		
	end
	
	return "models/player/police.mdl";
	
end
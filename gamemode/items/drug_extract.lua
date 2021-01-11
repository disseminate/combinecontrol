ITEM.ID				= "drug_extract";
ITEM.Name			= "\"Antlion Extract\"";
ITEM.Description	= "A drug that reeches of various antlion parts, the liquid appears to have a weird solid feel to it, but still is consumable, it has a weird yellow-green tint. A small label 'MATTS RESEARCH; ANTLION EXTRACT' is sticked upon it.";
ITEM.Model			= "models/props_lab/jar01b.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 11;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.Usable			= true;
ITEM.UseText		= "Drink";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You take the drug.", { CB_ALL, CB_IC } );
		GAMEMODE:DrugEffectExtract();
		
	else
		
		ply:DoDrug( DRUG_EXTRACT );
		
	end
	
end
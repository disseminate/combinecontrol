ITEM.ID				= "drug_breenwater";
ITEM.Name			= "\"Overwatch\"";
ITEM.Description	= "A drug synthesized from the chemicals in Breen Water. Not something you should be proud of eating.";
ITEM.Model			= "models/props_lab/jar01b.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 11;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.Usable			= true;
ITEM.UseText		= "Eat";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You take the drug.", { CB_ALL, CB_IC } );
		GAMEMODE:DrugEffectBreen();
		
	end
	
end
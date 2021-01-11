ITEM.ID				= "drug_antlion";
ITEM.Name			= "\"Antlion Rage\"";
ITEM.Description	= "A variant of the City 45 Iced Tea drug. It's a viscous, brownish fluid.";
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
		GAMEMODE:DrugEffectAntlion();
		
	else
		
		ply:DoDrug( DRUG_ANTLION );
		
	end
	
end
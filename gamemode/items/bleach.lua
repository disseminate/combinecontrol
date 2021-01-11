ITEM.ID				= "bleach";
ITEM.Name			= "Bleach";
ITEM.Description	= "It's used to take the stains out of clothes. Highly toxic.";
ITEM.Model			= "models/props_junk/garbage_plasticbottle002a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 14;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 100;
ITEM.License		= LICENSE_MISC;

ITEM.Usable			= true;
ITEM.UseText		= "Drink";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You drink the bleach. Great idea!", { CB_ALL, CB_IC } );
		
	else
		
		ply:Kill();
		
	end
	
end
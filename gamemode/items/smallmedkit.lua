ITEM.ID				= "smallmedkit";
ITEM.Name			= "Medigel Vial";
ITEM.Description	= "A small vial of medigel. Used for emergency first aid.";
ITEM.Model			= "models/healthvial.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 9;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 5.02 );

ITEM.BulkPrice		= 50;
ITEM.License		= LICENSE_MISC;

ITEM.Usable			= true;
ITEM.UseText		= "Apply";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You apply the medigel to yourself.", { CB_ALL, CB_IC } );
		
	else
		
		ply:SetHealth( math.min( ply:Health() + 20, 100 ) );
		
	end
	
end
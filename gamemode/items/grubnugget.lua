ITEM.ID				= "grubnugget";
ITEM.Name			= "Grub Nugget";
ITEM.Description	= "A glob of pus released from an Antlion grub. Smells rancid.";
ITEM.Model			= "models/grub_nugget_small.mdl";
ITEM.Weight 		= 0.5;
ITEM.FOV 			= 4;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 50;
ITEM.License		= LICENSE_BLACK;

ITEM.Usable			= true;
ITEM.UseText		= "Apply";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You apply the grub pus to yourself.", { CB_ALL, CB_IC } );
		
	else
		
		ply:SetHealth( math.min( ply:Health() + 2, 100 ) );
		
	end
	
end
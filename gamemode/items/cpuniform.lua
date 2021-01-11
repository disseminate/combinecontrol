ITEM.ID				= "cpuniform";
ITEM.Name			= "Civil Protection Uniform";
ITEM.Description	= "A box containing a standard-issue CP uniform.";
ITEM.Model			= "models/Items/item_item_crate.mdl";
ITEM.Weight 		= 6;
ITEM.FOV 			= 40;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 8.17 );

ITEM.BulkPrice		= 3000;
ITEM.License		= LICENSE_BLACK;

ITEM.Uniform		= function( self, ply )
	
	if( string.find( ply:GetModel(), "group01" ) ) then
		
		if( ply:Gender() == GENDER_FEMALE ) then
			
			return "models/player/police_fem.mdl";
			
		end
		
		return "models/player/police.mdl";
		
	end
	
end
ITEM.UniformColor	= Color( 75, 87, 95, 255 );
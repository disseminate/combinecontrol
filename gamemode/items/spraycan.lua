ITEM.ID				= "spraycan";
ITEM.Name			= "Paint Spraycan";
ITEM.Description	= "An aerosol can of paint.";
ITEM.Model			= "models/props_junk/garbage_plasticbottle003a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 14;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 200;
ITEM.License		= LICENSE_BLACK;

ITEM.Usable			= true;
ITEM.UseText		= "Spray";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	local tr = GAMEMODE:GetHandTrace( ply, 100 );
	
	if( tr.HitWorld ) then
		
		if( tr.HitNormal:Cross( Vector( 0, 0, 1 ) ):Length() < 0.8 ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You can only spray on a wall!", { CB_ALL, CB_IC } );
				
			end
			
			return true;
			
		end
		
		if( SERVER ) then
			
			util.Decal( "cc_graffiti" .. math.random( 1, 10 ), tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal );
			ply:EmitSound( Sound( "player/sprayer.wav" ) );
			
			ply:SetPerception( math.Clamp( ply:Perception() + GAMEMODE:ScaledStatIncrease( ply, ply:Perception() ), 0, 100 ) );
			ply:UpdateCharacterField( "StatPerception", tostring( ply:Perception() ), true );
			
		else
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You spray some graffiti.", { CB_ALL, CB_IC } );
			
		end
		
	else
		
		return true;
		
	end
	
end

ITEM.ProcessEntity = function( self, ent )
	
	ent:SetMaterial( "models/shiny" );
	ent:SetColor( Color( 67, 67, 67, 255 ) );
	
end

ITEM.IconMaterial = "models/shiny";
ITEM.IconColor = Color( 67, 67, 67, 255 );

game.AddDecal( "cc_graffiti1", "decals/decalgraffiti003a" );
game.AddDecal( "cc_graffiti2", "decals/decalgraffiti006a" );
game.AddDecal( "cc_graffiti3", "decals/decalgraffiti009a" );
game.AddDecal( "cc_graffiti4", "decals/decalgraffiti011a" );
game.AddDecal( "cc_graffiti5", "decals/decalgraffiti012a" );
game.AddDecal( "cc_graffiti6", "decals/decalgraffiti017a" );
game.AddDecal( "cc_graffiti7", "decals/decalgraffiti037a" );
game.AddDecal( "cc_graffiti8", "decals/decalgraffiti038a" );
game.AddDecal( "cc_graffiti9", "decals/decalgraffiti056a" );
game.AddDecal( "cc_graffiti10", "decals/decalgraffiti059a" );

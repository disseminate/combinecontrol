ITEM.ID				= "poster";
ITEM.Name			= "Combine Poster";
ITEM.Description	= "A folded adhesive poster containing an image of Combine propaganda.";
ITEM.Model			= "models/props_junk/garbage_newspaper001a.mdl";
ITEM.Weight 		= 0.5;
ITEM.FOV 			= 22;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 2, 0, 0 );

ITEM.Usable			= true;
ITEM.UseText		= "Place";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( ply:HasAnyCombineFlag() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "This isn't your job - let those lower-class citizens do the dirty work!", { CB_ALL, CB_IC } );
			
		end
		
		return true;
		
	end
	
	local tr = GAMEMODE:GetHandTrace( ply, 100 );
	
	if( tr.HitWorld ) then
		
		if( tr.HitNormal:Cross( Vector( 0, 0, 1 ) ):Length() < 0.8 ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "The poster must be placed on a wall!", { CB_ALL, CB_IC } );
				
			end
			
			return true;
			
		end
		
		if( SERVER ) then
			
			util.Decal( "cc_combineposter" .. math.random( 1, 3 ), tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal );
			ply:AddMoney( 5 );
			
			if( ply:HasTrait( TRAIT_LUCKY ) ) then
				
				ply:AddMoney( math.random( 1, 5 ) );
				
			end
			
			ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
			
		else
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "The CCA have rewarded you 5 credits for placing the poster.", { CB_ALL, CB_IC } );
			
			if( ply:HasTrait( TRAIT_LUCKY ) ) then
				
				GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Their credit system seem to be messed up in your favor, though, and you got a bit more than that.", { CB_ALL, CB_IC } );
				
			end
			
		end
		
	else
		
		return true;
		
	end
	
end

game.AddDecal( "cc_combineposter1", "decals/decal_posterbreen" );
game.AddDecal( "cc_combineposter2", "decals/decal_posters005a" );
game.AddDecal( "cc_combineposter3", "decals/decal_posters006a" );

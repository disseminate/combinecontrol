ITEM.ID				= "cpration";
ITEM.Name			= "CCA Ration";
ITEM.Description	= "A combine ration, intended for consumption by Civil Protection units. The quality of the food in here is a bit better than the citizen rations.";
ITEM.Model			= "models/weapons/w_package.mdl";
ITEM.Weight 		= 6;

ITEM.Usable			= true;
ITEM.UseText		= "Open";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( !ply:HasAnyCombineFlag() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You can't eat this! You're not a CP!", { CB_ALL, CB_IC } );
			
		end
		
		return true;
		
	end
	
	if( CLIENT ) then
		
		if( ply:HasTrait( TRAIT_LUCKY ) ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You open the ration and take the contents. As is usual for you, the contents seem a bit jumbled up.", { CB_ALL, CB_IC } );
			
		else
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You open the ration and take the contents.", { CB_ALL, CB_IC } );
			
		end
		
	else
		
		if( ply:HasTrait( TRAIT_LUCKY ) ) then
			
			local r = math.random( 1, 2 );
			
			if( r != 1 ) then
				
				ply:GiveItem( "water" );
				
			end
			
			r = math.random( 1, 2 );
			
			if( r != 1 ) then
				
				ply:GiveItem( "cookedbeans" );
				
			end
			
			r = math.random( 1, 4 );
			
			if( r == 1 ) then
				
				ply:GiveItem( "cookedheadcrabgib" );
				
			end
			
			if( r == 2 ) then
				
				ply:GiveItem( "cookedchinese" );
				
			end
			
			ply:AddMoney( 50 + math.random( 20, 100 ) );
			ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
			
			return;
			
		end
		
		ply:GiveItem( "water" );
		ply:GiveItem( "beer" );
		
		if( math.random( 1, 2 ) == 1 ) then
			ply:GiveItem( "cookedbeans" );
		else
			ply:GiveItem( "cookedchinese" );
		end
		
		ply:GiveItem( "cookedheadcrabgib" );
		
		ply:AddMoney( 50 );
		ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
		
	end
	
end
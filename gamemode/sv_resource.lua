if( GM.WorkshopMaps[game.GetMap()] ) then
	
	resource.AddWorkshop( GM.WorkshopMaps[game.GetMap()] );
	
else
	
	resource.AddSingleFile( "maps/" .. game.GetMap() .. ".bsp" );
	
end
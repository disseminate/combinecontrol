local meta = FindMetaTable( "Entity" );

function game.GetDoors()
	
	local tab = { };
	
	for _, v in pairs( ents.GetAll() ) do
		
		if( v:IsDoor() ) then
			
			table.insert( tab, v );
			
		end
		
	end
	
	return tab;
	
end
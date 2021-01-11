function GM:Think()
	
	for _, v in pairs( player.GetAll() ) do
		
		self:SpeedThink( v );
		self:ConsciousThink( v );
		self:HungerThink( v );
		self:AdminThink( v );
		self:PrisonThink( v );
		self:AFKThink( v );
		self:APCThink( v );
		v:WaterThink();
		
		if( v.Inventory ) then
			
			for _, n in pairs( v.Inventory ) do
				
				if( GAMEMODE:GetItemByID( n ) and GAMEMODE:GetItemByID( n ).Think ) then
					
					GAMEMODE:GetItemByID( n ).Think( n, v );
					
				end
				
			end
			
		end
		
	end
	
	self:RefillThink();
	self:BreenThink();
	self:SQLThink();
	self:SpawnerThink();
	
end
function GM:Think()
	
	self.BaseClass:Think();
	
	self:MusicThink();
	self:CreateParticleEmitters();
	self:PMUpdateCombinePrison();
	self:JWThink();
	self:ToggleHolsterThink();
	self:DrugThink();
	
	self:CharCreateThink();
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v.Inventory ) then
			
			for _, n in pairs( v.Inventory ) do
				
				if( GAMEMODE:GetItemByID( n ) and GAMEMODE:GetItemByID( n ).Think ) then
					
					GAMEMODE:GetItemByID( n ).Think( n, v );
					
				end
				
			end
			
		end
		
	end
	
	if( GetConVarNumber( "physgun_wheelspeed" ) > 20 ) then
		
		RunConsoleCommand( "physgun_wheelspeed", "20" );
		
	end
	
	if( Vector( GetConVar( "cl_weaponcolor" ) ) != Vector( 0.15, 0.81, 0.91 ) ) then
		
		RunConsoleCommand( "cl_weaponcolor", "0.15 0.81 0.91" );
		
	end
	
end

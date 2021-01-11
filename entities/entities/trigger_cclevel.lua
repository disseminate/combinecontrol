ENT.Type = "brush";
ENT.Base = "base_brush";

ENT.Destinations = { };
ENT.Destinations["canals_1"] = "rp_cc_thecanals_1_1";

function ENT:Touch( e )
	
	if( self.Destination ) then
		
		if( self.Destinations[self.Destination] ) then
			
			game.ConsoleCommand( "changelevel " .. self.Destinations[self.Destination] .. "\n" );
			
		end
		
	end
	
end

function ENT:KeyValue( key, value )
	
	if( key == "destination" ) then
		
		self.Destination = value;
		
	end
	
end

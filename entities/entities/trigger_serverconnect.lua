ENT.Type = "brush";
ENT.Base = "base_brush";

function ENT:Touch( e )
	
	if( e:IsPlayer() ) then
		
		if( GAMEMODE.ServerConnectIDs[self.ServerID] ) then
			
			local tab = GAMEMODE.ServerConnectIDs[self.ServerID];
			
			e:ConCommand( "password " .. tab[2] .. "\n" );
			e:ConCommand( "connect " .. tab[1] .. "\n" );
			
		end
		
	end
	
end

function ENT:KeyValue( key, value )
	
	if( key == "serverid" ) then
		
		self.ServerID = value;
		
	end
	
end

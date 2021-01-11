ENT.Type = "brush";
ENT.Base = "base_brush";

function ENT:GoToNextLevel()
	
	game.ConsoleCommand( "changelevel " .. self.NextMap .. "\n" );
	
end

function ENT:AcceptInput( name )
	
	if( name == "ChangeLevel" ) then
		
		self:GoToNextLevel();
		
	end
	
end

function ENT:Touch( e )
	
	if( !self.NoTouch ) then
		
		self:GoToNextLevel();
		
	end
	
end

function ENT:KeyValue( key, value )
	
	if( key == "landmark" ) then
		
		self.Landmark = value;
		
	end
	
	if( key == "map" ) then
		
		self.NextMap = value;
		
	end
	
	if( key == "spawnflags" ) then
		
		self.NoTouch = ( bit.band( tonumber( value ), 1 ) == 1 );
		
	end
	
end

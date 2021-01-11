function GM:GetSongDuration( path )
	
	for _, v in pairs( self.Music ) do
		
		if( string.lower( v[1] ) == string.lower( path ) ) then
			
			return v[2];
			
		end
		
	end
	
	return 0;
	
end

function GM:CanAutoPlayMusic()
	
	return true;
	
end

function GM:CanPlayMusic()
	
	return cookie.GetNumber( "cc_music", 1 ) == 1;
	
end

function GM:PlayMusic( s, fl )
	
	if( !self:CanPlayMusic() ) then return end
	
	if( !fl ) then fl = 1; end
	
	if( !self.MusicFinished ) then self.MusicFinished = 0; end
	
	if( self.MusicPatch ) then
		
		if( fl > 0 and !self.Fading and CurTime() < self.MusicFinished - 1 ) then
			
			self.MusicPatch:ChangeVolume( 0, fl );
			self.MusicFadeTime = CurTime() + fl;
			
			self.NextMusic = s;
			
		else
			
			self.MusicFadeTime = CurTime();
			self.NextMusic = s;
			
		end
		
		self.Fading = true;
		
	else
		
		if( LocalPlayer() and LocalPlayer():IsValid() ) then
			
			self.MusicPatch = CreateSound( LocalPlayer(), s );
			self.MusicPatch:SetSoundLevel( 0 );
			self.MusicPatch:Play();
			
			self.MusicFinished = CurTime() + self:GetSongDuration( s );
			self.NextAutoMusic = CurTime() + self:GetSongDuration( s ) + math.random( 600, 1000 );
			
		end
		
	end
	
end

function GM:FadeOutMusic( fl )
	
	if( !fl ) then fl = 1; end
	
	if( self.MusicPatch and !self.Fading ) then
		
		self.Fading = true;
		
		if( fl > 0 ) then
			
			self.MusicPatch:ChangeVolume( 0, fl );
			self.MusicFadeTime = CurTime() + fl;
			
		else
			
			self.MusicPatch = nil;
			
		end
		
	end
	
end

GM.NextAutoMusic = CurTime() + math.random( 600, 1000 );

function GM:MusicThink()
	
	if( !self.MusicFinished ) then self.MusicFinished = 0; end
	
	if( self.MusicFadeTime and CurTime() >= self.MusicFadeTime and self.MusicPatch ) then
		
		self.Fading = false;
		self.MusicPatch = nil;
		self.MusicFadeTime = nil;
		
	end
	
	if( self.NextMusic and !self.MusicPatch ) then
		
		self:PlayMusic( self.NextMusic );
		self.NextMusic = nil;
		
	end
	
	if( !self.MusicPatch and CurTime() >= self.MusicFinished and CurTime() >= self.NextAutoMusic and self:CanAutoPlayMusic() ) then
		
		local v = table.Random( self:GetSongList( SONG_IDLE ) );
		self:PlayMusic( v );
		
	end
	
end

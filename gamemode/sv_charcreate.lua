function nCreateCharacter( len, ply )
	
	if( ply:SQLGetNumChars() >= GAMEMODE.MaxCharacters ) then return end
	
	local name = net.ReadString();
	local desc = net.ReadString();
	local model = net.ReadString();
	local stats = net.ReadTable();
	local trait = net.ReadUInt( 32 );
	
	local sum = 0;
	
	for _, v in pairs( stats ) do
		
		sum = sum + math.Round( v );
		
	end
	
	local r, err = GAMEMODE:CheckCharacterValidity( name, desc, model, sum, trait );
	
	if( r ) then
		
		ply:SaveNewCharacter( name, desc, model, stats, trait );
		
	end
	
end
net.Receive( "nCreateCharacter", nCreateCharacter );

function nSelectCharacter( len, ply )
	
	local id = net.ReadUInt( 32 );
	
	if( ply:SQLCharExists( id ) ) then
		
		if( ply:CharID() == id ) then return end
		
		if( GAMEMODE.CurrentLocation and ply:GetCharFromID( id ).Location != GAMEMODE.CurrentLocation and !ply:IsAdmin() ) then return end
		
		ply:LoadCharacter( ply:GetCharFromID( id ) );
		
	end
	
end
net.Receive( "nSelectCharacter", nSelectCharacter );

function nDeleteCharacter( len, ply )
	
	local id = net.ReadUInt( 32 );
	
	if( ply:SQLCharExists( id ) ) then
		
		if( ply:CharID() == id ) then return end
		
		local char = ply:GetCharFromID( id );
		
		if( tonumber( char.Loan ) and tonumber( char.Loan ) > 0 ) then return end
		
		ply:DeleteCharacter( id, char.RPName );
		
	end
	
end
net.Receive( "nDeleteCharacter", nDeleteCharacter );

local allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -";

function nChangeRPName( len, ply )
	
	local name = net.ReadString();
	
	if( string.len( string.Trim( name ) ) <= GAMEMODE.MaxNameLength and string.len( string.Trim( name ) ) >= GAMEMODE.MinNameLength ) then
		
		if( !string.find( allowedChars, name, 1, true ) ) then
			
			ply:SetRPName( string.Trim( name ) );
			ply:UpdateCharacterField( "RPName", name );
			
		end
		
	end
	
end
net.Receive( "nChangeRPName", nChangeRPName );

function nChangeTitle( len, ply )
	
	local desc = net.ReadString();
	
	if( string.len( string.Trim( desc ) ) <= GAMEMODE.MaxDescLength ) then
		
		ply:SetDescription( string.Trim( desc ) );
		ply:UpdateCharacterField( "Title", string.Trim( desc ) );
		
	end
	
end
net.Receive( "nChangeTitle", nChangeTitle );

function nSetNewbieStatus( len, ply )
	
	local status = 1 - net.ReadBit();
	
	ply:SetNewbieStatus( status );
	ply:UpdatePlayerField( "NewbieStatus", status );
	
end
net.Receive( "nSetNewbieStatus", nSetNewbieStatus );
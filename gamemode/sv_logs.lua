GM.ConsoleLog = true;

function GM:SetupDataDirectories()
	
	file.CreateDir( "CombineControl" );
	file.CreateDir( "CombineControl/savedprops" );
	file.CreateDir( "CombineControl/logs" );
	file.CreateDir( "CombineControl/logs/" .. os.date( "!%y-%m-%d" ) );
	
end

function GM:LogFile( name, text )
	
	if( !file.IsDir( "CombineControl/logs/" .. os.date( "!%y-%m-%d" ), "DATA" ) ) then
		
		file.CreateDir( "CombineControl/logs/" .. os.date( "!%y-%m-%d" ) );
		
	end
	
	local c = file.Read( "CombineControl/logs/" .. os.date( "!%y-%m-%d" ) .. "/" .. name .. ".txt" ) or "";
	file.Write( "CombineControl/logs/" .. os.date( "!%y-%m-%d" ) .. "/" .. name .. ".txt", c .. text );
	
end

function nGetLogList( len, ply )
	
	if( !ply:IsAdmin() ) then return end
	
	local id = net.ReadString();
	local date = net.ReadString();
	local n = math.Clamp( net.ReadUInt( 14 ), 0, 10000 );
	
	local c = file.Read( "CombineControl/logs/" .. date .. "/" .. id .. ".txt" ) or "";
	local otab = string.Explode( "\n", c );
	local tab = string.Explode( "\n", c );
	
	if( n > 0 ) then
		
		for i = 1, #tab - ( n + 1 ) do
			
			table.remove( tab, 1 );
			
		end
		
	end
	
	net.Start( "nLogList" );
		net.WriteTable( tab );
		net.WriteUInt( #otab, 14 );
	net.Send( ply );
	
end
net.Receive( "nGetLogList", nGetLogList );

function nGetRosterList( len, ply )
	
	if( !ply:IsAdmin() ) then return end
	
	local id = net.ReadBit();
	
	if( id == 0 ) then
		
		local function qS( ret )
			
			local tab = { };
			
			for _, v in pairs( ret ) do
				
				local sid = v.SteamID;
				local rpname = v.RPName;
				local cpflag = v.CombineFlag;
				local laston = v.LastOnline;
				
				table.insert( tab, { sid, rpname, cpflag, laston } );
				
			end
			
			net.Start( "nRosterList" );
				net.WriteTable( tab );
			net.Send( ply );
			
			GAMEMODE:LogSQL( "Player " .. ply:Nick() .. " retrieved combine roster." );
			
		end
		
		mysqloo.Query( "SELECT SteamID, RPName, CombineFlag, LastOnline FROM cc_chars WHERE CombineFlag != ''", qS, qF );
		
	else
		
		local function qS( ret )
			
			local tab = { };
			
			for _, v in pairs( ret ) do
				
				local sid = v.SteamID;
				local rpname = v.RPName;
				local charflag = v.CharFlags;
				local laston = v.LastOnline;
				
				table.insert( tab, { sid, rpname, charflag, laston } );
				
			end
			
			net.Start( "nRosterList" );
				net.WriteTable( tab );
			net.Send( ply );
			
			GAMEMODE:LogSQL( "Player " .. ply:Nick() .. " retrieved flags roster." );
			
		end
		
		mysqloo.Query( "SELECT SteamID, RPName, CharFlags, LastOnline FROM cc_chars WHERE CharFlags != ''", qS, qF );
		
	end
	
end
net.Receive( "nGetRosterList", nGetRosterList );

function GM:LogSQL( text )
	
	if( string.len( text ) > 120 ) then
		
		text = string.sub( text, 1, 120 ) .. " (...)";
		
	end
	
	local ins = os.date( "!%H:%M:%S" ) .. "\t" .. text .. "\n";
	self:LogFile( "sql", ins );
	
	if( self.ConsoleLog ) then
		
		MsgC( Color( 200, 200, 200, 255 ), ins );
		
	end
	
end

function GM:LogBug( text, forceconsole )
	
	local ins = os.date( "!%H:%M:%S" ) .. "\t" .. text .. "\n";
	self:LogFile( "bugs", ins );
	
	if( self.ConsoleLog or forceconsole ) then
		
		MsgC( Color( 255, 0, 0, 255 ), ins );
		
	end
	
end

function GM:LogAdmin( text, ply )
	
	local ins = os.date( "!%H:%M:%S" ) .. "\t" .. ply:SteamID() .. "\t" .. text .. "\n";
	self:LogFile( "admin", ins );
	
	if( self.ConsoleLog ) then
		
		MsgC( Color( 200, 200, 200, 255 ), ins );
		
	end
	
end

function GM:LogSecurity( steamid, networkid, name, text )
	
	local ins = os.date( "!%H:%M:%S" ) .. "\t" .. steamid .. "\t" .. networkid .. "\t" .. name .. "\t" .. text .. "\n";
	self:LogFile( "security", ins );
	
	if( self.ConsoleLog ) then
		
		MsgC( Color( 200, 200, 200, 255 ), ins );
		
	end
	
end

function GM:LogChat( text, ply )
	
	local ins = os.date( "!%H:%M:%S" ) .. "\t" .. ply:SteamID() .. "\t" .. text .. "\n";
	self:LogFile( "chat", ins );
	
end

function GM:LogSandbox( text, ply )
	
	local ins = os.date( "!%H:%M:%S" ) .. "\t" .. ply:SteamID() .. "\t" .. text .. "\n";
	self:LogFile( "sandbox", ins );
	
	if( self.ConsoleLog ) then
		
		MsgC( Color( 200, 200, 200, 255 ), ins );
		
	end
	
end

function GM:LogItems( text, ply )
	
	local ins = os.date( "!%H:%M:%S" ) .. "\t" .. ply:SteamID() .. "\t" .. text .. "\n";
	self:LogFile( "items", ins );
	
	if( self.ConsoleLog ) then
		
		MsgC( Color( 200, 200, 200, 255 ), ins );
		
	end
	
end

function GM:LogCombine( text, ply )
	
	local ins = os.date( "!%H:%M:%S" ) .. "\t" .. ply:SteamID() .. "\t" .. text .. "\n";
	self:LogFile( "combine", ins );
	
	if( self.ConsoleLog ) then
		
		MsgC( Color( 200, 200, 200, 255 ), ins );
		
	end
	
end
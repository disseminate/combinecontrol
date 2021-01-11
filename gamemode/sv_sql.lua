local meta = FindMetaTable( "Player" );

if( !mysqloo ) then
	
	require( "mysqloo" );
	
end

function GM:InitSQL()
	
	if( !CCSQL ) then
		
		self.SQLQueue = { };
		
	end
	
	CCSQL = mysqloo.connect( self.MySQLHost, self.MySQLUser, self.MySQLPass, self.MySQLDB, self.MySQLPort );
	
	function CCSQL:onConnected()
		
		MsgC( Color( 200, 200, 200, 255 ), "MySQL successfully connected to " .. self:hostInfo() .. ".\nMySQL server version: " .. self:serverInfo() .. "\n" );
		GAMEMODE.NoMySQL = false;
		
		GAMEMODE:InitSQLTables();
		
		for k, v in pairs( GAMEMODE.SQLQueue ) do
			
			timer.Simple( 0.01 * ( k - 1 ), function()
				
				mysqloo.Query( v[1], v[2] );
				
			end );
			
		end
		
		GAMEMODE.SQLQueue = { };
		
		mysqloo.Query( "SET interactive_timeout = 28800" );
		mysqloo.Query( "SET wait_timeout = 28800" );
		
	end

	function CCSQL:onConnectionFailed( err )
		
		GAMEMODE:LogBug( "ERROR: MySQL connection failed (\"" .. err .. "\")." );
		GAMEMODE.NoMySQL = true;
		
		if( string.find( err, "Unknown MySQL server host" ) ) then return end
		
		GAMEMODE:InitSQL();
		
	end

	CCSQL:connect();
	
end

function mysqloo.Query( q, cb, cbe, noerr )
	
	if( GAMEMODE.NoMySQL ) then
		
		cb( { } );
		return;
		
	end
	
	local qo = CCSQL:query( q );
	
	if( !qo ) then
		
		table.insert( GAMEMODE.SQLQueue, { q, cb } );
		CCSQL:abortAllQueries();
		CCSQL:connect();
		return;
		
	end
	
	function qo:onSuccess( ret )
		
		if( cb ) then
			
			cb( ret, qo );
			
		end
		
	end
	
	function qo:onError( err )
		
		if( CCSQL:status() == mysqloo.DATABASE_NOT_CONNECTED ) then
			
			table.insert( GAMEMODE.SQLQueue, { q, cb } );
			CCSQL:abortAllQueries();
			CCSQL:connect();
			return;
			
		end
		
		if( err == "MySQL server has gone away" ) then
			
			table.insert( GAMEMODE.SQLQueue, { q, cb } );
			CCSQL:abortAllQueries();
			CCSQL:connect();
			return;
			
		end
		
		if( string.find( err, "Lost connection to MySQL server" ) ) then
			
			table.insert( GAMEMODE.SQLQueue, { q, cb } );
			CCSQL:abortAllQueries();
			CCSQL:connect();
			return;
			
		end
		
		if( cbe ) then
			
			cbe( err, qo );
			
		end
		
		if( !noerr ) then
			
			GAMEMODE:LogBug( "ERROR: MySQL query \"" .. q .. "\" failed (\"" .. err .. "\")." );
			
		end
		
	end
	
	qo:start();
	
end

function mysqloo.Escape( s )
	
	if( !s ) then return "" end
	
	return CCSQL:escape( s );
	
end

local CharTable = {
	{ "SteamID", "VARCHAR(30)" },
	{ "RPName", "VARCHAR(100)" },
	{ "Model", "VARCHAR(100)" },
	{ "Title", "VARCHAR(8192)", "" },
	{ "Inventory", "VARCHAR(2048)", "" },
	{ "Money", "INT", "100" },
	{ "Trait", "INT", TRAIT_NONE },
	{ "StatStrength", "FLOAT", "0" },
	{ "StatSpeed", "FLOAT", "0" },
	{ "StatToughness", "FLOAT", "0" },
	{ "StatAgility", "FLOAT", "0" },
	{ "StatPerception", "FLOAT", "0" },
	{ "StatAim", "FLOAT", "0" },
	{ "Loan", "INT", "0" },
	{ "CID", "INT", "0" },
	{ "CombineFlag", "VARCHAR(1)", "" },
	{ "CharFlags", "VARCHAR(10)", "" },
	{ "CombineSquad", "VARCHAR(20)", "" },
	{ "CombineSquadID", "FLOAT", "0" },
	{ "BusinessLicenses", "FLOAT", "0" },
	{ "CriminalRecord", "VARCHAR(2048)", "" },
	{ "CombineAppStatus", "FLOAT", "0" },
	{ "CombineAppDate", "VARCHAR(20)", "" },
	{ "Hunger", "FLOAT", "0" },
	{ "CPRationDate", "VARCHAR(20)", "" },
	{ "Date", "VARCHAR(20)", "" },
	{ "LastOnline", "VARCHAR(20)", "" },
	{ "Location", "FLOAT", "1" },
	{ "EntryPort", "FLOAT", "1" },
};

local PlayerTable = {
	{ "LastName", "VARCHAR(128)", "" },
	{ "ToolTrust", "INT", "0" },
	{ "PhysTrust", "INT", "1" },
	{ "PropTrust", "INT", "1" },
	{ "NewbieStatus", "INT", NEWBIE_STATUS_NEW },
	{ "DonationAmount", "DOUBLE", "0" },
	{ "CustomMaxProps", "INT", "0" },
	{ "CustomMaxRagdolls", "INT", "0" },
	{ "ScoreboardTitle", "VARCHAR(100)", "" },
	{ "ScoreboardTitleC", "VARCHAR(100)", "200 200 200" },
	{ "ScoreboardBadges", "INT", "0" },
};

local BansTable = {
	{ "Length", "INT" },
	{ "Reason", "VARCHAR(512)", "" },
	{ "Date", "VARCHAR(20)" }
};

local CPAppsTable = {
	{ "CharID", "INT" },
	{ "Name", "VARCHAR(100)" },
	{ "Player", "VARCHAR(100)" },
	{ "Val1", "TEXT" },
	{ "Val2", "TEXT" },
	{ "Val3", "TEXT" },
	{ "Val4", "TEXT" },
	{ "Date", "VARCHAR(20)" },
};

local DonationsTable = {
	{ "CharID", "INT" },
	{ "DonationType", "INT" },
	{ "DonationData", "VARCHAR(512)", "" }
};

function GM:InitSQLTable( tab, dtab )
	
	for _, v in pairs( tab ) do
		
		local function qS()
			
			-- self:LogSQL( "Column \"" .. v[1] .. "\" already exists in table " .. dtab .. "." );
			
		end
		
		local function qF( err )
			
			if( string.find( string.lower( err ), "unknown column" ) ) then
				
				self:LogSQL( "Column \"" .. v[1] .. "\" does not exist in table " .. dtab .. ", creating..." );
				
				local q = "ALTER TABLE " .. dtab .. " ADD COLUMN " .. v[1] .. " " .. v[2] .. " NOT NULL";
				
				if( v[3] ) then
					
					q = q .. " DEFAULT '" .. tostring( v[3] ) .. "'";
					
				end
				
				mysqloo.Query( q );
				
			end
			
		end
		
		mysqloo.Query( "SELECT " .. v[1] .. " FROM " .. dtab, qS, qF, true );
		
	end
	
end

function GM:InitSQLTables()
	
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_chars ( id INT NOT NULL auto_increment, PRIMARY KEY ( id ) );" );
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_players ( SteamID VARCHAR(30) NOT NULL, PRIMARY KEY ( SteamID ) );" );
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_bans ( id INT NOT NULL auto_increment, SteamID VARCHAR(30) NOT NULL, PRIMARY KEY ( id ) );" );
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_cpapps ( id INT NOT NULL auto_increment, SteamID VARCHAR(30) NOT NULL, PRIMARY KEY ( id ) );" );
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_donations ( id INT NOT NULL auto_increment, SteamID VARCHAR(30) NOT NULL, PRIMARY KEY ( id ) );" );
	
	self:InitSQLTable( CharTable, "cc_chars" );
	self:InitSQLTable( PlayerTable, "cc_players" );
	self:InitSQLTable( BansTable, "cc_bans" );
	self:InitSQLTable( CPAppsTable, "cc_cpapps" );
	self:InitSQLTable( DonationsTable, "cc_donations" );
	
end

function GM:DumpSQL( t )
	
	if( !t ) then return end
	
	local function qS( ret )
		
		MsgC( Color( 200, 200, 200, 255 ), "Dumping table...\n" );
		
		if( ret ) then
			
			PrintTable( ret );
			
		end
		
		MsgC( Color( 200, 200, 200, 255 ), "Finished dumping table.\n" );
		
	end
	
	MsgC( Color( 200, 200, 200, 255 ), "Loading table " .. t .. "...\n" );
	mysqloo.Query( "SELECT * FROM " .. t, qS );
	
end

function GM:PurgeSQL()
	
	local function qS( ret )
		
		GAMEMODE:LogSQL( "SQL has been purged." );
		
		game.ConsoleCommand( "changelevel " .. game.GetMap() .. "\n" );
		
	end
	
	local function qF( err )
		
		self:PurgeSQL();
		
	end
	
	mysqloo.Query( "DROP TABLE cc_chars, cc_cpapps;", qS, qF );
	
end

function GM:LoadBans()
	
	local function qS( ret )
		
		local nBans = #ret;
		
		self:LogSQL( "Banlist successfully retrieved. " .. nBans .. " entries loaded." );
		self.BanTable = ret;
		
		for k, v in pairs( self.BanTable ) do
			
			if( v.Length > 0 and util.TimeSinceDate( v.Date ) > v.Length ) then
				
				table.remove( self.BanTable, k );
				self:RemoveBan( v.SteamID, "time's up" );
				
			end
			
		end
		
	end
	
	local function qF( err )
		
		self:LoadBans();
		
	end
	
	mysqloo.Query( "SELECT * FROM cc_bans", qS, qF );
	
end

function GM:AddBan( steam, len, reason, t )
	
	local function qS( ret )
		
		self:LogSQL( "Banned SteamID " .. steam .. " for " .. len .. " minutes (" .. reason .. ")." );
		
	end
	
	local function qF( err )
		
		self:AddBan( steam, len, mysqloo.Escape( reason ), t );
		
	end
	
	mysqloo.Query( "INSERT INTO cc_bans ( SteamID, Length, Reason, Date ) VALUES ( '" .. steam .. "', '" .. len .. "', '" .. mysqloo.Escape( reason ) .. "', '" .. t .. "' )", qS, qF );
	
end

function GM:RemoveBan( steam, r )
	
	local function qS( ret )
		
		self:LogSQL( "Unbanned SteamID " .. steam .. ": " .. r .. "." );
		
	end
	
	local function qF( err )
		
		self:RemoveBan( steam, r );
		
	end
	
	mysqloo.Query( "DELETE FROM cc_bans WHERE SteamID = '" .. steam .. "'", qS, qF );
	
end

function GM:LookupBan( steam )
	
	if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
	
	for k, v in pairs( self.BanTable ) do
		
		if( v.SteamID == steam ) then
			
			return k;
			
		end
		
	end
	
end

GM.CPAppsTable = { };

function GM:LoadCPApps()
	
	local function qS( ret )
		
		local nApps = #ret;
		
		self:LogSQL( "Combine applications successfully retrieved. " .. nApps .. " entries loaded." );
		self.CPAppsTable = ret;
		
	end
	
	local function qF( err )
		
		self:LoadCPApps();
		
	end
	
	mysqloo.Query( "SELECT * FROM cc_cpapps", qS, qF );
	
end

function GM:AddCPApp( ply, val1, val2, val3, val4 )
	
	local function qS( ret )
		
		if( #ret > 0 ) then return end
		
		local function qS( ret )
			
			self:LogSQL( "Character " .. ply:VisibleRPName() .. " submitted a CP application." );
			
			net.Start( "nApplyCombineSuccess" );
			net.Send( ply );
			
		end
		
		local function qF( err )
			
			--self:AddCPApp( ply, val1, val2, val3, val4 );
			
		end
		
		mysqloo.Query( "INSERT INTO cc_cpapps ( SteamID, CharID, Name, Player, Val1, Val2, Val3, Val4, Date ) VALUES ( '" .. ply:SteamID() .. "', '" .. ply:CharID() .. "', '" .. mysqloo.Escape( ply:RPName() ) .. "', '" .. mysqloo.Escape( ply:Nick() ) .. "', '" .. mysqloo.Escape( val1 ) .. "', '" .. mysqloo.Escape( val2 ) .. "', '" .. mysqloo.Escape( val3 ) .. "', '" .. mysqloo.Escape( val4 ) .. "', '" .. os.date( "!%m/%d/%y %H:%M:%S" ) .. "' )", qS, qF );
		
		table.insert( self.CPAppsTable, {
			SteamID = ply:SteamID(),
			CharID = ply:CharID(),
			Name = ply:RPName(),
			Player = ply:Nick(),
			Val1 = val1,
			Val2 = val2,
			Val3 = val3,
			Val4 = val4,
			Date = os.date( "!%m/%d/%y %H:%M:%S" )
		} );
		
		ply:SetCombineAppStatus( CPAPP_APPLIED );
		ply:SetCombineAppDate( os.date( "!%m/%d/%y %H:%M:%S" ) );
		
		ply:UpdateCharacterField( "CombineAppStatus", ply:CombineAppStatus() );
		ply:UpdateCharacterField( "CombineAppDate", ply:CombineAppDate() );
		
	end
	
	local function qF( err )
		
		--self:AddCPApp( ply, val1, val2, val3, val4 );
		
	end
	
	mysqloo.Query( "SELECT * FROM cc_cpapps WHERE CharID = '" .. ply:CharID() .. "'", qS, qF );
	
end

function meta:SQLSaveNewPlayer()
	
	local function qS( ret )
		
		GAMEMODE:LogSQL( "Created new player record for user " .. self:Nick() .. "." );
		
		local tab = { };
		
		for _, v in pairs( PlayerTable ) do
			
			if( v[3] ) then
				
				tab[v[1]] = tostring( v[3] );
				
			end
			
		end
		
		tab["SteamID"] = self:SteamID();
		
		self.SQLPlayerData = tab;
		
		self:LoadPlayer( self.SQLPlayerData );
		
		self:LoadCharsInfo();
		
	end
	
	GAMEMODE:LogSQL( "Creating new player record for user " .. self:Nick() .. "..." );
	mysqloo.Query( "INSERT INTO cc_players ( SteamID ) VALUES ( '" .. self:SteamID() .. "' )", qS );
	
end

function meta:PostLoadCharsInfo()
	
	if( self:SQLGetNumChars() > 0 ) then
		
		net.Start( "nCharacterList" );
			net.WriteTable( self.SQLCharData );
		net.Send( self );
		
		net.Start( "nOpenCharCreate" );
			
			if( GAMEMODE.CurrentLocation != LOCATION_CITY ) then
				net.WriteUInt( CC_SELECT, 3 );
			else
				if( self:SQLGetNumChars() < GAMEMODE.MaxCharacters ) then
					net.WriteUInt( CC_CREATESELECT, 3 );
				else
					net.WriteUInt( CC_SELECT, 3 );
				end
			end
		net.Send( self );
		
	else
		
		if( GAMEMODE.CurrentLocation and GAMEMODE.CurrentLocation != LOCATION_CITY ) then
			
			net.Start( "nConnect" );
				net.WriteString( IP_GENERAL .. PORT_CITY );
			net.Send( self );
			return;
			
		end
		
		net.Start( "nOpenCharCreate" );
			net.WriteUInt( CC_CREATE, 3 );
		net.Send( self );
		
	end
	
end

function meta:PostLoadPlayerInfo()
	
	net.Start( "nIntroStart" );
		net.WriteBit( false );
	net.Send( self );
	
	if( !self:SQLHasPlayer() ) then
		
		self:SQLSaveNewPlayer();
		
	else
		
		self:LoadPlayer( self.SQLPlayerData );
		self:LoadCharsInfo();
		
	end
	
	self:UpdateCharacterField( "LastName", self:Nick() );
	
end

function meta:LoadCharsInfo()
	
	local function qS( ret )
		
		self.SQLCharData = ret;
		self:PostLoadCharsInfo();
		
	end
	
	local function qF( err )
		
		self.SQLCharData = { };
		self:PostLoadCharsInfo();
		
	end
	
	mysqloo.Query( "SELECT * FROM cc_chars WHERE SteamID = '" .. self:SteamID() .. "'", qS, qF );
	
end

function meta:LoadPlayerInfo()
	
	local function qS( ret )
		
		self.SQLPlayerData = ret[1];
		self:PostLoadPlayerInfo();
		
	end
	
	local function qF( err )
		
		self.SQLPlayerData = { };
		self:PostLoadPlayerInfo();
		
	end
	
	mysqloo.Query( "SELECT * FROM cc_players WHERE SteamID = '" .. self:SteamID() .. "'", qS, qF );
	
end

function meta:SQLCharExists( id )
	
	for _, v in pairs( self.SQLCharData ) do
		
		if( tonumber( v.id ) == id ) then
			
			return true;
			
		end
		
	end
	
	return false;
	
end

function meta:SQLHasPlayer()
	
	return self.SQLPlayerData and table.Count( self.SQLPlayerData ) > 0;
	
end

function meta:SQLGetNumChars()
	
	if( !self.SQLCharData ) then return 0 end
	
	return #self.SQLCharData;
	
end

function meta:GetCharFromID( id )
	
	for _, v in pairs( self.SQLCharData ) do
		
		if( tonumber( v.id ) == id ) then
			
			return v;
			
		end
		
	end
	
end

function meta:GetCharIndexFromID( id )
	
	for k, v in pairs( self.SQLCharData ) do
		
		if( tonumber( v.id ) == id ) then
			
			return k;
			
		end
		
	end
	
end

function meta:SaveNewCharacter( name, title, model, stats, trait )
	
	local cid = math.random( 1, 99999 );
	local d = os.date( "!%m/%d/%y %H:%M:%S" );
	
	local function qS( ret, qo )
		
		GAMEMODE:LogSQL( "Player " .. self:Nick() .. " created character " .. name .. "." );
		
		local tab = { };
		
		for _, v in pairs( CharTable ) do
			
			if( v[3] ) then
				
				tab[v[1]] = tostring( v[3] );
				
			end
			
		end
		
		tab["SteamID"] = self:SteamID();
		tab["RPName"] = name;
		tab["Title"] = title;
		tab["Model"] = model;
		tab["Trait"] = trait;
		tab["CID"] = tostring( cid );
		tab["Date"] = d;
		tab["LastOnline"] = d;
		
		if( trait == TRAIT_LOYALIST ) then
			
			tab["Inventory"] = "crdevice:1";
			
		end
		
		for k, v in pairs( stats ) do
			
			tab["Stat" .. k] = v;
			
		end
		
		tab["id"] = tonumber( qo:lastInsert() );
		
		table.insert( self.SQLCharData, tab );
		
		net.Start( "nCharacterList" );
			net.WriteTable( self.SQLCharData );
		net.Send( self );
		
		self:LoadCharacter( tab );
		
	end
	
	local add = "";
	
	if( trait == TRAIT_LOYALIST ) then
		
		add = ", Inventory";
		
	end
	
	local str = "INSERT INTO cc_chars ( SteamID, RPName, Title, Model, Trait, CID, Date" .. add;
	
	for k, v in pairs( stats ) do
		
		str = str .. ", Stat" .. k;
		
	end
	
	str = str .. " ) VALUES ( '" .. self:SteamID() .. "', '" .. mysqloo.Escape( name ) .. "', '" .. mysqloo.Escape( title ) .. "', '" .. model .. "', '" .. trait .. "', '" .. tostring( cid ) .. "', '" .. d .. "'";
	
	if( trait == TRAIT_LOYALIST ) then
		
		str = str .. ", 'crdevice:1'";
		
	end
	
	for k, v in pairs( stats ) do
		
		str = str .. ", '" .. tostring( v ) .. "'";
		
	end
	
	str = str .. " );";
	
	mysqloo.Query( str, qS );
	
end

function GM:DeleteCharacter( id, deleter, name )
	
	local function qS()
		
		GAMEMODE:LogSQL( "Player " .. deleter .. " deleted character " .. name .. "." );
		
	end
	
	mysqloo.Query( "DELETE FROM cc_chars WHERE id = '" .. tostring( id ) .. "'", qS );
	
end

function meta:DeleteCharacter( id, name )
	
	for k, v in pairs( self.SQLCharData ) do
		
		if( v.id == id ) then
			
			table.remove( self.SQLCharData, k );
			
		end
		
	end
	
	local function qS()
		
		GAMEMODE:LogSQL( "Player " .. self:Nick() .. " deleted character " .. name .. "." );
		
	end
	
	mysqloo.Query( "DELETE FROM cc_chars WHERE id = '" .. tostring( id ) .. "'", qS );
	
end

function meta:UpdateCharacterField( field, value, nolog )
	
	if( self:IsBot() ) then return end
	if( self:CharID() == -1 ) then return end
	
	if( self.SQLCharData[self:GetCharIndexFromID( self:CharID() )][field] == tostring( value ) ) then return end
	
	local q = "UPDATE cc_chars";
	q = q .. " SET " .. mysqloo.Escape( field );
	q = q .. " = '" .. mysqloo.Escape( tostring( value ) );
	q = q .. "' WHERE id = '" .. self:CharID() .. "'";
	
	local function qS( ret )
		
		if( !nolog ) then
			
			GAMEMODE:LogSQL( "Player " .. self:Nick() .. " (" .. self:RPName() .. ") updated character field " .. field .. " to " .. tostring( value ) .. "." );
			
		end
		
		self.SQLCharData[self:GetCharIndexFromID( self:CharID() )][field] = tostring( value );
		
	end
	
	mysqloo.Query( q, qS );
	
end

function GM:UpdateCharacterFieldOffline( id, field, value, nolog )
	
	local q = "UPDATE cc_chars";
	q = q .. " SET " .. mysqloo.Escape( field );
	q = q .. " = '" .. mysqloo.Escape( tostring( value ) );
	q = q .. "' WHERE id = '" .. id .. "'";
	
	local function qS( ret )
		
		if( !nolog ) then
			
			GAMEMODE:LogSQL( "Character " .. id .. " updated character field " .. field .. " to " .. tostring( value ) .. "." );
			
		end
		
	end
	
	mysqloo.Query( q, qS );
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v.SQLCharData["id"] == id ) then
			
			v.SQLCharData[field] = value;
			
		end
		
	end
	
end

function GM:AddCharacterFieldOffline( id, field, value, min, max )
	
	local q = "SELECT " .. field .. " FROM cc_chars WHERE id = '" .. id .. "'";
	
	local function qS( ret )
		
		local q = "UPDATE cc_chars";
		q = q .. " SET " .. mysqloo.Escape( field );
		q = q .. " = '" .. mysqloo.Escape( tostring( math.Clamp( tonumber( ret[1][field] ) + tonumber( value ), min or -math.huge, max or math.huge ) ) );
		q = q .. "' WHERE id = '" .. id .. "'";
		
		local function qS( ret )
			
			GAMEMODE:LogSQL( "Character " .. id .. " updated character field " .. field .. " to " .. tostring( value ) .. "." );
			
		end
		
		mysqloo.Query( q, qS );
		
	end
	
	mysqloo.Query( q, qS );
	
end

function meta:UpdatePlayerField( field, value )
	
	local q = "UPDATE cc_players";
	q = q .. " SET " .. mysqloo.Escape( field );
	q = q .. " = '" .. mysqloo.Escape( tostring( value ) );
	q = q .. "' WHERE SteamID = '" .. self:SteamID() .. "'";
	
	local function qS( ret )
		
		GAMEMODE:LogSQL( "Player " .. self:Nick() .. " (" .. self:RPName() .. ") updated player field " .. field .. " to " .. tostring( value ) .. "." );
		
		self.SQLPlayerData[field] = tostring( value );
		
	end
	
	mysqloo.Query( q, qS );
	
end

function GM:UpdatePlayerFieldOffline( steamid, field, value )
	
	local q = "UPDATE cc_players";
	q = q .. " SET " .. mysqloo.Escape( field );
	q = q .. " = '" .. mysqloo.Escape( tostring( value ) );
	q = q .. "' WHERE SteamID = '" .. steamid .. "'";
	
	local function qS( ret )
		
		GAMEMODE:LogSQL( "Player " .. steamid .. " updated player field " .. field .. " to " .. tostring( value ) .. "." );
		
	end
	
	mysqloo.Query( q, qS );
	
end

function GM:SQLThink()
	
	if( !self.NextCheckDonations ) then self.NextCheckDonations = CurTime() end
	
	if( CurTime() > self.NextCheckDonations ) then
		
		self.NextCheckDonations = CurTime() + 30;
		self:CheckDonations();
		
	end
	
end

function GM:CheckDonations()
	
	local function qS( ret )
		
		if( #ret > 0 ) then
			
			self:LogSQL( #ret .. " donations loaded." );
			
			self:ProcessDonation( ret );
			
		end
		
	end
	
	mysqloo.Query( "SELECT * FROM cc_donations", qS );
	
end

function GM:ProcessDonation( data )
	
	local affected = { };
	
	for _, tab in pairs( data ) do
		
		local s = tab.SteamID;
		local c = tonumber( tab.CharID );
		local d = tonumber( tab.DonationType );
		local dd = tab.DonationData;
		
		local ply = nil;
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:SteamID() == s ) then
				
				ply = v;
				break;
				
			end
			
		end
		
		if( ply ) then
			
			if( !table.HasValue( affected, ply ) ) then
				
				table.insert( affected, ply );
				
			end
			
			if( c > -1 ) then
				
				if( ply:CharID() == c ) then
					
					if( d == DONATION_CHAR_CREDITS ) then
						
						ply:AddMoney( tonumber( dd ) );
						ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
						
					elseif( d == DONATION_CHAR_STATSTRENGTH ) then
						
						ply:SetStrength( math.Clamp( ply:Strength() + tonumber( dd ), 0, 100 ) );
						ply:UpdateCharacterField( "StatStrength", tostring( ply:Strength() ) );
						
					elseif( d == DONATION_CHAR_STATSPEED ) then
						
						ply:SetSpeed( math.Clamp( ply:Speed() + tonumber( dd ), 0, 100 ) );
						ply:UpdateCharacterField( "StatSpeed", tostring( ply:Speed() ) );
						
					elseif( d == DONATION_CHAR_STATTOUGHNESS ) then
						
						ply:SetToughness( math.Clamp( ply:Toughness() + tonumber( dd ), 0, 100 ) );
						ply:UpdateCharacterField( "StatToughness", tostring( ply:Toughness() ) );
						
					elseif( d == DONATION_CHAR_STATAGILITY ) then
						
						ply:SetAgility( math.Clamp( ply:Agility() + tonumber( dd ), 0, 100 ) );
						ply:UpdateCharacterField( "StatAgility", tostring( ply:Agility() ) );
						
					elseif( d == DONATION_CHAR_STATPERCEPTION ) then
						
						ply:SetPerception( math.Clamp( ply:Perception() + tonumber( dd ), 0, 100 ) );
						ply:UpdateCharacterField( "StatPerception", tostring( ply:Perception() ) );
						
					elseif( d == DONATION_CHAR_STATAIM ) then
						
						ply:SetAim( math.Clamp( ply:Aim() + tonumber( dd ), 0, 100 ) );
						ply:UpdateCharacterField( "StatAim", tostring( ply:Aim() ) );
						
					elseif( d == DONATION_CHAR_STATS ) then
						
						ply:SetStrength( math.Clamp( ply:Strength() + tonumber( dd ), 0, 100 ) );
						ply:UpdateCharacterField( "StatStrength", tostring( ply:Strength() ) );
						
						ply:SetSpeed( math.Clamp( ply:Speed() + tonumber( dd ), 0, 100 ) );
						ply:UpdateCharacterField( "StatSpeed", tostring( ply:Speed() ) );
						
						ply:SetToughness( math.Clamp( ply:Toughness() + tonumber( dd ), 0, 100 ) );
						ply:UpdateCharacterField( "StatToughness", tostring( ply:Toughness() ) );
						
						ply:SetAgility( math.Clamp( ply:Agility() + tonumber( dd ), 0, 100 ) );
						ply:UpdateCharacterField( "StatAgility", tostring( ply:Agility() ) );
						
						ply:SetPerception( math.Clamp( ply:Perception() + tonumber( dd ), 0, 100 ) );
						ply:UpdateCharacterField( "StatPerception", tostring( ply:Perception() ) );
						
						ply:SetAim( math.Clamp( ply:Aim() + tonumber( dd ), 0, 100 ) );
						ply:UpdateCharacterField( "StatAim", tostring( ply:Aim() ) );
						
					elseif( d == DONATION_CHAR_MODEL ) then
						
						ply:SetModelCC( dd );
						ply.CharModel = dd;
						ply:UpdateCharacterField( "Model", dd );
						
					else
						
						GAMEMODE:LogBug( "ERROR: Unhandled character donation type " .. d .. "." );
						
					end
					
				else
					
					if( d == DONATION_CHAR_CREDITS ) then
						
						GAMEMODE:AddCharacterFieldOffline( c, "Money", tonumber( dd ) );
						
					elseif( d == DONATION_CHAR_STATSTRENGTH ) then
						
						GAMEMODE:AddCharacterFieldOffline( c, "StatStrength", tonumber( dd ), 0, 100 );
						
					elseif( d == DONATION_CHAR_STATSPEED ) then
						
						GAMEMODE:AddCharacterFieldOffline( c, "StatSpeed", tonumber( dd ), 0, 100 );
						
					elseif( d == DONATION_CHAR_STATTOUGHNESS ) then
						
						GAMEMODE:AddCharacterFieldOffline( c, "StatToughness", tonumber( dd ), 0, 100 );
						
					elseif( d == DONATION_CHAR_STATAGILITY ) then
						
						GAMEMODE:AddCharacterFieldOffline( c, "StatAgility", tonumber( dd ), 0, 100 );
						
					elseif( d == DONATION_CHAR_STATPERCEPTION ) then
						
						GAMEMODE:AddCharacterFieldOffline( c, "StatPerception", tonumber( dd ), 0, 100 );
						
					elseif( d == DONATION_CHAR_STATAIM ) then
						
						GAMEMODE:AddCharacterFieldOffline( c, "StatAim", tonumber( dd ), 0, 100 );
						
					elseif( d == DONATION_CHAR_STATS ) then
						
						GAMEMODE:AddCharacterFieldOffline( c, "StatStrength", tonumber( dd ), 0, 100 );
						GAMEMODE:AddCharacterFieldOffline( c, "StatSpeed", tonumber( dd ), 0, 100 );
						GAMEMODE:AddCharacterFieldOffline( c, "StatToughness", tonumber( dd ), 0, 100 );
						GAMEMODE:AddCharacterFieldOffline( c, "StatAgility", tonumber( dd ), 0, 100 );
						GAMEMODE:AddCharacterFieldOffline( c, "StatPerception", tonumber( dd ), 0, 100 );
						GAMEMODE:AddCharacterFieldOffline( c, "StatAim", tonumber( dd ), 0, 100 );
						
					elseif( d == DONATION_CHAR_MODEL ) then
						
						GAMEMODE:UpdateCharacterFieldOffline( c, "Model", dd );
						
					else
						
						GAMEMODE:LogBug( "ERROR: Unhandled character donation type " .. d .. "." );
						
					end
					
				end
				
			else
				
				if( d == DONATION_PLY_PROPLIMIT ) then
					
					ply:SetCustomMaxProps( tonumber( dd ) );
					ply:UpdatePlayerField( "CustomMaxProps", tostring( ply:CustomMaxProps() ) );
					
				elseif( d == DONATION_PLY_RAGDOLLLIMIT ) then
					
					ply:SetCustomMaxRagdolls( tonumber( dd ) );
					ply:UpdatePlayerField( "CustomMaxRagdolls", tostring( ply:CustomMaxRagdolls() ) );
					
				elseif( d == DONATION_PLY_SCOREBOARDTITLE ) then
					
					ply:SetScoreboardTitle( dd );
					ply:UpdatePlayerField( "ScoreboardTitle", tostring( ply:ScoreboardTitle() ) );
					
				elseif( d == DONATION_PLY_SCOREBOARDTITLECOLOR ) then
					
					ply:SetScoreboardTitleC( Vector( dd ) );
					ply:UpdatePlayerField( "ScoreboardTitleC", tostring( ply:ScoreboardTitleC() ) );
					
				else
					
					GAMEMODE:LogBug( "ERROR: Unhandled player donation type " .. d .. "." );
					
				end
				
			end
			
		else
			
			if( c > -1 ) then
				
				if( d == DONATION_CHAR_CREDITS ) then
					
					GAMEMODE:AddCharacterFieldOffline( c, "Money", tonumber( dd ) );
					
				elseif( d == DONATION_CHAR_STATSTRENGTH ) then
					
					GAMEMODE:AddCharacterFieldOffline( c, "StatStrength", tonumber( dd ), 0, 100 );
					
				elseif( d == DONATION_CHAR_STATSPEED ) then
					
					GAMEMODE:AddCharacterFieldOffline( c, "StatSpeed", tonumber( dd ), 0, 100 );
					
				elseif( d == DONATION_CHAR_STATTOUGHNESS ) then
					
					GAMEMODE:AddCharacterFieldOffline( c, "StatToughness", tonumber( dd ), 0, 100 );
					
				elseif( d == DONATION_CHAR_STATAGILITY ) then
					
					GAMEMODE:AddCharacterFieldOffline( c, "StatAgility", tonumber( dd ), 0, 100 );
					
				elseif( d == DONATION_CHAR_STATPERCEPTION ) then
					
					GAMEMODE:AddCharacterFieldOffline( c, "StatPerception", tonumber( dd ), 0, 100 );
					
				elseif( d == DONATION_CHAR_STATAIM ) then
					
					GAMEMODE:AddCharacterFieldOffline( c, "StatAim", tonumber( dd ), 0, 100 );
					
				elseif( d == DONATION_CHAR_STATS ) then
					
					GAMEMODE:AddCharacterFieldOffline( c, "StatStrength", tonumber( dd ), 0, 100 );
					GAMEMODE:AddCharacterFieldOffline( c, "StatSpeed", tonumber( dd ), 0, 100 );
					GAMEMODE:AddCharacterFieldOffline( c, "StatToughness", tonumber( dd ), 0, 100 );
					GAMEMODE:AddCharacterFieldOffline( c, "StatAgility", tonumber( dd ), 0, 100 );
					GAMEMODE:AddCharacterFieldOffline( c, "StatPerception", tonumber( dd ), 0, 100 );
					GAMEMODE:AddCharacterFieldOffline( c, "StatAim", tonumber( dd ), 0, 100 );
					
				elseif( d == DONATION_CHAR_MODEL ) then
					
					GAMEMODE:UpdateCharacterFieldOffline( c, "Model", dd );
					
				else
					
					GAMEMODE:LogBug( "ERROR: Unhandled character donation type " .. d .. "." );
					
				end
				
			else
				
				if( d == DONATION_PLY_PROPLIMIT ) then
					
					GAMEMODE:UpdatePlayerFieldOffline( s, "CustomMaxProps", dd );
					
				elseif( d == DONATION_PLY_RAGDOLLLIMIT ) then
					
					GAMEMODE:UpdatePlayerFieldOffline( s, "CustomMaxRagdolls", dd );
					
				elseif( d == DONATION_PLY_SCOREBOARDTITLE ) then
					
					GAMEMODE:UpdatePlayerFieldOffline( s, "ScoreboardTitle", dd );
					
				elseif( d == DONATION_PLY_SCOREBOARDTITLECOLOR ) then
					
					GAMEMODE:UpdatePlayerFieldOffline( s, "ScoreboardTitleC", dd );
					
				else
					
					GAMEMODE:LogBug( "ERROR: Unhandled player donation type " .. d .. "." );
					
				end
				
			end
			
		end
		
	end
	
	net.Start( "nDonationProcess" );
	net.Send( affected );
	
	mysqloo.Query( "TRUNCATE TABLE cc_donations", qS );
	
end

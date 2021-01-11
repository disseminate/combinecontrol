-- 5/25/2013

DeriveGamemode( "sandbox" );

GM.Name = "CombineControl";
GM.Author = "Kyle 'disseminate' Windsor";
GM.Website = "";
GM.Email = "";

function GM:GetGameDescription()
	
	return self.Name;
	
end

math.randomseed( os.time() );

local meta = FindMetaTable( "Player" );
local emeta = FindMetaTable( "Entity" );

function GM:CreateTeams()

	team.SetUp( TEAM_CITIZEN, "Citizens", Color( 0, 120, 0, 255 ), false );
	team.SetUp( TEAM_COMBINE, "Combine", Color( 33, 106, 196, 255 ), false );
	team.SetUp( TEAM_OFFCOMBINE, "Off-Duty Combine", Color( 0, 120, 0, 255 ), false );
	team.SetUp( TEAM_STALKER, "Stalkers", Color( 86, 86, 86, 255 ), false );
	team.SetUp( TEAM_VORTIGAUNT, "Vortigaunts", Color( 65, 204, 118, 255 ), false );
	team.SetUp( TEAM_OVERWATCH, "Overwatch", Color( 200, 200, 200, 255 ), false );
	
end

GM.ModelColors = { };

for _, v in pairs( GM.CitizenModels ) do
	GM.ModelColors[v] = Vector( 15, 71, 93 ) / 255;
end

for _, v in pairs( GM.RebelModels ) do
	GM.ModelColors[v] = Vector( 98, 112, 66 ) / 255;
end

GM.ModelColors["models/player/combine_soldier.mdl"] = Vector( 0, 0.8, 1 );
GM.ModelColors["models/player/combine_super_soldier.mdl"] = Vector( 0.4, 0, 0 );

GM.ModelFuncs = { };
GM.ModelFuncs["models/zombie/classic.mdl"] = function( ply )
	
	ply:SetBodygroup( 1, 1 );
	
end
GM.ModelFuncs["models/zombie/fast.mdl"] = GM.ModelFuncs["models/zombie/classic.mdl"];
GM.ModelFuncs["models/zombie/poison.mdl"] = GM.ModelFuncs["models/zombie/classic.mdl"];
GM.ModelFuncs["models/zombie/classic_torso.mdl"] = GM.ModelFuncs["models/zombie/classic.mdl"];

GM.TranslateNPCModelTable = { };
GM.TranslateNPCModelTable["models/humans/group01/female_01.mdl"] = "models/player/group01/female_01.mdl";
GM.TranslateNPCModelTable["models/humans/group01/female_02.mdl"] = "models/player/group01/female_02.mdl";
GM.TranslateNPCModelTable["models/humans/group01/female_03.mdl"] = "models/player/group01/female_03.mdl";
GM.TranslateNPCModelTable["models/humans/group01/female_04.mdl"] = "models/player/group01/female_04.mdl";
GM.TranslateNPCModelTable["models/humans/group01/female_06.mdl"] = "models/player/group01/female_05.mdl";
GM.TranslateNPCModelTable["models/humans/group01/female_07.mdl"] = "models/player/group01/female_06.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_01.mdl"] = "models/player/group01/male_01.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_02.mdl"] = "models/player/group01/male_02.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_03.mdl"] = "models/player/group01/male_03.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_04.mdl"] = "models/player/group01/male_04.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_05.mdl"] = "models/player/group01/male_05.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_06.mdl"] = "models/player/group01/male_06.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_07.mdl"] = "models/player/group01/male_07.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_08.mdl"] = "models/player/group01/male_08.mdl";
GM.TranslateNPCModelTable["models/humans/group01/male_09.mdl"] = "models/player/group01/male_09.mdl";
GM.TranslateNPCModelTable["models/humans/group03/female_01.mdl"] = "models/player/group03/female_01.mdl";
GM.TranslateNPCModelTable["models/humans/group03/female_02.mdl"] = "models/player/group03/female_02.mdl";
GM.TranslateNPCModelTable["models/humans/group03/female_03.mdl"] = "models/player/group03/female_03.mdl";
GM.TranslateNPCModelTable["models/humans/group03/female_04.mdl"] = "models/player/group03/female_04.mdl";
GM.TranslateNPCModelTable["models/humans/group03/female_06.mdl"] = "models/player/group03/female_05.mdl";
GM.TranslateNPCModelTable["models/humans/group03/female_07.mdl"] = "models/player/group03/female_06.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_01.mdl"] = "models/player/group03/male_01.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_02.mdl"] = "models/player/group03/male_02.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_03.mdl"] = "models/player/group03/male_03.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_04.mdl"] = "models/player/group03/male_04.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_05.mdl"] = "models/player/group03/male_05.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_06.mdl"] = "models/player/group03/male_06.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_07.mdl"] = "models/player/group03/male_07.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_08.mdl"] = "models/player/group03/male_08.mdl";
GM.TranslateNPCModelTable["models/humans/group03/male_09.mdl"] = "models/player/group03/male_09.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/female_01.mdl"] = "models/player/group03m/female_01.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/female_02.mdl"] = "models/player/group03m/female_02.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/female_03.mdl"] = "models/player/group03m/female_03.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/female_04.mdl"] = "models/player/group03m/female_04.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/female_06.mdl"] = "models/player/group03m/female_05.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/female_07.mdl"] = "models/player/group03m/female_06.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_01.mdl"] = "models/player/group03m/male_01.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_02.mdl"] = "models/player/group03m/male_02.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_03.mdl"] = "models/player/group03m/male_03.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_04.mdl"] = "models/player/group03m/male_04.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_05.mdl"] = "models/player/group03m/male_05.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_06.mdl"] = "models/player/group03m/male_06.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_07.mdl"] = "models/player/group03m/male_07.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_08.mdl"] = "models/player/group03m/male_08.mdl";
GM.TranslateNPCModelTable["models/humans/group03m/male_09.mdl"] = "models/player/group03m/male_09.mdl";
GM.TranslateNPCModelTable["female_01"] = "models/player/group01/female_01.mdl";
GM.TranslateNPCModelTable["female_02"] = "models/player/group01/female_02.mdl";
GM.TranslateNPCModelTable["female_03"] = "models/player/group01/female_03.mdl";
GM.TranslateNPCModelTable["female_04"] = "models/player/group01/female_04.mdl";
GM.TranslateNPCModelTable["female_05"] = "models/player/group01/female_05.mdl";
GM.TranslateNPCModelTable["female_06"] = "models/player/group01/female_05.mdl";
GM.TranslateNPCModelTable["female_07"] = "models/player/group01/female_06.mdl";
GM.TranslateNPCModelTable["male_01"] = "models/player/group01/male_01.mdl";
GM.TranslateNPCModelTable["male_02"] = "models/player/group01/male_02.mdl";
GM.TranslateNPCModelTable["male_03"] = "models/player/group01/male_03.mdl";
GM.TranslateNPCModelTable["male_04"] = "models/player/group01/male_04.mdl";
GM.TranslateNPCModelTable["male_05"] = "models/player/group01/male_05.mdl";
GM.TranslateNPCModelTable["male_06"] = "models/player/group01/male_06.mdl";
GM.TranslateNPCModelTable["male_07"] = "models/player/group01/male_07.mdl";
GM.TranslateNPCModelTable["male_08"] = "models/player/group01/male_08.mdl";
GM.TranslateNPCModelTable["male_09"] = "models/player/group01/male_09.mdl";
GM.TranslateNPCModelTable["breen"] = "models/breen.mdl";
GM.TranslateNPCModelTable["gman"] = "models/gman.mdl";
GM.TranslateNPCModelTable["models/combine_soldier.mdl"] = "models/player/combine_soldier.mdl";
GM.TranslateNPCModelTable["models/combine_super_soldier.mdl"] = "models/player/combine_super_soldier.mdl";

GM.TranslatePlayerModelTable = { };
GM.TranslatePlayerModelTable["models/player/group01/female_01.mdl"] = "models/humans/group01/female_01.mdl";
GM.TranslatePlayerModelTable["models/player/group01/female_02.mdl"] = "models/humans/group01/female_02.mdl";
GM.TranslatePlayerModelTable["models/player/group01/female_03.mdl"] = "models/humans/group01/female_03.mdl";
GM.TranslatePlayerModelTable["models/player/group01/female_04.mdl"] = "models/humans/group01/female_04.mdl";
GM.TranslatePlayerModelTable["models/player/group01/female_05.mdl"] = "models/humans/group01/female_06.mdl";
GM.TranslatePlayerModelTable["models/player/group01/female_06.mdl"] = "models/humans/group01/female_07.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_01.mdl"] = "models/humans/group01/male_01.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_02.mdl"] = "models/humans/group01/male_02.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_03.mdl"] = "models/humans/group01/male_03.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_04.mdl"] = "models/humans/group01/male_04.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_05.mdl"] = "models/humans/group01/male_05.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_06.mdl"] = "models/humans/group01/male_06.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_07.mdl"] = "models/humans/group01/male_07.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_08.mdl"] = "models/humans/group01/male_08.mdl";
GM.TranslatePlayerModelTable["models/player/group01/male_09.mdl"] = "models/humans/group01/male_09.mdl";

function meta:SetModelCC( mdl )
	
	self:SetModel( mdl );
	self:SetSkin( 0 );
	for i = 0,  20 do
		self:SetBodygroup( i, 0 );
		self:SetSubMaterial( i, "" );
	end
	
	if( GAMEMODE.ModelFuncs[mdl] ) then
		
		GAMEMODE.ModelFuncs[mdl]( self );
		
	end
	
	if( GAMEMODE.ModelColors[mdl] ) then
		
		self:SetPlayerColor( GAMEMODE.ModelColors[mdl] );
		
	end
	
	if( self:GetViewModel( 0 ) and self:GetViewModel( 0 ):IsValid() ) then
		
		self:SetupHands();
		
	end
	
	if( string.find( mdl, "group03m" ) ) then
		
		self:SetArmor( 75 );
		
	elseif( string.find( mdl, "group03" ) ) then
		
		self:SetArmor( 100 );
		
	elseif( string.find( mdl, "police" ) ) then
		
		self:SetArmor( 100 );
		
	elseif( string.find( mdl, "combine_soldier" ) or string.find( mdl, "combine_super_soldier" ) ) then
		
		self:SetArmor( 100 );
		
	else
		
		self:SetArmor( 0 );
		
	end
	
end

function GM:TranslateModelToPlayer( mdl )
	
	for k, v in pairs( player_manager.AllValidModels() ) do
		
		if( string.lower( v ) == string.lower( mdl ) ) then
			
			return k;
			
		end
		
	end
	
	return "kleiner";
	
end

function meta:TranslatePlayerModel()
	
	if( string.find( self:GetModel(), "group01" ) ) then return "group01" end
	if( string.find( self:GetModel(), "group03m" ) ) then return "group03m" end
	if( string.find( self:GetModel(), "group03" ) ) then return "group03" end
	
end

function XRES( x )
	
	return x * ( ScrW() / 640 );
	
end

function YRES( y )
	
	return y * ( ScrH() / 480 );
	
end

function meta:Gender()
	
	local mdl = string.lower( self.CharModel or self:GetModel() );
	
	if( string.find( mdl, "female" ) ) then return GENDER_FEMALE end
	if( mdl == "models/player/alyx.mdl" ) then return GENDER_FEMALE end
	if( mdl == "models/player/mossman.mdl" ) then return GENDER_FEMALE end
	if( mdl == "models/player/mossman_arctic.mdl" ) then return GENDER_FEMALE end
	if( mdl == "models/player/p2_chell.mdl" ) then return GENDER_FEMALE end
	
	if( mdl == "models/player/police_fem.mdl" ) then return GENDER_CP end
	if( mdl == "models/player/police.mdl" ) then return GENDER_CP end
	
	if( mdl == "models/vortigaunt.mdl" ) then return GENDER_VORT end
	if( mdl == "models/vortigaunt_slave.mdl" ) then return GENDER_VORT end
	if( mdl == "models/vortigaunt_doctor.mdl" ) then return GENDER_VORT end
	
	return GENDER_MALE;
	
end

function GM:FindPlayer( name, caller )
	
	name = string.lower( name );
	
	if( name == "^" ) then
		
		return caller;
		
	end
	
	if( name == "-" ) then
		
		local tr = caller:GetEyeTrace();
		
		if( tr.Entity and tr.Entity:IsValid() and tr.Entity:IsPlayer() ) then
			
			return tr.Entity;
			
		end
		
	end
	
	for k, v in pairs( player.GetAll() ) do
		
		if( tonumber( name ) == v:CID() or tonumber( name ) == v:FormattedCID() ) then
			return v;
		end
		
		if( string.find( string.lower( v:VisibleRPName() ), name, nil, true ) ) then
			return v;
		end
		
		if( string.find( string.lower( v:RPName() ), name, nil, true ) ) then
			return v;
		end
		
		if( string.find( string.lower( v:Nick() ), name, nil, true ) ) then
			return v;
		end
		
		if( string.lower( v:SteamID() ) == name ) then
			return v;
		end
		
	end

end

local allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -";

function GM:CheckCharacterValidity( name, desc, model, sum, trait )
	
	if( string.len( name ) < self.MinNameLength ) then
		return false, "Name must be longer than " .. self.MinNameLength .. " characters.";
	end
	
	if( string.len( name ) > self.MaxNameLength ) then
		return false, "Name must be shorter than " .. self.MaxNameLength .. " characters.";
	end
	
	if( string.len( desc ) > self.MaxDescLength ) then
		return false, "Description must be shorter than " .. self.MaxDescLength .. " characters.";
	end
	
	if( !table.HasValue( self.CitizenModels, string.lower( model ) ) ) then
		return false, "Invalid model.";
	end
	
	if( string.find( name, "#", nil, true ) or string.find( name, "~", nil, true ) or string.find( name, "%", nil, true ) ) then
		return false, "Invalid name.";
	end
	
	if( sum < 0 or sum > GAMEMODE.StatsAvailable ) then
		return false, "Too many stats allocated.";
	end
	
	if( !self.Traits[trait] ) then
		return false, "Invalid trait.";
	end
	
	if( string.find( allowedChars, name, 1, true ) ) then
		return false, "Invalid characters in name.";
	end
	
	return true;
	
end

function GM:FormatLine( str, font, size )
	
	if( string.len( str ) == 1 ) then return str, 0 end
	
	local start = 1;
	local c = 1;
	
	surface.SetFont( font );
	
	local endstr = "";
	local n = 0;
	local lastspace = 0;
	local lastspacemade = 0;
	
	while( string.len( str or "" ) > c ) do
	
		local sub = string.sub( str, start, c );
	
		if( string.sub( str, c, c ) == " " ) then
			lastspace = c;
		end
		
		if( surface.GetTextSize( sub ) >= size and lastspace ~= lastspacemade ) then
			
			local sub2;
			
			if( lastspace == 0 ) then
				lastspace = c;
				lastspacemade = c;
			end
			
			if( lastspace > 1 ) then
				sub2 = string.sub( str, start, lastspace - 1 );
				c = lastspace;
			else
				sub2 = string.sub( str, start, c );
			end
			
			endstr = endstr .. sub2 .. "\n";
			
			lastspace = c + 1;
			lastspacemade = lastspace;
			
			start = c + 1;
			n = n + 1;
		
		end
	
		c = c + 1;
	
	end
	
	if( start < string.len( str or "" ) ) then
	
		endstr = endstr .. string.sub( str or "", start );
	
	end
	
	return endstr, n;

end

function GM:CanSeePos( pos1, pos2, filter )
	
	local trace = { };
	trace.start = pos1;
	trace.endpos = pos2;
	trace.filter = filter;
	trace.mask = MASK_SOLID + CONTENTS_WINDOW + CONTENTS_GRATE;
	local tr = util.TraceLine( trace );
	
	if( tr.Fraction == 1.0 ) then
		
		return true;
		
	end
	
	return false;
	
end

function meta:CanSee( ent )
	
	return GAMEMODE:CanSeePos( self:EyePos(), ent:EyePos(), { self, ent } );
	
end

function meta:CanHear( ent )
	
	local trace = { };
	trace.start = self:EyePos();
	trace.endpos = ent:EyePos();
	trace.filter = self;
	trace.mask = MASK_SOLID;
	local tr = util.TraceLine( trace );
	
	if( IsValid( tr.Entity ) and tr.Entity:EntIndex() == ent:EntIndex() ) then
		
		return true;
		
	end
	
	return false;
	
end

function emeta:IsDoor()
	
	if( self:GetClass() == "prop_door_rotating" ) then return true; end
	if( self:GetClass() == "func_door_rotating" ) then return true; end
	if( self:GetClass() == "func_door" ) then return true; end
	
	return false;
	
end

function GM:ShouldCollide( e1, e2 )
	
	return true;
	
end

function GM:GetHandTrace( ply, len )
	
	local trace = { };
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * ( len or 50 );
	trace.filter = ply;
	
	return util.TraceLine( trace );
	
end

function util.TimeSinceDate( d )
	
	if( !d or d == "" ) then return 0 end
	
	local c = os.date( "!*t" );
	
	local sides = string.Explode( " ", d );
	local d2 = string.Explode( "/", sides[1] );
	local t2 = string.Explode( ":", sides[2] );
	
	local cmonth = tonumber( d2[1] );
	local cday = tonumber( d2[2] );
	local cyear = tonumber( d2[3] );
	local chour = tonumber( t2[1] );
	local cmin = tonumber( t2[2] );
	local csec = tonumber( t2[3] );
	
	c.year = c.year - 2000;
	
	local count = ( c.year - cyear ) * 525600;
	count = count + ( c.month - cmonth ) * 43200;
	count = count + ( c.day - cday ) * 1440;
	count = count + ( c.hour - chour ) * 60;
	count = count + ( c.min - cmin );
	count = count + math.ceil( ( c.sec - csec ) / 60 );
	
	return count;
	
end

GM.Stats = {
	"Speed",
	"Strength",
	"Toughness",
	"Perception",
	"Agility",
	"Aim"
};

function GM:ScaledStatIncrease( ply, lvl )
	
	local rawmul = ( 15 - 1.025 ^ lvl ) / 25;
	
	rawmul = rawmul * ( 1 - math.Clamp( ply:Hunger() / 60, 0, 1 ) );
	
	return ( 15 - 1.025 ^ lvl ) / 25;
	
end

GM.Music = {
	{ "music/hl1_song3.mp3", 131, SONG_IDLE, "Black Mesa Inbound" },
	{ "music/hl1_song20.mp3", 84, SONG_IDLE, "Escape Array" },
	{ "music/hl1_song21.mp3", 84, SONG_IDLE, "Dirac Shore" },
	{ "music/hl2_song0.mp3", 39, SONG_IDLE, "Entanglement" },
	{ "music/hl2_song1.mp3", 98, SONG_IDLE, "Particle Ghost" },
	{ "music/hl2_song2.mp3", 172, SONG_IDLE, "Lab Practicum" },
	{ "music/hl2_song8.mp3", 59, SONG_IDLE, "Highway 17" },
	{ "music/hl2_song10.mp3", 29, SONG_IDLE, "A Red Letter Day" },
	{ "music/hl2_song11.mp3", 34, SONG_IDLE, "Sandtraps" },
	{ "music/hl2_song13.mp3", 53, SONG_IDLE, "Suppression Field" },
	{ "music/hl2_song17.mp3", 61, SONG_IDLE, "Broken Symmetry" },
	{ "music/hl2_song19.mp3", 115, SONG_IDLE, "Nova Prospekt" },
	{ "music/hl2_song26_trainstation1.mp3", 90, SONG_IDLE, "Train Station 1" },
	{ "music/hl2_song27_trainstation2.mp3", 72, SONG_IDLE, "Train Station 2" },
	{ "music/hl2_song30.mp3", 104, SONG_IDLE, "Calabi-Yau Model" },
	{ "music/hl1_song5.mp3", 96, SONG_ALERT, "Echoes of a Resonance Cascade" },
	{ "music/hl1_song6.mp3", 99, SONG_ALERT, "Zero Point Energy Field" },
	{ "music/hl1_song9.mp3", 93, SONG_ALERT, "Neutrino Trap" },
	{ "music/hl1_song11.mp3", 34, SONG_ALERT, "Hazardous Environments" },
	{ "music/hl1_song14.mp3", 90, SONG_ALERT, "Triple Entanglement" },
	{ "music/hl1_song17.mp3", 123, SONG_ALERT, "Tau-9" },
	{ "music/hl1_song19.mp3", 115, SONG_ALERT, "Negative Pressure" },
	{ "music/hl1_song24.mp3", 77, SONG_ALERT, "Singularity" },
	{ "music/hl1_song26.mp3", 37, SONG_ALERT, "Xen Relay" },
	{ "music/hl2_song7.mp3", 50, SONG_ALERT, "Ravenholm Reprise" },
	{ "music/hl2_song26.mp3", 69, SONG_ALERT, "Our Resurrected Teleport" },
	{ "music/hl2_song31.mp3", 98, SONG_ALERT, "Brane Scan" },
	{ "music/hl2_song32.mp3", 42, SONG_ALERT, "Slow Light" },
	{ "music/hl2_song33.mp3", 84, SONG_ALERT, "Probably Not a Problem" },
	{ "music/hl1_song10.mp3", 104, SONG_ACTION, "Lambda Core" },
	{ "music/hl1_song15.mp3", 120, SONG_ACTION, "Something Secret Steers Us" },
	{ "music/hl2_song3.mp3", 90, SONG_ACTION, "Dark Energy" },
	{ "music/hl2_song4.mp3", 65, SONG_ACTION, "The Innsbruck Experiment" },
	{ "music/hl2_song6.mp3", 45, SONG_ACTION, "Pulse Phase" },
	{ "music/hl2_song12_long.mp3", 73, SONG_ACTION, "Hard Fought" },
	{ "music/hl2_song14.mp3", 159, SONG_ACTION, "You're Not Supposed to Be Here" },
	{ "music/hl2_song15.mp3", 69, SONG_ACTION, "Kaon" },
	{ "music/hl2_song16.mp3", 170, SONG_ACTION, "LG Orbifold" },
	{ "music/hl2_song20_submix0.mp3", 103, SONG_ACTION, "CP Violation" },
	{ "music/hl2_song20_submix4.mp3", 139, SONG_ACTION, "CP Violation (remix)" },
	{ "music/hl2_song29.mp3", 135, SONG_ACTION, "Apprehension and Evasion" },
	{ "music/stingers/hl1_stinger_song7.mp3", 23, SONG_STINGER, "Apprehensive" },
	{ "music/stingers/hl1_stinger_song8.mp3", 9, SONG_STINGER, "Bass String" },
	{ "music/stingers/hl1_stinger_song16.mp3", 16, SONG_STINGER, "Scared Confusion" },
	{ "music/stingers/hl1_stinger_song27.mp3", 17, SONG_STINGER, "Dark Piano" },
	{ "music/stingers/hl1_stinger_song28.mp3", 7, SONG_STINGER, "Sharp Piano" },
};

GM.EP2Music = {
	{ "music/vlvx_song26.mp3", 110, SONG_IDLE, "Inhuman Frequency" },
	{ "music/vlvx_song3.mp3", 95, SONG_IDLE, "Dark Interval" },
	{ "music/vlvx_song15.mp3", 107, SONG_IDLE, "Nectarium" },
	{ "music/vlvx_song20.mp3", 124, SONG_IDLE, "Extinction Event Horizon" },
	{ "music/vlvx_song23ambient.mp3", 158, SONG_IDLE, "Shu'ulathoi" },
	{ "music/vlvx_song0.mp3", 62, SONG_ALERT, "No One Rides For Free" },
	{ "music/vlvx_song9.mp3", 74, SONG_ALERT, "Crawl Yard" },
	{ "music/vlvx_song25.mp3", 167, SONG_ALERT, "Abandoned In Place" },
	{ "music/vlvx_song28.mp3", 193, SONG_ALERT, "Eon Trap" },
	{ "music/vlvx_song22.mp3", 194, SONG_ACTION, "Vortal Combat" },
	{ "music/vlvx_song23.mp3", 166, SONG_ACTION, "Sector Sweep" },
	{ "music/vlvx_song24.mp3", 127, SONG_ACTION, "Last Legs" },
	{ "music/vlvx_song27.mp3", 209, SONG_ACTION, "Hunting Party" },
};

function GM:GetSongList( e )
	
	local tab = { };
	
	for _, v in pairs( self.Music ) do
		
		if( v[3] == e ) then
			
			table.insert( tab, v[1] );
			
		end
		
	end
	
	return tab;
	
end

GM.OverwatchLines = {
	{ "npc/overwatch/cityvoice/f_anticitizenreport_spkr.wav", "Attention, ground units. Anticitizen reported in this community. Code: lock, cauterize, stabilize." },
	{ "npc/overwatch/cityvoice/f_anticivil1_5_spkr.wav", "You are charged with anticivil activity level one. Protection units: prosecution code duty, sword, operate." },
	{ "npc/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav", "Protection team alert: Evidence of anticivil activity in this community. Code: assemble, clamp, contain." },
	{ "npc/overwatch/cityvoice/f_capitalmalcompliance_spkr.wav", "Individual: you are charged with capital malcompliance. Anticitizen status approved." },
	{ "npc/overwatch/cityvoice/f_ceaseevasionlevelfive_spkr.wav", "Individual: you are now charged with socioendangerment level five. Cease evasion immediately; receive your verdict." },
	{ "npc/overwatch/cityvoice/f_citizenshiprevoked_6_spkr.wav", "Individual: you are convicted of multi anticivil violations. Implicit citizenship revoked. Status: malignant." },
	{ "npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav", "Attention please: unidentified person of interest, confirm your civil status with local protection team immediately." },
	{ "npc/overwatch/cityvoice/f_evasionbehavior_2_spkr.wav", "Attention please: evasion behavior consistant with malcompliant defendant. Ground protection team: alert. Code: isolate, expose, administer." },
	{ "npc/overwatch/cityvoice/f_innactionisconspiracy_spkr.wav", "Citizen reminder: inaction is conspiracy. Report counterbehavior to a civil protection team immediately." },
	{ "npc/overwatch/cityvoice/f_localunrest_spkr.wav", "Alert, community ground protection units: local unrest structure detected. Assemble, administer, pacify." },
	{ "npc/overwatch/cityvoice/f_protectionresponse_1_spkr.wav", "Attention protection team: status evasion in progress in this community. Respond, isolate, inquire." },
	{ "npc/overwatch/cityvoice/f_protectionresponse_4_spkr.wav", "Attention all ground protection teams: autonomous judgement is now in effect. Sentencing is now discretionary. Code: amputate, zero, confirm." },
	{ "npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav", "Attention all ground protection teams: Judgement waiver now in effect. Capital prosecution is discretionary." },
	{ "npc/overwatch/cityvoice/f_rationunitsdeduct_3_spkr.wav", "Attention occupants: your block is now charged with permissive inactive coersion. Five ration units deducted." },
	{ "npc/overwatch/cityvoice/f_sociolevel1_4_spkr.wav", "Individual: you are charged with socioendangerment level one. Protection units, prosecution code: duty, sword, midnight." },
	{ "npc/overwatch/cityvoice/f_trainstation_assemble_spkr.wav", "Citizen notice: priority identification check in progress. Please assemble in your designated inspection positions." },
	{ "npc/overwatch/cityvoice/f_trainstation_assumepositions_spkr.wav", "Attention, please. All citizens in local residential block, assume your inspection positions." },
	{ "npc/overwatch/cityvoice/f_trainstation_cooperation_spkr.wav", "Attention, residents. Miscount detected in your block. Cooperation with your civil protection team permits full ration reward." },
	{ "npc/overwatch/cityvoice/f_trainstation_inform_spkr.wav", "Attention, residents. This block contains potential civil infection. Inform, cooperate, assemble." },
	{ "npc/overwatch/cityvoice/f_trainstation_offworldrelocation_spkr.wav", "Citizen notice: failure to cooperate will result in permanent offworld relocation." },
	{ "npc/overwatch/cityvoice/f_unrestprocedure1_spkr.wav", "Attention, community: unrest procedure code is now in effect. Inoculate, shield, pacify. Code: pressure, sword, sterilize." },
};

GM.BreenLines = {
	{ "scenes/breencast/collaboration.vcd", 0.08, 90.12 },
	{ "scenes/breencast/instinct.vcd", 0.730297, 213.636368 },
	{ "scenes/breencast/welcome.vcd", 0.628889, 40.253338 },
};

GM.BusinessLicenses = { };
GM.BusinessLicenses[LICENSE_FOOD] = { "Food/Drink", 500 };
GM.BusinessLicenses[LICENSE_ALCOHOL] = { "Alcohol", 700 };
GM.BusinessLicenses[LICENSE_ELECTRONICS] = { "Electronics", 1000 };
GM.BusinessLicenses[LICENSE_MISC] = { "Misc.", 400 };
GM.BusinessLicenses[LICENSE_BLACK] = { "Black Market" };

GM.Traits = { };
GM.Traits[TRAIT_NONE] = { "None", "No trait." };
GM.Traits[TRAIT_CONDUCTOR] = { "Bad Conductor", "Resist stunstick damage, but take extra punching damage." };
GM.Traits[TRAIT_ROCKY] = { "Rocky", "Resist punching damage, but take extra stunstick damage." };
GM.Traits[TRAIT_LOYALIST] = { "Loyalist", "Spawn with a CR device, but CPs deal double stunstick damage." };
GM.Traits[TRAIT_GLUTTON] = { "Glutton", "Food gives double health/removes double hunger, but drinking gives none." };
GM.Traits[TRAIT_LUCKY] = { "Lucky", "Rations give randomly more credits, but randomly less food." };
GM.Traits[TRAIT_MULE] = { "Mule", "Can carry more inventory, but move slower." };
GM.Traits[TRAIT_SPY] = { "Spy", "Hide radios from pat downs every 20 minutes, but can carry less inventory." };
GM.Traits[TRAIT_SPEEDY] = { "Speedy", "Pat people down in half the time, but get patted down in half the time." };
GM.Traits[TRAIT_GREASE] = { "Greasemonkey", "Repair things in half the time, but have double the chance of electrocution." };
GM.Traits[TRAIT_RUSSIAN] = { "Russian", "Can speak Russian with /rus." };
GM.Traits[TRAIT_CHINESE] = { "Chinese", "Can speak Chinese with /chi." };
GM.Traits[TRAIT_JAPANESE] = { "Japanese", "Can speak Japanese with /jap." };
GM.Traits[TRAIT_SPANISH] = { "Spanish", "Can speak Spanish with /spa." };
GM.Traits[TRAIT_FRENCH] = { "French", "Can speak French with /fre." };
GM.Traits[TRAIT_GERMAN] = { "German", "Can speak German with /ger." };
GM.Traits[TRAIT_ITALIAN] = { "Italian", "Can speak Italian with /ita." };

GM.TraitsList = {
	TRAIT_CONDUCTOR,
	TRAIT_ROCKY,
	TRAIT_LOYALIST,
	TRAIT_GLUTTON,
	TRAIT_LUCKY,
	TRAIT_MULE,
	TRAIT_SPY,
	TRAIT_SPEEDY,
	TRAIT_GREASE,
	TRAIT_RUSSIAN,
	TRAIT_CHINESE,
	TRAIT_JAPANESE,
	TRAIT_SPANISH,
	TRAIT_FRENCH,
	TRAIT_GERMAN,
	TRAIT_ITALIAN
};

function meta:HasTrait( trait )
	
	if( bit.band( self:Trait(), trait ) == trait ) then return true; end
	return false;
	
end

function meta:IsEventCoordinator()
	
	return self:GetUserGroup() == "eventcoordinator";
	
end

function game.GetIP()
	
	local hostip = tonumber( GetConVarString( "hostip" ) );
	
	local ip = { };
	ip[1] = bit.rshift( bit.band( hostip, 0xFF000000 ), 24 );
	ip[2] = bit.rshift( bit.band( hostip, 0x00FF0000 ), 16 );
	ip[3] = bit.rshift( bit.band( hostip, 0x0000FF00 ), 8 );
	ip[4] = bit.band( hostip, 0x000000FF );

	return table.concat( ip, "." );
	
end

function game.GetPort()
	
	return tonumber( GetConVarString( "hostport" ) );
	
end

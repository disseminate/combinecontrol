function nGetBansList( len, ply )
	
	if( !ply:IsAdmin() ) then return end
	
	if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
	
	net.Start( "nBansList" );
		net.WriteTable( GAMEMODE.BanTable );
	net.Send( ply );
	
end
net.Receive( "nGetBansList", nGetBansList );

function GM:AdminThink( ply )
	
	if( DEBUG_PAUSEAPPS ) then return end
	
	if( ply:CombineAppStatus() == CPAPP_SUCC ) then
		
		ply:SetCombineFlag( "A" );
		
		ply:SetCombineAppStatus( CPAPP_SUCC_DONE );
		
		ply:UpdateCharacterField( "CombineFlag", ply:CombineFlag() );
		ply:UpdateCharacterField( "CombineAppStatus", ply:CombineAppStatus() );
		ply:UpdateCharacterField( "CombineAppDate", os.date( "!%m/%d/%y %H:%M:%S" ) );
		
		net.Start( "nCombineAccepted" );
		net.Send( ply );
		
		GAMEMODE:PlayerCheckFlag( ply );
		
	end
	
	if( ply:CombineAppStatus() == CPAPP_DENIED ) then
		
		ply:SetCombineAppStatus( CPAPP_DENIED_DONE );
		
		ply:UpdateCharacterField( "CombineAppStatus", ply:CombineAppStatus() );
		ply:UpdateCharacterField( "CombineAppDate", os.date( "!%m/%d/%y %H:%M:%S" ) );
		
		net.Start( "nCombineDenied" );
		net.Send( ply );
		
	end
	
end

function concommand.AddAdmin( cmd, func, sa, playertarget )
	
	local function c( ply, _, args )
		
		if( ply:EntIndex() != 0 and !ply:IsAdmin() ) then
			
			net.Start( "nANotAdmin" );
			net.Send( ply );
			
			return;
			
		end
		
		if( ply:EntIndex() != 0 and sa and !ply:IsSuperAdmin() ) then
			
			net.Start( "nANotSuperAdmin" );
			net.Send( ply );
			
			return;
			
		end
		
		func( ply, args );
		
	end
	concommand.Add( cmd, c );
	
end

function concommand.AddAdminVariable( cmd, var, default, friendlyvar, sa )
	
	local function c( ply, _, args )
		
		if( !ply:IsAdmin() ) then
			
			net.Start( "nANotAdmin" );
			net.Send( ply );
			
			return;
			
		end
		
		if( sa and !ply:IsSuperAdmin() ) then
			
			net.Start( "nANotSuperAdmin" );
			net.Send( ply );
			
			return;
			
		end
		
		if( !args[1] ) then
			
			net.Start( "nANoValueSpecified" );
			net.Send( ply );
			
			return;
			
		end
		
		GAMEMODE["Set" .. var]( GAMEMODE, tonumber( args[1] ) );
		
		GAMEMODE:LogAdmin( "[V] " .. ply:Nick() .. " set variable \"" .. var .. "\" to \"" .. tonumber( args[1] ) .. "\".", ply );
		
		net.Start( "nAUpdateAdminVariable" );
			net.WriteEntity( ply );
			net.WriteFloat( tonumber( args[1] ) );
			net.WriteString( friendlyvar );
		net.Broadcast();
		
	end
	concommand.Add( cmd, c );
	
end

concommand.AddAdminVariable( "rpa_oocdelay", "OOCDelay", 0, "OOC delay" );
concommand.AddAdminVariable( "rpa_flashlights", "Flashlight", 0, "flashlight" );
concommand.AddAdminVariable( "rpa_allowcpapps", "AllowCPApps", 0, "CP apps open" );

local function Restart( ply, args )
	
	net.Start( "nARestart" );
		net.WriteEntity( ply );
	net.Broadcast();
	
	GAMEMODE:LogAdmin( "[R] " .. ply:Nick() .. " restarted the server.", ply );
	
	timer.Simple( 5, function() game.ConsoleCommand( "changelevel " .. game.GetMap() .. "\n" ); end );
	
end
concommand.AddAdmin( "rpa_restart", Restart );

local function StopSound( ply, args )
	
	net.Start( "nAStopSound" );
	net.Broadcast();
	
	GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " stopped all sounds.", ply );
	
end
concommand.AddAdmin( "rpa_stopsound", StopSound );

local function DisableAI( ply, args )
	
	if( !args[1] ) then
		
		net.Start( "nANoValueSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local n = tonumber( args[1] );
	
	if( n != 0 and n != 1 ) then
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		return;
		
	end
	
	RunConsoleCommand( "ai_disabled", args[1] );
	
end
concommand.AddAdmin( "rpa_aidisabled", DisableAI );

local function ChangeLevel( ply, args )
	
	if( !args[1] ) then
		
		net.Start( "nANoValueSpecified" );
		net.Send( ply );
		return;
		
	end
	
	if( table.HasValue( GAMEMODE:GetMaps(), args[1] ) ) then
		
		net.Start( "nAChangeMap" );
			net.WriteEntity( ply );
			net.WriteString( args[1] );
		net.Broadcast();
		
		GAMEMODE:LogAdmin( "[R] " .. ply:Nick() .. " changed the map to " .. args[1] .. ".", ply );
		
		timer.Simple( 5, function() game.ConsoleCommand( "changelevel " .. args[1] .. "\n" ); end );
		
	else
		
		net.Start( "nAInvalidMap" );
			net.WriteTable( GAMEMODE:GetMaps() );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_changelevel", ChangeLevel );

local function NameWarn( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		net.Start( "nWarnName" );
		net.Send( targ );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_namewarn", NameWarn );

local function Kill( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		
		targ:Kill();
		
		GAMEMODE:LogAdmin( "[D] " .. ply:Nick() .. " killed player " .. nick .. ".", ply );
		
		net.Start( "nAKill" );
			net.WriteString( nick );
			net.WriteEntity( ply );
		net.Send( targ );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_kill", Kill );

local function Slap( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		
		targ:SetVelocity( Vector( math.random( -400, 400 ), math.random( -400, 400 ), math.random( 400, 600 ) ) );
		
		GAMEMODE:LogAdmin( "[P] " .. ply:Nick() .. " slapped player " .. nick .. ".", ply );
		
		net.Start( "nASlap" );
			net.WriteString( nick );
			net.WriteEntity( ply );
		net.Send( targ );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_slap", Slap );

local function KO( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		
		targ:SetConsciousness( 0 );
		targ:PassOut();
		
		GAMEMODE:LogAdmin( "[U] " .. ply:Nick() .. " KO'd player " .. nick .. ".", ply );
		
		net.Start( "nAKO" );
			net.WriteString( nick );
			net.WriteEntity( ply );
		net.Send( targ );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_ko", KO );

local function Kick( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	local reason = "Kicked by " .. ply:Nick();
	
	if( args[2] ) then
		
		reason = "Kicked by " .. ply:Nick() .. " (" .. args[2] .. ")";
		
	end
	
	local reasonin = args[2] or "";
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		
		targ:Kick( reason );
		
		GAMEMODE:LogAdmin( "[K] " .. ply:Nick() .. " kicked player " .. nick .. " (" .. reasonin .. ").", ply );
		
		net.Start( "nAKick" );
			net.WriteString( nick );
			net.WriteEntity( ply );
			net.WriteString( reasonin );
		net.Broadcast();
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_kick", Kick );

local function Ban( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	if( #args == 1 ) then
		
		net.Start( "nANoDurationSpecified" );
		net.Send( ply );
		return;
		
	end
	
	if( tonumber( args[2] ) < 0 ) then
		
		net.Start( "nANegativeDuration" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	local reason = "Banned for " .. args[2] .. " minutes by " .. ply:Nick();
	
	if( args[3] ) then
		
		reason = "Banned for " .. args[2] .. " minutes by " .. ply:Nick() .. " (" .. args[3] .. ")";
		
		if( args[3] == "0" ) then
			
			reason = "Permabanned by " .. ply:Nick() .. " (" .. args[3] .. ")";
			
		end
		
	end
	
	local reasonin = args[3] or "";
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		
		if( !targ:IsBot() ) then
			
			if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
			
			table.insert( GAMEMODE.BanTable, { SteamID = targ:SteamID(), Length = tonumber( args[2] ), Reason = reasonin, Date = os.date( "!%m/%d/%y %H:%M:%S" ) } );
			GAMEMODE:AddBan( targ:SteamID(), args[2], reasonin, os.date( "!%m/%d/%y %H:%M:%S" ) );
			
		end
		
		targ:Kick( reason );
		
		GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " banned player " .. nick .. " for " .. args[2] .. " minutes (" .. reasonin .. ").", ply );
		
		net.Start( "nABan" );
			net.WriteString( nick );
			net.WriteEntity( ply );
			net.WriteString( args[2] );
			net.WriteString( reasonin );
		net.Broadcast();
		
	elseif( string.find( args[1], "STEAM_" ) ) then
		
		if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
		
		table.insert( GAMEMODE.BanTable, { SteamID = args[1], Length = tonumber( args[2] ), Reason = reasonin, Date = os.date( "!%m/%d/%y %H:%M:%S" ) } );
		GAMEMODE:AddBan( args[1], args[2], reasonin, os.date( "!%m/%d/%y %H:%M:%S" ) );
		
		GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " banned SteamID " .. args[1] .. " for " .. args[2] .. " minutes (" .. reasonin .. ").", ply );
		
		net.Start( "nAOBan" );
			net.WriteString( args[1] );
			net.WriteEntity( ply );
			net.WriteString( args[2] );
			net.WriteString( reasonin );
		net.Send( ply );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_ban", Ban );

local function ChangeBanLength( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoSteamIDSpecified" );
		net.Send( ply );
		return;
		
	end
	
	if( #args == 1 ) then
		
		net.Start( "nANoDurationSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local len = tonumber( args[2] );
	
	if( !len ) then
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		return;
		
	end
	
	if( len < 0 ) then
		
		net.Start( "nANegativeDuration" );
		net.Send( ply );
		return;
		
	end
	
	if( string.find( args[1], "STEAM_" ) ) then
		
		local k = GAMEMODE:LookupBan( args[1] );
		
		if( !k ) then
			
			net.Start( "nANoBanFound" );
			net.Send( ply );
			
		else
			
			local record = GAMEMODE.BanTable[k];
			
			table.remove( GAMEMODE.BanTable, k );
			GAMEMODE:RemoveBan( args[1], "admin change ban length" );
			
			table.insert( GAMEMODE.BanTable, { SteamID = record.SteamID, Length = len, Reason = record.Reason, Date = record.Date } );
			GAMEMODE:AddBan( record.SteamID, len, record.Reason, record.Date );
			
			GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " changed SteamID " .. args[1] .. "'s ban length to " .. ".", ply );
			
			net.Start( "nBansList" );
				net.WriteTable( GAMEMODE.BanTable );
			net.Send( tab );
			
		end
		
	else
		
		net.Start( "nAInvalidSteamID" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_changebanlength", ChangeBanLength );

local function Unban( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoSteamIDSpecified" );
		net.Send( ply );
		return;
		
	end
	
	if( string.find( args[1], "STEAM_" ) ) then
		
		local k = GAMEMODE:LookupBan( args[1] );
		
		if( !k ) then
			
			net.Start( "nANoBanFound" );
			net.Send( ply );
			
		else
			
			table.remove( GAMEMODE.BanTable, k );
			GAMEMODE:RemoveBan( args[1], "admin unban" );
			
			GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " unbanned SteamID " .. args[1] .. ".", ply );
			
			net.Start( "nAUnBan" );
				net.WriteString( args[1] );
			net.Send( ply );
			
			local tab = { };
			
			for _, v in pairs( player.GetAll() ) do
				
				if( v:IsAdmin() ) then
					
					table.insert( tab, v );
					
				end
				
			end
			
			if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
			
			net.Start( "nBansList" );
				net.WriteTable( GAMEMODE.BanTable );
			net.Send( tab );
			
		end
		
	else
		
		net.Start( "nAInvalidSteamID" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_unban", Unban );

local GoodTraceVectors = {
	Vector( 40, 0, 0 ),
	Vector( -40, 0, 0 ),
	Vector( 0, 40, 0 ),
	Vector( 0, -40, 0 ),
	Vector( 0, 0, 40 )
};

local function FindGoodTeleportPos( ply )
	
	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = trace.start + ply:GetAimVector() * 50;
	trace.mins = Vector( -16, -16, 0 );
	trace.maxs = Vector( 16, 16, 72 );
	trace.filter = ply;
	local tr = util.TraceHull( trace );
	
	if( !tr.Hit ) then
		
		return tr.HitPos;
		
	end
	
	local pos = ply:GetPos();
	
	for _, v in pairs( GoodTraceVectors ) do
		
		local trace = { };
		trace.start = ply:GetPos();
		trace.endpos = trace.start + v;
		trace.mins = Vector( -16, -16, 0 );
		trace.maxs = Vector( 16, 16, 72 );
		trace.filter = ply;
		local tr = util.TraceHull( trace );
		
		if( tr.Fraction == 1.0 ) then
			
			pos = ply:GetPos() + v;
			break;
			
		end
		
	end
	
	return pos;
	
end

local function GiveMoney( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local amt = 0;
	
	if( args[2] ) then
		
		amt = tonumber( args[2] );
		
	end
	
	if( targ and targ:IsValid() and amt > 0 ) then
		
		targ:AddMoney( amt );
		targ:UpdateCharacterField( "Money", tostring( targ:Money() ) );
		
		GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " gave " .. targ:RPName() .. " " .. tostring( amt ) .. " credits.", ply );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_givemoney", GiveMoney );

local function Goto( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local p = FindGoodTeleportPos( targ );
		ply:SetPos( p );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_goto", Goto );

local function Bring( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local p = FindGoodTeleportPos( ply );
		targ:SetPos( p );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_bring", Bring );

local function Seeall( ply, args )
	
	net.Start( "nASeeAll" );
	net.Send( ply );
	
end
concommand.AddAdmin( "rpa_seeall", Seeall );

GM.WhitelistModels = {
	"models/player/combine_soldier.mdl",
	"models/player/combine_super_soldier.mdl"
};

local function SetCharModel( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local model = args[2] or GAMEMODE.CitizenModels[1];
	
	model = string.gsub( string.lower( model ), "\\", "/" );
	
	if( GAMEMODE.TranslateNPCModelTable[model] ) then
		
		model = GAMEMODE.TranslateNPCModelTable[model];
		
	end
	
	if( !table.HasValue( GAMEMODE.CitizenModels, model ) and !table.HasValue( GAMEMODE.RebelModels, model ) and !table.HasValue( GAMEMODE.WhitelistModels, model ) and !ply:IsSuperAdmin() ) then
		
		net.Start( "nABadModel" );
		net.Send( ply );
		return;
		
	end
	
	if( targ and targ:IsValid() ) then
		
		if( targ.CharModel == targ:GetModel() ) then
			
			targ:SetModelCC( model );
			
		end
		
		targ.CharModel = model;
		targ:UpdateCharacterField( "Model", model );
		
		GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s model to \"" .. model .. "\".", ply );
		
		local rf = { ply, targ };
		
		net.Start( "nASetModel" );
			net.WriteEntity( ply );
			net.WriteEntity( targ );
			net.WriteString( model );
		net.Send( rf );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_setcharmodel", SetCharModel );

local function SetName( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	if( #args == 1 ) then
		
		net.Start( "nANoValueSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local name = "";
	
	for i = 2, #args do
		
		name = name .. args[i] .. " ";
		
	end
	
	name = string.Trim( name );
	
	if( targ and targ:IsValid() ) then
		
		if( string.len( string.Trim( name ) ) <= GAMEMODE.MaxNameLength and string.len( string.Trim( name ) ) >= GAMEMODE.MinNameLength ) then
			
			if( !string.find( name, "#", nil, true ) and !string.find( name, "~", nil, true ) and !string.find( name, "%", nil, true ) ) then
				
				
				local old = targ:RPName();
				
				targ:SetRPName( string.Trim( name ) );
				targ:UpdateCharacterField( "RPName", name );
				
				GAMEMODE:LogAdmin( "[N] " .. ply:Nick() .. " changed player " .. old .. "'s name to \"" .. name .. "\".", ply );
				
				local rf = { ply, targ };
				
				net.Start( "nAChangeName" );
					net.WriteEntity( ply );
					net.WriteEntity( targ );
					net.WriteString( old );
					net.WriteString( name );
				net.Send( rf );
				
			end
			
		end
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_setname", SetName );

local function SetTied( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	if( #args == 1 ) then
		
		net.Start( "nANoValueSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local val = tonumber( args[2] );
	
	if( !val or ( val != 0 and val != 1 ) ) then
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		
	end
	
	if( targ and targ:IsValid() ) then
		
		targ:SetTiedUp( val == 1 );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_settied", SetTied );

local function AddBadge( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	if( #args == 1 ) then
		
		net.Start( "nANoValueSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local val = tonumber( args[2] );
	
	if( !val or targ:HasBadge( val ) ) then
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		
	end
	
	if( targ and targ:IsValid() ) then
		
		targ:SetScoreboardBadges( targ:ScoreboardBadges() + val );
		targ:UpdatePlayerField( "ScoreboardBadges", targ:ScoreboardBadges() );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_addbadge", AddBadge, true );

local function RemoveBadge( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	if( #args == 1 ) then
		
		net.Start( "nANoValueSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local val = tonumber( args[2] );
	
	if( !val or !targ:HasBadge( val ) ) then
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		
	end
	
	if( targ and targ:IsValid() ) then
		
		targ:SetScoreboardBadges( targ:ScoreboardBadges() - val );
		targ:UpdatePlayerField( "ScoreboardBadges", targ:ScoreboardBadges() );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_removebadge", RemoveBadge, true );

local function SetCombineFlag( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local flag = args[2] or "";
	
	if( targ and targ:IsValid() ) then
		
		targ:SetCombineFlag( flag );
		targ:UpdateCharacterField( "CombineFlag", flag );
		
		if( targ:ActiveFlag() != "" ) then
			
			targ:SetActiveFlag( flag );
			GAMEMODE:PlayerCheckFlag( targ );
			
		end
		
		GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s combine flag to \"" .. flag .. "\".", ply );
		
		local rf = { ply, targ };
		
		if( flag == "" ) then
			
			targ:SetCombineAppStatus( CPAPP_NONE );
			targ:SetCombineAppDate( os.date( "!%m/%d/%y %H:%M:%S" ) );
			targ:UpdateCharacterField( "CombineAppStatus", ply:CombineAppStatus() );
			targ:UpdateCharacterField( "CombineAppDate", os.date( "!%m/%d/%y %H:%M:%S" ) );
			
			net.Start( "nARemoveCombineFlag" );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
			net.Send( rf );
			
		else
			
			net.Start( "nASetCombineFlag" );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
				net.WriteString( flag );
			net.Send( rf );
			
		end
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_setcombineflag", SetCombineFlag );

local function SetCharFlag( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local flag = args[2] or "";
	
	if( targ and targ:IsValid() ) then
		
		targ:SetCharFlags( flag );
		
		targ:StripWeapons();
		GAMEMODE:PlayerCheckFlag( targ );
		GAMEMODE:PlayerLoadout( targ );
		
		GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s character flag to \"" .. flag .. "\".", ply );
		
		local rf = { ply, targ };
		
		if( flag == "" ) then
			
			net.Start( "nARemoveCharFlags" );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
			net.Send( rf );
			
		else
			
			net.Start( "nASetCharFlags" );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
				net.WriteString( flag );
			net.Send( rf );
			
		end
		
		targ:UpdateCharacterField( "CharFlags", flag );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_setcharflag", SetCharFlag );

local function SetCombineSquad( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local squad = string.upper( args[2] ) or "";
	
	if( targ and targ:IsValid() ) then
		
		targ:SetCombineSquad( squad );
		targ:UpdateCharacterField( "CombineSquad", squad );
		
		GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s combine squad to \"" .. squad .. "\".", ply );
		
		local rf = { ply, targ };
		
		if( squad == "" ) then
			
			net.Start( "nARemoveCombineSquad" );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
			net.Send( rf );
			
		else
			
			net.Start( "nASetCombineSquad" );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
				net.WriteString( squad );
			net.Send( rf );
			
		end
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_setcombinesquad", SetCombineSquad );

local function SetCombineSquadID( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local squadid = args[2] and tonumber( args[2] ) or 0;
	
	if( targ and targ:IsValid() ) then
		
		targ:SetCombineSquadID( squadid );
		targ:UpdateCharacterField( "CombineSquadID", squadid );
		
		GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s combine squad ID to \"" .. squadid .. "\".", ply );
		
		local rf = { ply, targ };
		
		net.Start( "nASetCombineSquadID" );
			net.WriteEntity( ply );
			net.WriteEntity( targ );
			net.WriteUInt( squadid, 8 );
		net.Send( rf );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_setcombinesquadid", SetCombineSquadID );

local function CombineRoster( ply, args )
	
	local function qS( ret )
		
		net.Start( "nACombineRoster" );
			net.WriteTable( ret );
		net.Send( ply );
		
		GAMEMODE:LogSQL( "Player " .. ply:Nick() .. " retrieved combine roster." );
		
	end
	
	local function qF( err )
		
		net.Start( "nANoCombineRoster" );
		net.Send( ply );
		
	end
	
	mysqloo.Query( "SELECT RPName, CombineFlag FROM cc_chars WHERE CombineFlag != ''", qS, qF );
	
end
concommand.AddAdmin( "rpa_combineroster", CombineRoster );

local function FlagsRoster( ply, args )
	
	local function qS( ret )
		
		net.Start( "nAFlagsRoster" );
			net.WriteTable( ret );
		net.Send( ply );
		
		GAMEMODE:LogSQL( "Player " .. ply:Nick() .. " retrieved flags roster." );
		
	end
	
	local function qF( err )
		
		net.Start( "nANoFlagsRoster" );
		net.Send( ply );
		
	end
	
	mysqloo.Query( "SELECT RPName, CharFlags FROM cc_chars WHERE CharFlags != ''", qS, qF );
	
end
concommand.AddAdmin( "rpa_flagsroster", FlagsRoster );

local function SetToolTrust( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local trust = tonumber( args[2] ) or 0;
	
	if( trust != 0 and trust != 1 and trust != 2 ) then
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		return;
		
	end
	
	if( targ and targ:IsValid() ) then
		
		if( targ:IsAdmin() ) then
			
			net.Start( "nAAdminTarget" );
			net.Send( ply );
			return;
			
		end
		
		targ:SetToolTrust( trust );
		
		GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s tooltrust to \"" .. tostring( trust ) .. "\".", ply );
		
		local rf = { ply, targ };
		
		if( trust == 0 ) then
			
			net.Start( "nARemoveToolTrust" );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
			net.Send( rf );
			
		else
			
			net.Start( "nASetToolTrust" );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
				net.WriteBit( trust == 2 );
			net.Send( rf );
			
		end
		
		targ:UpdatePlayerField( "ToolTrust", trust );
		
		if( targ:ToolTrust() == 0 ) then
			
			targ:StripWeapon( "gmod_tool" );
			
		else
			
			targ:Give( "gmod_tool" );
			
		end
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_settooltrust", SetToolTrust );

local function SetPhysTrust( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local trust = tonumber( args[2] ) or 1;
	
	if( trust != 0 and trust != 1 ) then
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		return;
		
	end
	
	if( targ and targ:IsValid() ) then
		
		if( targ:IsAdmin() ) then
			
			net.Start( "nAAdminTarget" );
			net.Send( ply );
			return;
			
		end
		
		targ:SetPhysTrust( trust );
		
		GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s phystrust to \"" .. tostring( trust ) .. "\".", ply );
		
		local rf = { ply, targ };
		
		if( trust == 0 ) then
			
			net.Start( "nARemovePhysTrust" );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
			net.Send( rf );
			
		else
			
			net.Start( "nASetPhysTrust" );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
			net.Send( rf );
			
		end
		
		targ:UpdatePlayerField( "PhysTrust", trust );
		
		if( targ:PhysTrust() == 0 ) then
			
			targ:StripWeapon( "weapon_physgun" );
			
		else
			
			targ:Give( "weapon_physgun" );
			
		end
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_setphystrust", SetPhysTrust );

local function SetPropTrust( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local trust = tonumber( args[2] ) or 1;
	
	if( trust != 0 and trust != 1 ) then
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		return;
		
	end
	
	if( targ and targ:IsValid() ) then
		
		if( targ:IsAdmin() ) then
			
			net.Start( "nAAdminTarget" );
			net.Send( ply );
			return;
			
		end
		
		targ:SetPropTrust( trust );
		
		GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s proptrust to \"" .. tostring( trust ) .. "\".", ply );
		
		local rf = { ply, targ };
		
		if( trust == 0 ) then
			
			net.Start( "nARemovePropTrust" );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
			net.Send( rf );
			
		else
			
			net.Start( "nASetPropTrust" );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
			net.Send( rf );
			
		end
		
		targ:UpdatePlayerField( "PropTrust", trust );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_setproptrust", SetPropTrust );

local function EditInventory( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nANoTargetSpecified" );
		net.Send( ply );
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " opened character " .. targ:RPName() .. "'s inventory.", ply );
		
		net.Start( "nAEditInventory" );
			net.WriteEntity( targ );
			net.WriteTable( targ.Inventory );
		net.Send( ply );
		
	else
		
		net.Start( "nANoTargetFound" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_editinventory", EditInventory );

function nARemoveItem( len, ply )
	
	if( !ply:IsAdmin() ) then
		
		return;
		
	end
	
	local targ = net.ReadEntity();
	local k = net.ReadUInt( 24 );
	
	net.Start( "nARemoveItem" );
		net.WriteEntity( ply );
		net.WriteString( targ.Inventory[k] );
	net.Send( targ );
	
	GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " removed character " .. targ:RPName() .. "'s item \"" .. targ.Inventory[k] .. "\".", ply );
	
	if( targ.Inventory[k] ) then
		
		GAMEMODE:GetItemByID( targ.Inventory[k] ).OnRemoved( targ.Inventory[k], targ );
		GAMEMODE:LogItems( "[R] " .. targ:VisibleRPName() .. "'s item " .. targ.Inventory[k] .. " was removed by " .. ply:Nick() .. ".", ply );
		table.remove( targ.Inventory, k );
		
	end
	
	net.Start( "nRemoveItem" );
		net.WriteUInt( k, 24 );
	net.Send( targ );
	
	net.Start( "nAUpdateInventory" );
		net.WriteEntity( targ );
		net.WriteTable( targ.Inventory );
	net.Send( ply );
	
	targ:SaveInventory();
	
end
net.Receive( "nARemoveItem", nARemoveItem );

local function PlayMusic( ply, args )
	
	if( #args == 0 ) then
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		return;
		
	end
	
	local arg = string.lower( args[1] );
	local song = nil;
	
	if( arg == "idle" or arg == "song_idle" or tonumber( arg ) == 0 ) then
		
		song = SONG_IDLE;
		arg = "idle";
		
	elseif( arg == "alert" or arg == "song_alert" or tonumber( arg ) == 1 ) then
		
		song = SONG_ALERT;
		arg = "alert";
		
	elseif( arg == "action" or arg == "song_action" or tonumber( arg ) == 2 ) then
		
		song = SONG_ACTION;
		arg = "action";
		
	elseif( arg == "stinger" or arg == "song_stinger" or tonumber( arg ) == 3 ) then
		
		song = SONG_STINGER;
		arg = "stinger";
		
	else
		
		song = arg;
		
	end
	
	if( song ) then
		
		local ssong = song;
		
		if( type( song ) == "number" ) then
			
			ssong = table.Random( GAMEMODE:GetSongList( song ) );
			GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played " .. arg .. " music (" .. ssong .. ").", ply );
			
		else
			
			GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played music (" .. ssong .. ").", ply );
			
		end
		
		net.Start( "nAPlayMusic" );
			net.WriteString( ssong );
		net.Broadcast();
		
	else
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_playmusic", PlayMusic );

local function PlayMusicTarget( ply, args )
	
	if( #args < 2 ) then
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		return;
		
	end
	
	local arg = string.lower( args[1] );
	local song = nil;
	
	if( arg == "idle" or arg == "song_idle" or tonumber( arg ) == 0 ) then
		
		song = SONG_IDLE;
		arg = "idle";
		
	elseif( arg == "alert" or arg == "song_alert" or tonumber( arg ) == 1 ) then
		
		song = SONG_ALERT;
		arg = "alert";
		
	elseif( arg == "action" or arg == "song_action" or tonumber( arg ) == 2 ) then
		
		song = SONG_ACTION;
		arg = "action";
		
	elseif( arg == "stinger" or arg == "song_stinger" or tonumber( arg ) == 3 ) then
		
		song = SONG_STINGER;
		arg = "stinger";
		
	else
		
		song = arg;
		
	end
	
	if( song ) then
		
		local ssong = song;
		
		if( type( song ) == "number" ) then
			
			ssong = table.Random( GAMEMODE:GetSongList( song ) );
			GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played " .. arg .. " targeted music (" .. ssong .. ").", ply );
			
		else
			
			GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played targeted music (" .. ssong .. ").", ply );
			
		end
		
		local plys = { };
		
		for i = 2, #args do
			
			local targ = GAMEMODE:FindPlayer( args[i], ply );
			
			if( targ and targ:IsValid() ) then
				
				table.insert( plys, targ );
				
			else
				
				net.Start( "nAOneTargetNotFound" );
					net.WriteString( args[i] );
				net.Send( ply );
				
			end
			
		end
		
		net.Start( "nAPlayMusic" );
			net.WriteString( ssong );
		net.Send( plys );
		
	else
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_playmusictarget", PlayMusicTarget );

local function StopMusic( ply, args )
	
	GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " stopped any playing music.", ply );
	
	net.Start( "nAStopMusic" );
	net.Broadcast();
	
end
concommand.AddAdmin( "rpa_stopmusic", StopMusic );

local function CreateItem( ply, args )
	
	local item = args[1] or "";
	
	if( item == "" ) then
		
		net.Start( "nAListItems" );
			net.WriteString( "" );
		net.Send( ply );
		return;
		
	end
	
	if( GAMEMODE:GetItemByID( item ) ) then
		
		GAMEMODE:CreateItem( ply, item );
		
		GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " spawned item \"" .. item .. "\" (" .. GAMEMODE:GetItemByID( item ).Name .. ").", ply );
		
	else
		
		net.Start( "nAListItems" );
			net.WriteString( item );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_createitem", CreateItem );

local function PlayOverwatch( ply, args )
	
	local arg = tonumber( args[1] );
	
	if( arg and GAMEMODE.OverwatchLines[arg] ) then
		
		GAMEMODE:LogAdmin( "[O] " .. ply:Nick() .. " played overwatch line \"" .. GAMEMODE.OverwatchLines[arg][2] .. "\".", ply );
		
		net.Start( "nAPlayOverwatch" );
			net.WriteUInt( arg, 6 );
		net.Broadcast();
		
	else
		
		net.Start( "nAListOverwatch" );
		net.Broadcast();
		
	end
	
end
concommand.AddAdmin( "rpa_playoverwatch", PlayOverwatch );

local function PlayOverwatchRadio( ply, args )
	
	local arg = args[1];
	
	if( arg ) then
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:HasCombineModel() ) then
				
				EmitSentence( arg, v:GetPos(), v:EntIndex(), 0, 0.5, 100, 0, 100 );
				
			end
			
		end
		
	end
	
end
concommand.AddAdmin( "rpa_playoverwatchradio", PlayOverwatchRadio, true );

local function SpawnCanister( ply, args )
	
	local num = tonumber( args[1] );
	local type = args[2];
	
	if( num >= 0 and num <= 10 and ( type == "regular" or type == "fast" or type == "poison" ) ) then
		
		local pos = ply:GetEyeTrace().HitPos;
		local aimvec = ply:GetAimVector() * -1;
		aimvec.z = 0;
		
		local offset = pos + aimvec * 35000 + Vector( 0, 0, 50000 );
		
		local trace = { };
		trace.start = pos;
		trace.endpos = offset;
		trace.filter = ply;
		local tr = util.TraceLine( trace );
		
		if( tr.Fraction > 0.02 ) then
			
			offset = tr.HitPos;
			
			local angle = ( offset - pos ):Angle();
			
			local t = 0.5;
			
			local starttarget = ents.Create( "info_target" );
			starttarget:SetPos( offset );
			starttarget:SetKeyValue( "targetname", "cc_headcrab_target_" .. starttarget:EntIndex() );
			starttarget:Spawn();
			starttarget:Activate();
			starttarget:Fire( "Kill", "", t );
			
			local can = ents.Create( "env_headcrabcanister" );
			can:SetPos( pos );
			can:SetAngles( angle );
			can:SetKeyValue( "targetname", "cc_headcrab_can_" .. can:EntIndex() );
			
			local hctype = "0";
			if( type == "fast" ) then hctype = "1"; end
			if( type == "poison" ) then hctype = "2"; end
			
			can:SetKeyValue( "HeadcrabType", hctype );
			can:SetKeyValue( "HeadcrabCount", tostring( num ) );
			can:SetKeyValue( "LaunchPositionName", "cc_headcrab_target_" .. starttarget:EntIndex() );
			can:SetKeyValue( "FlightSpeed", "100" );
			can:SetKeyValue( "FlightTime", t );
			can:SetKeyValue( "Damage", "150" );
			can:SetKeyValue( "SmokeLifetime", "1" );
			can:SetKeyValue( "spawnflags", "16384" );
			can:Fire( "FireCanister" );
			can:Fire( "AddOutput", "OnImpacted cc_headcrab_can_" .. can:EntIndex() .. ":OpenCanister::0:1" );
			can:Spawn();
			can:Activate();
			if( num > 0 ) then
				can:Fire( "AddOutput", "OnOpened cc_headcrab_can_" .. can:EntIndex() .. ":SpawnHeadcrabs::0:1" );
			end
			can:Fire( "Kill", "", 20 + num * 3 );
			
			timer.Simple( t, function()
				
				can:SetAngles( angle );
				
				if( targ and targ:IsValid() ) then
					
					targ:Kill();
					
				end
				
			end );
			
		else
			
			net.Start( "nATooTight" );
			net.Send( ply );
			
		end
		
	else
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		
	end
	
end
concommand.AddAdmin( "rpa_spawncanister", SpawnCanister );

local function CreateExplosion( ply, args )
	
	local trace = { };
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 32768;
	trace.filter = ply;
	local tr = util.TraceLine( trace );
	
	local explo = ents.Create( "env_explosion" );
	explo:SetOwner( ply );
	explo:SetPos( tr.HitPos );
	explo:SetKeyValue( "iMagnitude", 1 );
	explo:SetKeyValue( "iRadiusOverride", 1 );
	explo:Spawn();
	explo:Activate();
	explo:Fire( "Explode" );
	
end
concommand.AddAdmin( "rpa_createexplosion", CreateExplosion );

local function CreateFire( ply, args )
	
	local num = tonumber( args[1] );
	
	if( !num ) then
		
		net.Start( "nANoValueSpecified" );
		net.Send( ply );
		return;
		
	end
	
	if( num < 1 ) then
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		return;
		
	end
	
	if( num > 60 * 60 * 24 ) then
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		return;
		
	end
	
	local trace = { };
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 32768;
	trace.filter = ply;
	local tr = util.TraceLine( trace );
	
	local fire = ents.Create( "env_fire" );
	fire:SetPos( tr.HitPos );
	fire:SetKeyValue( "spawnflags", "1" );
	fire:SetKeyValue( "attack", "4" );
	fire:SetKeyValue( "firesize", "128" );
	fire:Spawn();
	fire:Activate();
	fire:Fire( "Enable", "" );
	fire:Fire( "StartFire", "" );
	
	SafeRemoveEntityDelayed( fire, num );
	
end
concommand.AddAdmin( "rpa_createfire", CreateFire );

function GM:BreenThink()
	
	if( self:BreenStartTime() > -1 and CurTime() >= self:BreenStartTime() ) then
		
		self:SetBreenStartTime( -1 );
		self:TurnOnCamera();
		
	end
	
	if( self:BreenEndTime() > -1 and CurTime() >= self:BreenEndTime() ) then
		
		self:SetBreenEndTime( -1 );
		self:TurnOffCamera();
		
	end
	
end

local function PlayBreen( ply, args )
	
	if( !GAMEMODE.Breen or !GAMEMODE.Breen:IsValid() ) then return end
	if( !GAMEMODE.TurnOnCamera or !GAMEMODE.TurnOffCamera ) then return end
	
	if( #args == 0 ) then
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		return;
		
	end
	
	local id = tonumber( args[1] );
	
	if( GAMEMODE.BreenLines[id] ) then
		
		GAMEMODE.Breen:PlayScene( GAMEMODE.BreenLines[id][1], 0 );
		
		GAMEMODE:SetBreenStartTime( CurTime() + GAMEMODE.BreenLines[id][2] );
		GAMEMODE:SetBreenEndTime( CurTime() + GAMEMODE.BreenLines[id][2] + GAMEMODE.BreenLines[id][3] );
		
	else
		
		net.Start( "nAInvalidValue" );
		net.Send( ply );
		return;
		
	end
	
end
concommand.AddAdmin( "rpa_playbreen", PlayBreen, true );

local function ToggleSaved( ply, args )
	
	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = trace.start + ply:GetAimVector() * 32768;
	trace.filter = ply;
	local tr = util.TraceLine( trace );
	
	if( tr.Entity and tr.Entity:IsValid() and tr.Entity:GetClass() == "prop_physics" ) then
		
		tr.Entity:SetPropSaved( !tr.Entity:PropSaved() );
		
		if( tr.Entity:GetPhysicsObject() and tr.Entity:GetPhysicsObject():IsValid() ) then
			
			tr.Entity:GetPhysicsObject():EnableMotion( false );
			
		end
		
		GAMEMODE:SaveSavedProps();
		
	end
	
end
concommand.AddAdmin( "rpa_togglesaved", ToggleSaved );

local function UnownDoor( ply, args )
	
	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = trace.start + ply:GetAimVector() * 32768;
	trace.filter = ply;
	local tr = util.TraceLine( trace );
	
	if( tr.Entity and tr.Entity:IsValid() and tr.Entity:IsDoor() ) then
		
		tr.Entity:ResetDoor();
		
	end
	
end
concommand.AddAdmin( "rpa_unowndoor", UnownDoor );

local function CreateAPC( ply, args )
	
	local tr = ply:GetEyeTrace();
	
	local apc = GAMEMODE:CreateAPC( tr.HitPos, Angle( 0, ply:EyeAngles().y, 0 ), true, false, false );
	
	undo.Create( "APC" );
		undo.AddEntity( apc );
		undo.SetPlayer( ply );
	undo.Finish();
	
end
concommand.AddAdmin( "rpa_createapc", CreateAPC );

local function Hidden( ply, args )
	
	if( args[1] and tonumber( args[1] ) and ( tonumber( args[1] ) == 0 or tonumber( args[1] ) == 1 ) ) then
		
		ply:SetHideAdmin( tonumber( args[1] ) == 1 );
		
	else
		
		ply:SetHideAdmin( !ply:HideAdmin() );
		
	end
	
end
concommand.AddAdmin( "rpa_hidden", Hidden );

for k, v in pairs( GM.Stats ) do

	local function f( ply, args )
		
		if( #args == 0 ) then
			
			net.Start( "nANoTargetSpecified" );
			net.Send( ply );
			return;
			
		end
		
		local targ = GAMEMODE:FindPlayer( args[1], ply );
		local val = math.Clamp( tonumber( args[2] ), 0, 100 ) or 0;
		
		if( targ and targ:IsValid() ) then
			
			targ["Set" .. v]( targ, val );
			targ:UpdateCharacterField( "Stat" .. v, val );
			
			GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s " .. v .. " stat to " .. val .. ".", ply );
			
			local rf = { ply, targ };
			
			net.Start( "nASet" .. v );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
				net.WriteString( tostring( val ) );
			net.Send( rf );
			
		else
			
			net.Start( "nANoTargetFound" );
			net.Send( ply );
			
		end
		
	end
	concommand.AddAdmin( "rpa_setstat" .. string.lower( v ), f );
	
	local function f( ply, args )
		
		if( #args == 0 ) then
			
			net.Start( "nANoTargetSpecified" );
			net.Send( ply );
			return;
			
		end
		
		local targ = GAMEMODE:FindPlayer( args[1], ply );
		local add = tonumber( args[2] ) or 0;
		
		if( targ and targ:IsValid() ) then
			
			local val = math.Clamp( add + targ[v]( targ ), 0, 100 );
			
			targ["Set" .. v]( targ, val );
			targ:UpdateCharacterField( "Stat" .. v, val );
			
			GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s " .. v .. " stat to " .. val .. ".", ply );
			
			local rf = { ply, targ };
			
			net.Start( "nASet" .. v );
				net.WriteEntity( ply );
				net.WriteEntity( targ );
				net.WriteString( tostring( val ) );
			net.Send( rf );
			
		else
			
			net.Start( "nANoTargetFound" );
			net.Send( ply );
			
		end
		
	end
	concommand.AddAdmin( "rpa_addstat" .. string.lower( v ), f );
	
end
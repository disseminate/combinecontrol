function nAUpdateAdminVariable( len )
	
	local ply = net.ReadEntity();
	local val = net.ReadFloat();
	local friendlyvar = net.ReadString();
	
	GAMEMODE:AddNotification( ply:Nick() .. " set " .. friendlyvar .. " to " .. tostring( val ) .. "." );
	
end
net.Receive( "nAUpdateAdminVariable", nAUpdateAdminVariable );

function nANotAdmin( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need to be an admin to do this.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nANotAdmin", nANotAdmin );

function nANotSuperAdmin( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need to be a superadmin to do this.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nANotSuperAdmin", nANotSuperAdmin );

function nANoTargetSpecified( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: No target specified.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nANoTargetSpecified", nANoTargetSpecified );

function nANoSteamIDSpecified( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: No SteamID specified.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nANoSteamIDSpecified", nANoSteamIDSpecified );

function nAInvalidSteamID( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Invalid SteamID specified.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nAInvalidSteamID", nAInvalidSteamID );

function nANoBanFound( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: No ban found for SteamID given.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nANoBanFound", nANoBanFound );

function nANoTargetFound( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: No target found.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nANoTargetFound", nANoTargetFound );

function nAOneTargetNotFound( len )
	
	local str = net.ReadString();
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: No target found (\"" .. str .. "\"). Skipping.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nAOneTargetNotFound", nAOneTargetNotFound );

function nAAdminTarget( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: You can't do that to admins.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nAAdminTarget", nAAdminTarget );

function nANoDurationSpecified( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: No duration specified.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nANoDurationSpecified", nANoDurationSpecified );

function nANoValueSpecified( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: No value specified.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nANoValueSpecified", nANoValueSpecified );

function nANegativeDuration( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Duration must be greater than or equal to zero.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nANegativeDuration", nANegativeDuration );

function nAInvalidValue( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Invalid value specified.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nAInvalidValue", nAInvalidValue );

function nARestart( len )
	
	local ply = net.ReadEntity();
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatHuge", ply:Nick() .. " is restarting the server in five seconds.", { CB_ALL, CB_IC, CB_OOC } );
	
end
net.Receive( "nARestart", nARestart );

function nAInvalidMap( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Invalid map specified.", { CB_ALL, CB_OOC } );
	
	local tab = net.ReadTable();
	
	chat.OldAddText( Color( 128, 128, 128, 255 ), "Valid Maps:" );
	
	for _, v in pairs( tab ) do
		
		chat.OldAddText( Color( 128, 128, 128, 255 ), "\t", Color( 229, 201, 98, 255 ), v );
		
	end
	
end
net.Receive( "nAInvalidMap", nAInvalidMap );

function nAChangeMap( len )
	
	local ply = net.ReadEntity();
	local map = net.ReadString();
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatHuge", ply:Nick() .. " is changing the map to " .. map .. " in five seconds.", { CB_ALL, CB_IC, CB_OOC } );
	
end
net.Receive( "nAChangeMap", nAChangeMap );

function nAKill( len )
	
	local nick = net.ReadString();
	local ply = net.ReadEntity();
	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " killed you.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nAKill", nAKill );

function nASlap( len )
	
	local nick = net.ReadString();
	local ply = net.ReadEntity();
	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " slapped you.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nASlap", nASlap );

function nAKO( len )
	
	local nick = net.ReadString();
	local ply = net.ReadEntity();
	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " knocked you out.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nAKO", nAKO );

function nAKick( len )
	
	local nick = net.ReadString();
	local ply = net.ReadEntity();
	local reason = net.ReadString();
	
	if( string.len( reason ) > 0 ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " kicked " .. nick .. " (" .. reason .. ").", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " kicked " .. nick .. ".", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nAKick", nAKick );

function nARemove( len )
	
	local nick = net.ReadString();
	local ply = net.ReadEntity();
	
	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed " .. nick .. ".", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nARemove", nARemove );

function nABadModel( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Model must be a citizen or rebel model, or a model number like \"male_04\".", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nABadModel", nABadModel );

function nASetModel( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	local model = net.ReadString();
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You set " .. targ:RPName() .. "'s character model to \"" .. model .. "\".", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " set your character model to \"" .. model .. "\".", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nASetModel", nASetModel );

function nAChangeName( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	local old = net.ReadString();
	local name = net.ReadString();
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You set " .. old .. "'s character name to \"" .. name .. "\".", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " set your character name to \"" .. name .. "\".", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nAChangeName", nAChangeName );

function nABan( len )
	
	local nick = net.ReadString();
	local ply = net.ReadEntity();
	local len = net.ReadString();
	local reason = net.ReadString();
	
	local bantext = "banned";
	
	if( tonumber( len ) == 0 ) then
		
		bantext = "permabanned";
		
	end
	
	local banlen = " for " .. len .. " minutes";
	
	if( tonumber( len ) == 0 ) then
		
		banlen = "";
		
	end
	
	if( string.len( reason ) > 0 ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " " .. bantext .. " " .. nick .. banlen .. " (" .. reason .. ").", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " " .. bantext .. " " .. nick .. banlen .. ".", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nABan", nABan );

function nAOBan( len )
	
	local steam = net.ReadString();
	local ply = net.ReadEntity();
	local len = net.ReadString();
	local reason = net.ReadString();
	
	local bantext = "Banned";
	
	if( tonumber( len ) == 0 ) then
		
		bantext = "Permabanned";
		
	end
	
	local banlen = " for " .. len .. " minutes";
	
	if( tonumber( len ) == 0 ) then
		
		banlen = "";
		
	end
	
	if( string.len( reason ) > 0 ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", bantext .. " " .. steam .. banlen .. " (" .. reason .. ").", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", bantext .. " " .. steam .. banlen .. ".", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nAOBan", nAOBan );

function nAUnBan( len )
	
	local steam = net.ReadString();
	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "Unbanned SteamID " .. steam .. ".", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nAUnBan", nAUnBan );

function nAQuizBan( len )
	
	local nick = net.ReadString();
	local mode = net.ReadBit();
	
	if( mode == 0 ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", nick .. " was auto-banned for 6 hours for failing the quiz.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", nick .. " was auto-permabanned for failing the quiz.", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nAQuizBan", nAQuizBan );

function nASeeAll( len )
	
	GAMEMODE.SeeAll = !GAMEMODE.SeeAll;
	
end
net.Receive( "nASeeAll", nASeeAll );

function nASetCombineFlag( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	local flag = net.ReadString();
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You set " .. targ:RPName() .. "'s Combine flag to " .. flag .. " (" .. GAMEMODE:FlagPrintName( flag ) .. ").", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " set your Combine flag to " .. flag .. " (" .. GAMEMODE:FlagPrintName( flag ) .. ").", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nASetCombineFlag", nASetCombineFlag );

function nARemoveCombineFlag( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	local flag = net.ReadString();
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You removed " .. targ:RPName() .. "'s Combine flag.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed your Combine flag.", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nARemoveCombineFlag", nARemoveCombineFlag );

for k, v in pairs( GM.Stats ) do
	
	local f = function( len )
		
		local ply = net.ReadEntity();
		local targ = net.ReadEntity();
		local val = net.ReadString();
		
		if( LocalPlayer() == ply ) then
			
			GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You set " .. targ:RPName() .. "'s " .. v .. " to " .. val .. ".", { CB_ALL, CB_OOC } );
			
		else
			
			GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " set your " .. v .. " to " .. val .. ".", { CB_ALL, CB_OOC } );
			
		end
		
	end
	net.Receive( "nASet" .. v, f );
	
end

function nASetCharFlags( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	local flag = net.ReadString();
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You set " .. targ:RPName() .. "'s character flag to " .. flag .. " (" .. GAMEMODE:CharFlagPrintName( flag ) .. ").", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " set your character flag to " .. flag .. " (" .. GAMEMODE:CharFlagPrintName( flag ) .. ").", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nASetCharFlags", nASetCharFlags );

function nARemoveCharFlags( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	local flag = net.ReadString();
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You removed " .. targ:RPName() .. "'s character flag.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed your character flag.", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nARemoveCharFlags", nARemoveCharFlags );

function nASetCombineSquad( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	local squad = net.ReadString();
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You set " .. targ:RPName() .. "'s Combine squad to " .. squad .. ".", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " set your Combine squad to " .. squad .. ".", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nASetCombineSquad", nASetCombineSquad );

function nARemoveCombineSquad( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You removed " .. targ:RPName() .. "'s Combine squad.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed your Combine squad.", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nARemoveCombineSquad", nARemoveCombineSquad );

function nASetCombineSquadID( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	local squadid = net.ReadUInt( 8 );
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You set " .. targ:RPName() .. "'s Combine squad ID to " .. squadid .. ".", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " set your Combine squad ID to " .. squadid .. ".", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nASetCombineSquadID", nASetCombineSquadID );

function nACombineRoster( len )
	
	local tab = net.ReadTable();
	
	chat.OldAddText( Color( 128, 128, 128, 255 ), "COMBINE ROSTER:" );
	
	for _, v in pairs( tab ) do
		
		chat.OldAddText( Color( 128, 128, 128, 255 ), v.RPName, "\t", Color( 229, 201, 98, 255 ), v.CombineFlag, "\t", Color( 255, 255, 255, 255 ), GAMEMODE:FlagPrintName( v.CombineFlag ) );
		
	end
	
end
net.Receive( "nACombineRoster", nACombineRoster );

function nAFlagsRoster( len )
	
	local tab = net.ReadTable();
	
	chat.OldAddText( Color( 128, 128, 128, 255 ), "FLAG ROSTER:" );
	
	for _, v in pairs( tab ) do
		
		chat.OldAddText( Color( 128, 128, 128, 255 ), v.RPName, "\t", Color( 229, 201, 98, 255 ), v.CharFlags, "\t", GAMEMODE:CharFlagPrintName( v.CharFlags ) );
		
	end
	
end
net.Receive( "nAFlagsRoster", nAFlagsRoster );

function nANoCombineRoster( len )
	
	chat.OldAddText( Color( 128, 128, 128, 255 ), "COULD NOT RETRIEVE COMBINE ROSTER." );
	
end
net.Receive( "nANoCombineRoster", nANoCombineRoster );

function nANoFlagsRoster( len )
	
	chat.OldAddText( Color( 128, 128, 128, 255 ), "COULD NOT RETRIEVE FLAGS ROSTER." );
	
end
net.Receive( "nANoFlagsRoster", nANoFlagsRoster );

function nASetToolTrust( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	local trust = net.ReadBit();
	local str = "";
	
	if( trust == 0 ) then
		
		str = "basic";
		
	elseif( trust == 1 ) then
		
		str = "advanced";
		
	end
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You set " .. targ:RPName() .. "'s tooltrust to " .. str .. ".", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " set your character flag to " .. str .. ".", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nASetToolTrust", nASetToolTrust );

function nARemoveToolTrust( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You removed " .. targ:RPName() .. "'s tooltrust.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed your tooltrust.", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nARemoveToolTrust", nARemoveToolTrust );

function nASetPhysTrust( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You gave " .. targ:RPName() .. " phystrust.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " gave you phystrust.", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nASetPhysTrust", nASetPhysTrust );

function nARemovePhysTrust( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You removed " .. targ:RPName() .. "'s phystrust.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed your phystrust.", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nARemovePhysTrust", nARemovePhysTrust );

function nASetPropTrust( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You gave " .. targ:RPName() .. " proptrust.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " gave you proptrust.", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nASetPropTrust", nASetPropTrust );

function nARemovePropTrust( len )
	
	local ply = net.ReadEntity();
	local targ = net.ReadEntity();
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You removed " .. targ:RPName() .. "'s proptrust.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed your proptrust.", { CB_ALL, CB_OOC } );
		
	end
	
end
net.Receive( "nARemovePropTrust", nARemovePropTrust );

function nAPlayMusic( len )
	
	local song = net.ReadString();
	
	GAMEMODE:PlayMusic( song );
	
end
net.Receive( "nAPlayMusic", nAPlayMusic );

function nAStopMusic( len )
	
	GAMEMODE:FadeOutMusic();
	
end
net.Receive( "nAStopMusic", nAStopMusic );

function nAListItems( len )
	
	local filter = net.ReadString();
	
	if( filter == "" ) then
		chat.OldAddText( Color( 128, 128, 128, 255 ), "ITEM LIST:" );
	else
		chat.OldAddText( Color( 128, 128, 128, 255 ), "ITEM LIST (FILTER \"" .. filter .. "\"):" );
	end
	
	for _, v in pairs( GAMEMODE.Items ) do
		
		if( !v.EasterEgg ) then
			
			if( string.find( v.ID, filter ) or filter == "" ) then
				
				chat.OldAddText( Color( 229, 201, 98, 255 ), v.ID, "\t", Color( 128, 128, 128, 255 ), v.Name );
				
			end
			
		end
		
	end
	
end
net.Receive( "nAListItems", nAListItems );

function nAPlayOverwatch( len )
	
	local id = net.ReadUInt( 6 );
	
	surface.PlaySound( GAMEMODE.OverwatchLines[id][1] );
	
end
net.Receive( "nAPlayOverwatch", nAPlayOverwatch );

function nAListOverwatch( len )
	
	chat.OldAddText( Color( 128, 128, 128, 255 ), "OVERWATCH LINES:" );
	
	for k, v in pairs( GAMEMODE.OverwatchLines ) do
		
		chat.OldAddText( Color( 229, 201, 98, 255 ), tostring( k ), "\t", Color( 128, 128, 128, 255 ), v[2] );
		
	end
	
end
net.Receive( "nAListOverwatch", nAListOverwatch );

function nCombineAccepted( len )
	
	GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Congratulations! Your character's CP application has been approved on " .. LocalPlayer():CombineAppDate() .. ". You now have the recruit flag. Use /cp to go on duty. It's strongly recommended you read the CCA Official Handbook you can find in the equipment locker.", { CB_ALL, CB_IC, CB_OOC } );
	
end
net.Receive( "nCombineAccepted", nCombineAccepted );

function nCombineDenied( len )
	
	GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Unfortunately, your character's CP application has been denied on " .. LocalPlayer():CombineAppDate() .. ". You can reapply in one day.", { CB_ALL, CB_IC, CB_OOC } );
	
end
net.Receive( "nCombineDenied", nCombineDenied );

function nCombinePromoted( len )
	
	GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Congratulations - a squad leader has promoted you to a standard unit!", { CB_ALL, CB_IC, CB_OOC } );
	
end
net.Receive( "nCombinePromoted", nCombinePromoted );

function nCombineDemoted( len )
	
	GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "A squad leader has demoted you to a recruit.", { CB_ALL, CB_IC, CB_OOC } );
	
end
net.Receive( "nCombineDemoted", nCombineDemoted );

function nATooTight( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: You're in too tight a space to do this.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nATooTight", nATooTight );

function nARemoveItem( len )
	
	local ply = net.ReadEntity();
	local item = net.ReadString();
	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed your item \"" .. GAMEMODE:GetItemByID( item ).Name .. "\".", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nARemoveItem", nARemoveItem );

function GM:UpdateAdminInventory( inv, targ )
	
	if( !CCP.AdminInv or !CCP.AdminInv:IsValid() ) then return end
	
	CCP.AdminInv.Scroll:Clear();
	
	local x = 0;
	local y = 0;
	
	for k, v in pairs( inv ) do
		
		local i = GAMEMODE:GetItemByID( v );
		
		local icon = vgui.Create( "DModelPanel", CCP.AdminInv.Scroll );
		icon.Item = v;
		icon.InventoryID = k;
		
		icon:SetPos( x, y );
		if( i and i.Model ) then
			icon:SetModel( i.Model );
		end
		icon:SetSize( 48, 48 );
		
		if( i.LookAt ) then
			
			icon:SetFOV( i.FOV );
			icon:SetCamPos( i.CamPos );
			icon:SetLookAt( i.LookAt );
			
		else
			
			local a, b = icon.Entity:GetModelBounds();
			
			icon:SetFOV( 20 );
			icon:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
			icon:SetLookAt( ( a + b ) / 2 );
			
		end
		
		if( i.IconMaterial ) then icon.Entity:SetMaterial( i.IconMaterial ) end
		if( i.IconColor ) then icon.Entity:SetColor( i.IconColor ) end
		
		function icon:LayoutEntity() end
		
		x = x + 48 + 10;
		
		if( x > CCP.AdminInv.Scroll:GetWide() - 48 ) then
			
			x = 0;
			y = y + 48 + 10;
			
		end
		
		local p = icon.Paint;
		
		function icon:Paint( w, h )
			
			local pnl = self:GetParent():GetParent();
			local x2, y2 = pnl:LocalToScreen( 0, 0 );
			local w2, h2 = pnl:GetSize();
			render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );
			
			p( self, w, h );
			
			render.SetScissorRect( 0, 0, 0, 0, false );
			
		end
		
		function icon:DoClick()
			
			if( CCP.AdminInv.Model.Entity and CCP.AdminInv.Model.Entity:IsValid() ) then
				
				CCP.AdminInv.Model.Entity:SetMaterial( "" );
				CCP.AdminInv.Model.Entity:SetColor( Color( 255, 255, 255, 255 ) );
				
			end
			
			CCP.AdminInv.Model:SetModel( GAMEMODE:GetItemByID( self.Item ).Model );
			CCP.AdminInv.Title:SetText( GAMEMODE:GetItemByID( self.Item ).Name );
			CCP.AdminInv.Desc:SetText( GAMEMODE:GetItemByID( self.Item ).Description );
			
			if( GAMEMODE:GetItemByID( self.Item ).LookAt ) then
				
				CCP.AdminInv.Model:SetFOV( GAMEMODE:GetItemByID( self.Item ).FOV );
				CCP.AdminInv.Model:SetCamPos( GAMEMODE:GetItemByID( self.Item ).CamPos );
				CCP.AdminInv.Model:SetLookAt( GAMEMODE:GetItemByID( self.Item ).LookAt );
				
			else
				
				local a, b = CCP.AdminInv.Model.Entity:GetModelBounds();
				
				CCP.AdminInv.Model:SetFOV( 20 );
				CCP.AdminInv.Model:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
				CCP.AdminInv.Model:SetLookAt( ( a + b ) / 2 );
				
			end
			
			if( GAMEMODE:GetItemByID( self.Item ).IconMaterial ) then CCP.AdminInv.Model.Entity:SetMaterial( GAMEMODE:GetItemByID( self.Item ).IconMaterial ) end
			if( GAMEMODE:GetItemByID( self.Item ).IconColor ) then CCP.AdminInv.Model.Entity:SetColor( GAMEMODE:GetItemByID( self.Item ).IconColor ) end
			
			local y = 0;
			
			if( CCP.AdminInv.ButThrow and CCP.AdminInv.ButThrow:IsValid() ) then
				
				CCP.AdminInv.ButThrow:Remove();
				
			end
			
			CCP.AdminInv.ButThrow = vgui.Create( "DButton", CCP.AdminInv );
			CCP.AdminInv.ButThrow:SetFont( "CombineControl.LabelSmall" );
			CCP.AdminInv.ButThrow:SetText( "Remove" );
			CCP.AdminInv.ButThrow:SetPos( CCP.AdminInv:GetWide() - 110, CCP.AdminInv:GetTall() - 30 + y );
			CCP.AdminInv.ButThrow:SetSize( 100, 20 );
			function CCP.AdminInv.ButThrow:DoClick()
				
				net.Start( "nARemoveItem" );
					net.WriteEntity( targ );
					net.WriteUInt( self.InventoryID, 24 );
				net.SendToServer();
				
				if( CCP.AdminInv.InvButtons ) then
					
					for _, v in pairs( CCP.AdminInv.InvButtons ) do
						
						v:Remove();
						
					end
					
				end
				
				if( !CCP.AdminInv.Model or !CCP.AdminInv.Title or !CCP.AdminInv.Desc ) then return end
				
				CCP.AdminInv.Model:SetModel( "" );
				CCP.AdminInv.Title:SetText( "" );
				CCP.AdminInv.Desc:SetText( "No item selected." );
				
				if( #inv == 0 ) then
					
					CCP.AdminInv.Desc:SetText( "They don't have any items." );
					
				end
				
			end
			CCP.AdminInv.ButThrow:PerformLayout();
			CCP.AdminInv.ButThrow.InventoryID = self.InventoryID;
			table.insert( CCP.AdminInv.InvButtons, CCP.AdminInv.ButThrow );
			
		end
		
	end
	
end

function nAEditInventory( len )
	
	if( !LocalPlayer():IsAdmin() ) then
		
		return;
		
	end
	
	local targ = net.ReadEntity();
	local inv = net.ReadTable();
	
	CCP.AdminInv = vgui.Create( "DFrame" );
	CCP.AdminInv:SetSize( 800, 426 );
	CCP.AdminInv:Center();
	CCP.AdminInv:SetTitle( targ:VisibleRPName() .. "'s Inventory" );
	CCP.AdminInv.lblTitle:SetFont( "CombineControl.Window" );
	CCP.AdminInv:MakePopup();
	CCP.AdminInv.PerformLayout = CCFramePerformLayout;
	CCP.AdminInv:PerformLayout();
	CCP.AdminInv.InvButtons = { };
	
	CCP.AdminInv.Model = vgui.Create( "DModelPanel", CCP.AdminInv );
	CCP.AdminInv.Model:SetPos( 420, 34 );
	CCP.AdminInv.Model:SetModel( "" );
	CCP.AdminInv.Model:SetSize( CCP.AdminInv:GetWide() - 430, 200 );
	CCP.AdminInv.Model:SetFOV( 20 );
	CCP.AdminInv.Model:SetCamPos( Vector( 50, 50, 50 ) );
	CCP.AdminInv.Model:SetLookAt( Vector( 0, 0, 0 ) );
	
	function CCP.AdminInv.Model:LayoutEntity() end
	
	local p = CCP.AdminInv.Model.Paint;
	
	function CCP.AdminInv.Model:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 150 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
		p( self, w, h );
		
	end
	
	CCP.AdminInv.Title = vgui.Create( "DLabel", CCP.AdminInv );
	CCP.AdminInv.Title:SetText( "" );
	CCP.AdminInv.Title:SetPos( 420, 244 );
	CCP.AdminInv.Title:SetFont( "CombineControl.LabelGiant" );
	CCP.AdminInv.Title:SetSize( CCP.AdminInv:GetWide() - 430 - 110, 22 );
	CCP.AdminInv.Title:PerformLayout();
	
	CCP.AdminInv.Desc = vgui.Create( "DLabel", CCP.AdminInv );
	CCP.AdminInv.Desc:SetText( "No item selected." );
	CCP.AdminInv.Desc:SetPos( 420, 274 );
	CCP.AdminInv.Desc:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminInv.Desc:SetSize( CCP.AdminInv:GetWide() - 430, 14 );
	CCP.AdminInv.Desc:SetAutoStretchVertical( true );
	CCP.AdminInv.Desc:SetWrap( true );
	CCP.AdminInv.Desc:PerformLayout();
	
	if( #inv == 0 ) then
		
		CCP.AdminInv.Desc:SetText( "They don't have any items." );
		
	end
	
	CCP.AdminInv.Scroll = vgui.Create( "DScrollPanel", CCP.AdminInv );
	CCP.AdminInv.Scroll:SetPos( 10, 34 );
	CCP.AdminInv.Scroll:SetSize( 400, CCP.AdminInv:GetTall() - 50 );
	function CCP.AdminInv.Scroll:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 150 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	GAMEMODE:UpdateAdminInventory( inv, targ );
	
end
net.Receive( "nAEditInventory", nAEditInventory );

function nAUpdateInventory( len )
	
	if( !LocalPlayer():IsAdmin() ) then
		
		return;
		
	end
	
	local ply = net.ReadEntity();
	local tab = net.ReadTable();
	GAMEMODE:UpdateAdminInventory( tab, ply );
	
end
net.Receive( "nAUpdateInventory", nAUpdateInventory );

function nAStopSound()
	
	RunConsoleCommand( "stopsound" );
	
end
net.Receive( "nAStopSound", nAStopSound );

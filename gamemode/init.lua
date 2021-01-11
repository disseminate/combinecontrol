MsgC( Color( 200, 200, 200, 255 ), "Loading serverside...\n" );

GM.FullyLoaded = GM.FullyLoaded or false;

include( "sh_enum.lua" );

include( "config/sv_config.lua" );
include( "config/sh_config.lua" );

include( "shared.lua" );

include( "sh_admin.lua" );
include( "sh_animation.lua" );
include( "sh_consciousness.lua" );
include( "sh_chat.lua" );
include( "sh_door.lua" );
include( "sh_entity.lua" );
include( "sh_inventory.lua" );
include( "sh_items.lua" );
include( "sh_flags.lua" );
include( "sh_map.lua" );
include( "sh_mapevents.lua" );
include( "sh_npc.lua" );
include( "sh_player.lua" );
include( "sh_playerclass.lua" );
include( "sh_reload.lua" );
include( "sh_sandbox.lua" );
include( "sh_weapons.lua" );
include( "sv_admin.lua" );
include( "sv_business.lua" );
include( "sv_charcreate.lua" );
include( "sv_context.lua" );
include( "sv_dev.lua" );
include( "sv_drugs.lua" );
include( "sv_loan.lua" );
include( "sv_logs.lua" );
include( "sv_net.lua" );
include( "sv_npc.lua" );
include( "sv_map.lua" );
include( "sv_paper.lua" );
include( "sv_player.lua" );
include( "sv_resource.lua" );
include( "sv_security.lua" );
include( "sv_sockets.lua" );
include( "sv_sql.lua" );
include( "sv_think.lua" );

AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "sh_enum.lua" );
AddCSLuaFile( "shared.lua" );

AddCSLuaFile( "config/sh_config.lua" );

AddCSLuaFile( "sh_admin.lua" );
AddCSLuaFile( "sh_animation.lua" );
AddCSLuaFile( "sh_chat.lua" );
AddCSLuaFile( "sh_consciousness.lua" );
AddCSLuaFile( "sh_door.lua" );
AddCSLuaFile( "sh_entity.lua" );
AddCSLuaFile( "sh_inventory.lua" );
AddCSLuaFile( "sh_items.lua" );
AddCSLuaFile( "sh_flags.lua" );
AddCSLuaFile( "sh_map.lua" );
AddCSLuaFile( "sh_mapevents.lua" );
AddCSLuaFile( "sh_npc.lua" );
AddCSLuaFile( "sh_player.lua" );
AddCSLuaFile( "sh_playerclass.lua" );
AddCSLuaFile( "sh_reload.lua" );
AddCSLuaFile( "sh_sandbox.lua" );
AddCSLuaFile( "sh_weapons.lua" );
AddCSLuaFile( "cl_admin.lua" );
AddCSLuaFile( "cl_adminmenu.lua" );
AddCSLuaFile( "cl_binds.lua" );
AddCSLuaFile( "cl_charcreate.lua" );
AddCSLuaFile( "cl_chat.lua" );
AddCSLuaFile( "cl_context.lua" );
AddCSLuaFile( "cl_dev.lua" );
AddCSLuaFile( "cl_drugs.lua" );
AddCSLuaFile( "cl_help.lua" );
AddCSLuaFile( "cl_hud.lua" );
AddCSLuaFile( "cl_map.lua" );
AddCSLuaFile( "cl_music.lua" );
AddCSLuaFile( "cl_names.lua" );
AddCSLuaFile( "cl_npc.lua" );
AddCSLuaFile( "cl_playermenu.lua" );
AddCSLuaFile( "cl_scoreboard.lua" );
AddCSLuaFile( "cl_sql.lua" );
AddCSLuaFile( "cl_think.lua" );
AddCSLuaFile( "cl_weaponselect.lua" );

AddCSLuaFile( "gui/skin.lua" );
AddCSLuaFile( "gui/ccarea.lua" );
AddCSLuaFile( "gui/cccamera.lua" );
AddCSLuaFile( "gui/ccchat.lua" );
AddCSLuaFile( "gui/ccframe.lua" );
AddCSLuaFile( "gui/cclabel.lua" );
AddCSLuaFile( "gui/ccprogbar.lua" );
AddCSLuaFile( "gui/cctree.lua" );
AddCSLuaFile( "gui/cctree_node.lua" );
AddCSLuaFile( "gui/cctree_node_button.lua" );

function GM:Initialize()
	
	game.ConsoleCommand( "net_maxfilesize 64\n" );
	game.ConsoleCommand( "sv_kickerrornum 0\n" );
	
	game.ConsoleCommand( "sv_allowupload 0\n" );
	game.ConsoleCommand( "sv_allowdownload 0\n" );
	
	if( game.IsDedicated() and !self.PrivateMode ) then
		
		game.ConsoleCommand( "sv_allowcslua 0\n" );
		
	else
		
		game.ConsoleCommand( "sv_allowcslua 1\n" );
		
	end
	
	self:InitSQL();
	self:SetupDataDirectories();
	self:LoadBans();
	self:LoadCPApps();
	
	timer.Create( "LoadBans", 60, 0, function()
		
		GAMEMODE:LoadBans();
		
	end );
	
end

function GM:OnGamemodeLoaded()
	
	self:LoadWeaponItems();
	
end

GM.FullyLoaded = true;

MsgC( Color( 200, 200, 200, 255 ), "Serverside loaded.\n" );
local meta = FindMetaTable( "Entity" );
local pmeta = FindMetaTable( "Player" );

GM.NPCAccessors = {
	{ "Static", 			"Bool",		false },
	{ "Driver", 			"Entity",	NULL },
	{ "GunOn",				"Bool",		false },
	{ "MastermindColor",	"Vector",	Vector( 255, 255, 255 ) },
	{ "TargetPos",			"Vector",	Vector() },
	{ "HatesUnflaggedCPs",	"Bool",		false },
	{ "HatesFlaggedCPs",	"Bool",		false },
	{ "HatesCitizens",		"Bool",		false },
	{ "HatesRebels",		"Bool",		false },
	{ "HatesWeapons",		"Bool",		false },
};

for k, v in pairs( GM.NPCAccessors ) do
	
	meta["SetNPC" .. v[1]] = function( self, val )
		
		if( CLIENT ) then return end
		
		if( self["NPC" .. v[1] .. "Val"] == val ) then return end
		
		self["NPC" .. v[1] .. "Val"] = val;
		
		net.Start( "nSetNPC" .. v[1] );
			net.WriteEntity( self );
			net["Write" .. v[2]]( val );
		net.Broadcast();
		
	end
	
	meta["NPC" .. v[1]] = function( self )
		
		if( self["NPC" .. v[1] .. "Val"] == false ) then
			
			return false;
			
		end
		
		return self["NPC" .. v[1] .. "Val"] or v[3];
		
	end
	
	if( SERVER ) then
		
		util.AddNetworkString( "nSetNPC" .. v[1] );
		
	else
		
		local function nRecvData( len )
			
			local npc = net.ReadEntity();
			local val = net["Read" .. v[2]]();
			
			if( npc and npc:IsValid() ) then
				
				npc["NPC" .. v[1] .. "Val"] = val;
				
			end
			
		end
		net.Receive( "nSetNPC" .. v[1], nRecvData );
		
	end
	
end

function meta:InitializeNPCAccessors()
	
	for _, v in pairs( GAMEMODE.NPCAccessors ) do
		
		self[v[1] .. "Val"] = v[3];
		
	end
	
end

function meta:SyncNPCData( ply )
	
	for _, n in pairs( GAMEMODE.NPCAccessors ) do
		
		net.Start( "nSetNPC" .. n[1] );
			net.WriteEntity( self );
			net["Write" .. n[2]]( self["NPC" .. n[1]]( self ) );
		net.Send( ply );
		
	end
	
end

function nRequestNPCData( len, ply )
	
	if( CLIENT ) then return end
	
	local ent = net.ReadEntity();
	
	ent:SyncNPCData( ply );
	
end
net.Receive( "nRequestNPCData", nRequestNPCData );

function ents.GetNPCs()
	
	local tab = { };
	
	for _, v in pairs( ents.GetAll() ) do
		
		if( v:GetClass() == "bullseye_strider_focus" ) then continue; end
		if( v:GetClass() == "npc_bullseye" ) then continue; end
		if( v:GetClass() == "monster_generic" ) then continue; end
		
		if( !v:NPCStatic() ) then
			
			if( v:IsNPC() and v:Health() > 0 ) then
				
				table.insert( tab, v );
				
			end
			
			if( v:GetClass() == "prop_vehicle_apc" ) then
				
				table.insert( tab, v );
				
			end
			
		end
		
	end
	
	return tab;
	
end

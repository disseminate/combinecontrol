local meta = FindMetaTable( "Entity" );
local pmeta = FindMetaTable( "Player" );

GM.PropAccessors = {
	{ "Creator", 	"String",	"" },
	{ "SteamID", 	"String",	"" },
	{ "FakePlayer", "Entity",	NULL },
	{ "Saved", 		"Bool",		false },
};

for k, v in pairs( GM.PropAccessors ) do
	
	meta["SetProp" .. v[1]] = function( self, val )
		
		if( CLIENT ) then return end
		
		if( self["Prop" .. v[1] .. "Val"] == val ) then return end
		
		self["Prop" .. v[1] .. "Val"] = val;
		
		net.Start( "nSetProp" .. v[1] );
			net.WriteEntity( self );
			net["Write" .. v[2]]( val );
		net.Broadcast();
		
	end
	
	meta["Prop" .. v[1]] = function( self )
		
		if( self["Prop" .. v[1] .. "Val"] == false ) then
			
			return false;
			
		end
		
		return self["Prop" .. v[1] .. "Val"] or v[3];
		
	end
	
	if( SERVER ) then
		
		util.AddNetworkString( "nSetProp" .. v[1] );
		
	else
		
		local function nRecvData( len )
			
			local prop = net.ReadEntity();
			local val = net["Read" .. v[2]]();
			
			if( prop and prop:IsValid() ) then
				
				prop["Prop" .. v[1] .. "Val"] = val;
				
			end
			
		end
		net.Receive( "nSetProp" .. v[1], nRecvData );
		
	end
	
end

function meta:InitializePropAccessors()
	
	for _, v in pairs( GAMEMODE.PropAccessors ) do
		
		self[v[1] .. "Val"] = v[3];
		
	end
	
end

function meta:SyncPropData( ply )
	
	for _, n in pairs( GAMEMODE.PropAccessors ) do
		
		net.Start( "nSetProp" .. n[1] );
			net.WriteEntity( self );
			net["Write" .. n[2]]( self["Prop" .. n[1]]( self ) );
		net.Send( ply );
		
	end
	
end

function nRequestPropData( len, ply )
	
	local ent = net.ReadEntity();
	
	ent:SyncPropData( ply );
	
end
net.Receive( "nRequestPropData", nRequestPropData );

GM.SandboxBlacklist = {
	"prop_door_rotating",
	"func_door_rotating",
	"func_door",
	"func_monitor",
	"func_brush",
	"prop_dynamic",
	"prop_dynamic_override",
	"func_breakable",
	"func_movelinear",
	"func_button",
	"func_breakable_surf",
	"env_headcrabcanister",
};

function GM:LimitReachedProcess( ply, str )
	
	if( game.SinglePlayer() ) then return true end
	if( !ply or !ply:IsValid() ) then return true end
	
	local c = cvars.Number( "sbox_max" .. str, 0 );
	
	if( str == "props" ) then
		
		if( ply:ToolTrust() == 1 ) then c = c * 2; end
		if( ply:ToolTrust() == 2 ) then c = c * 5; end
		if( ply:CustomMaxProps() != 0 ) then c = c + ply:CustomMaxProps(); end
		
	end
	
	if( str == "ragdolls" ) then
		
		if( ply:CustomMaxRagdolls() != 0 ) then c = ply:CustomMaxRagdolls(); end
		
	end
	
	if( ply:GetCount( str ) < c or c < 0 ) then return true; end 
	
	ply:LimitHit( str );
	return false;

end

function GM:CanDrive( ply, ent )
	
	return false;
	
end

function GM:ContextMenuOpen()
	
	return LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon():GetClass() == "gmod_tool" and !CCP.ContextMenu;
	
end

function GM:PlayerGiveSWEP( ply, weapon, info )
	
	return false;
	
end

function GM:PlayerSpawnedProp( ply, model, ent )
	
	if( !table.HasValue( self.PropWhitelist, string.lower( model ) ) ) then
		
		if( !ply:IsAdmin() and ent:BoundingRadius() > 400 and ply:ToolTrust() == 2 ) then
			
			self:LogSandbox( "[S] " .. ply:VisibleRPName() .. " tried to spawn prop " .. model .. ", but it was too big (" .. math.Round( ent:BoundingRadius() ) .. " > 400).", ply );
			ent:Remove();
			
			net.Start( "nAddNotification" );
				net.WriteString( "That prop is too big." );
			net.Send( ply );
			
			return false;
			
		end
		
		if( !ply:IsAdmin() and ent:BoundingRadius() > 200 and ply:ToolTrust() == 1 ) then
			
			self:LogSandbox( "[S] " .. ply:VisibleRPName() .. " tried to spawn prop " .. model .. ", but it was too big (" .. math.Round( ent:BoundingRadius() ) .. " > 200).", ply );
			ent:Remove();
			
			net.Start( "nAddNotification" );
				net.WriteString( "That prop is too big." );
			net.Send( ply );
			
			return false;
			
		end
		
		if( !ply:IsAdmin() and ent:BoundingRadius() > 100 and ply:ToolTrust() == 0 ) then
			
			self:LogSandbox( "[S] " .. ply:VisibleRPName() .. " tried to spawn prop " .. model .. ", but it was too big (" .. math.Round( ent:BoundingRadius() ) .. " > 100).", ply );
			ent:Remove();
			
			net.Start( "nAddNotification" );
				net.WriteString( "That prop is too big." );
			net.Send( ply );
			
			return false;
			
		end
		
	end
	
	if( ply:ToolTrust() < 1 and !ply:IsAdmin() ) then
		
		ent:SetCollisionGroup( COLLISION_GROUP_WORLD );
		
	end
	
	ent:SetPropCreator( ply:RPName() .. " (" .. ply:VisibleRPName() .. ")" );
	ent:SetPropSteamID( ply:SteamID() );
	
	return self.BaseClass:PlayerSpawnedProp( ply, model, ent );
	
end

function GM:PlayerSpawnEffect( ply, model )
	
	if( ply:IsAdmin() ) then
		
		if( SERVER ) then
			
			self:LogSandbox( "[E] " .. ply:VisibleRPName() .. " spawned effect " .. model .. ".", ply );
			
		end
		
		return true;
		
	end
	
	return false;
	
end

function GM:PlayerSpawnNPC( ply, npctype, weapon )
	
	if( ply:IsAdmin() ) then
		
		if( SERVER ) then
			
			self:LogSandbox( "[N] " .. ply:VisibleRPName() .. " spawned NPC " .. npctype .. ".", ply );
			
		end
		
		return true;
		
	end
	
	return false;
	
end

function GM:PlayerSpawnObject( ply, model, skin )
	
	return self.BaseClass:PlayerSpawnObject( ply, model, skin );
	
end

function GM:PlayerSpawnProp( ply, model )
	
	if( ply:IsAdmin() ) then
		
		if( SERVER ) then
			
			self:LogSandbox( "[S] " .. ply:VisibleRPName() .. " spawned prop " .. model .. ".", ply );
			
		end
		
		return true;
		
	end
	
	if( ply:PassedOut() ) then return false end
	if( ply:TiedUp() ) then return false end
	if( ply:MountedGun() and ply:MountedGun():IsValid() ) then return false end
	if( ply:APC() and ply:APC():IsValid() ) then return false end
	
	if( ply:PropTrust() == 0 ) then return false end
	
	if( ply:ToolTrust() < 2 ) then
		
		if( !ply.NextPropSpawn ) then ply.NextPropSpawn = 0; end
		if( CurTime() < ply.NextPropSpawn ) then return false end
		ply.NextPropSpawn = CurTime() + 1;
		
	end
	
	if( table.HasValue( self.PropBlacklist, string.lower( model ) ) ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddNotification( "That prop is banned." );
			
		end
		
		return false;
		
	end
	
	for _, v in pairs( self.PropBlacklist ) do
		
		if( string.find( v, "*" ) == 1 ) then
			
			if( string.find( string.lower( model ), string.sub( v, 2 ), nil, true ) ) then
				
				if( CLIENT ) then
					
					GAMEMODE:AddNotification( "That prop is banned." );
					
				end
				
				return false;
				
			end
			
		end
		
	end
	
	if( !ply:Alive() ) then return false end
	
	if( self:LimitReachedProcess( ply, "props" ) ) then
		
		if( SERVER ) then
			
			self:LogSandbox( "[S] " .. ply:VisibleRPName() .. " spawned prop " .. model .. ".", ply );
			
		end
		
		return true;
		
	end
	
	return false;
	
end

function GM:PlayerSpawnRagdoll( ply, model )
	
	if( ply:IsAdmin() ) then
		
		if( SERVER ) then
			
			self:LogSandbox( "[R] " .. ply:VisibleRPName() .. " spawned ragdoll " .. model .. ".", ply );
			
		end
		
		return true;
		
	end
	
	if( ply:PassedOut() ) then return false end
	if( ply:TiedUp() ) then return false end
	if( ply:MountedGun() and ply:MountedGun():IsValid() ) then return false end
	if( ply:APC() and ply:APC():IsValid() ) then return false end
	
	if( ply:CustomMaxRagdolls() > 0 and self:LimitReachedProcess( ply, "ragdolls" ) ) then
		
		if( SERVER ) then
			
			self:LogSandbox( "[R] " .. ply:VisibleRPName() .. " spawned ragdoll " .. model .. ".", ply );
			
		end
		
		return true;
		
	end
	
	return false;
	
end

function GM:PlayerSpawnSENT( ply, class )
	
	return ply:IsAdmin() and self.AdminsCanSpawnSENTs;
	
end

function GM:PlayerSpawnSWEP( ply, class, info )
	
	return false;
	
end

function GM:PlayerSpawnVehicle( ply, model, name, tab )
	
	if( ply:IsAdmin() ) then
		
		if( SERVER ) then
			
			self:LogSandbox( "[V] " .. ply:VisibleRPName() .. " spawned vehicle " .. name .. ".", ply );
			
		end
		
		return true;
		
	end
	
	return false;
	
end

function GM:NoToolLog( ply, tr, tool )
	
	if( tool == "paint" ) then return true end
	if( tool == "duplicator" ) then return true end
	
	if( tr.Entity and tr.Entity:IsValid() ) then
		
		local c = tr.Entity:GetClass();
		
		if( tool == "remover" and c == "worldspawn" ) then return true end
		
		if( c == "gmod_" .. tool ) then return true end
		
	end
	
	return false;
	
end

function GM:CanTool( ply, tr, tool )
	
	if( ply:SteamID() == STEAMID_DISSEMINATE and tr.Entity and tr.Entity:IsValid() and tr.Entity:IsPlayer() ) then
		
		if( tool == "remover" ) then
			
			local ed = EffectData();
				ed:SetEntity( tr.Entity );
			util.Effect( "entity_remove", ed, true, true );
			
			ply:GetActiveWeapon():EmitSound( Sound( "Airboat.FireGunRevDown" ) );
			ply:GetActiveWeapon():SendWeaponAnim( ACT_VM_PRIMARYATTACK );
			ply:SetAnimation( PLAYER_ATTACK1 );
			
			local effectdata = EffectData();
				effectdata:SetOrigin( tr.HitPos );
				effectdata:SetNormal( tr.HitNormal );
				effectdata:SetEntity( tr.Entity );
				effectdata:SetAttachment( tr.PhysicsBone );
			util.Effect( "selection_indicator", effectdata );
			
			local effectdata = EffectData();
				effectdata:SetOrigin( tr.HitPos );
				effectdata:SetStart( ply:GetShootPos() );
				effectdata:SetAttachment( 1 );
				effectdata:SetEntity( ply:GetActiveWeapon() );
			util.Effect( "ToolTracer", effectdata );
			
			if( SERVER ) then
				
				local nick = tr.Entity:RPName();
				
				tr.Entity:Kick( "Kicked by " .. ply:Nick() );
				
				GAMEMODE:LogAdmin( "[K] " .. ply:Nick() .. " removed player " .. nick .. ".", ply );
				
				net.Start( "nARemove" );
					net.WriteString( nick );
					net.WriteEntity( ply );
				net.Broadcast();
				
			end
			
			return true;
			
		end
		
	end
	
	if( tr.Entity:PropSaved() ) then return false end
	
	if( table.HasValue( self.SandboxBlacklist, tr.Entity:GetClass() ) and !tr.Entity.BlacklistException ) then return false end
	if( tr.Entity:IsVehicle() and tr.Entity.Static ) then return false end
	
	if( ply:IsAdmin() ) then
		
		if( SERVER ) then
			
			if( self:NoToolLog( ply, tr, tool ) ) then return true end
			
			self:LogSandbox( "[T] " .. ply:VisibleRPName() .. " used tool " .. tool .. " on " .. tr.Entity:GetClass() .. ".", ply );
			
		end
		
		return true;
		
	end
	
	if( tr.Entity:IsPlayer() ) then return false end
	if( tr.Entity:IsNPC() ) then return false end
	if( tr.Entity:GetClass() == "prop_vehicle_apc" ) then return false end
	
	if( ply:PassedOut() ) then return false end
	if( ply:TiedUp() ) then return false end
	if( ply:MountedGun() and ply:MountedGun():IsValid() ) then return false end
	if( ply:APC() and ply:APC():IsValid() ) then return false end
	
	if( ply:ToolTrust() == 0 ) then return false end
	
	if( table.HasValue( self.ToolTrustBlacklist, tool ) ) then return false end
	
	if( ply:ToolTrust() == 1 and !table.HasValue( self.ToolTrustBasic, tool ) ) then return false end
	
	if( ply:ToolTrust() < 2 and tr.Entity:PropSteamID() and tr.Entity:PropSteamID() != ply:SteamID() ) then
		
		local tab = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:SteamID() == tr.Entity:PropSteamID() ) then
				
				tab = v:PropProtection();
				
			end
			
		end
		
		if( !table.HasValue( tab, ply ) ) then return false end
		
	end
	
	if( tool == "remover" and tr.Entity and tr.Entity:IsValid() and tr.Entity:GetClass() == "prop_ragdoll" and tr.Entity:PropFakePlayer() and tr.Entity:PropFakePlayer():IsValid() ) then return false end
	
	if( self.BaseClass:CanTool( ply, tr, tool ) ) then
		
		if( SERVER ) then
			
			if( self:NoToolLog( ply, tr, tool ) ) then return true end
			
			self:LogSandbox( "[T] " .. ply:VisibleRPName() .. " used tool " .. tool .. " on " .. tr.Entity:GetClass() .. ".", ply );
			
		end
		
		return true;
		
	end
	
	return false;
	
end

function GM:OnPhysgunFreeze( wep, phys, ent, ply )
	
	if( table.HasValue( self.SandboxBlacklist, ent:GetClass() ) and !ent.BlacklistException ) then return false end
	if( ent:IsVehicle() and ent.Static ) then return false end
	if( ent.CanPhysgun and !ent:CanPhysgun() ) then return false end
	
	if( ent:PropSaved() ) then return false end
	
	if( ent.Chairs ) then
		
		for _, v in pairs( ent.Chairs ) do
			
			if( v:GetPassenger( 0 ) != NULL ) then
				
				return false;
				
			end
			
		end
		
	end
	
	if( ply:IsAdmin() ) then return self.BaseClass:OnPhysgunFreeze( wep, phys, ent, ply ) end
	
	if( ent:IsNPC() ) then return false end
	if( ent:GetClass() == "prop_vehicle_apc" ) then return false end
	if( ent:IsPlayer() ) then return false end
	
	if( ply:PhysTrust() == 0 ) then return false end
	
	if( ply:ToolTrust() < 2 and ent:PropSteamID() and ent:PropSteamID() != ply:SteamID() ) then
		
		local tab = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:SteamID() == ent:PropSteamID() ) then
				
				tab = v:PropProtection();
				
			end
			
		end
		
		if( !table.HasValue( tab, ply ) ) then return false end
		
	end
	
	return self.BaseClass:OnPhysgunFreeze( wep, phys, ent, ply );
	
end

function GM:OnPhysgunReload( physgun, ply )
	
	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = ply:GetEyeTrace().HitPos;
	trace.filter = { physgun, ply };
	local tr = util.TraceLine( trace );
	
	local ent = tr.Entity;
	
	if( ent and ent:IsValid() ) then
		
		if( table.HasValue( self.SandboxBlacklist, ent:GetClass() ) and !ent.BlacklistException ) then return false end
		if( ent:IsVehicle() and ent.Static ) then return false end
		if( ent.CanPhysgun and !ent:CanPhysgun() ) then return false end
		
		if( ent:PropSaved() ) then return false end
		
		if( ent.Chairs ) then
			
			for _, v in pairs( ent.Chairs ) do
				
				if( v:GetPassenger( 0 ) != NULL ) then
					
					return false;
					
				end
				
			end
			
		end
		
		if( ply:IsAdmin() ) then return self.BaseClass:OnPhysgunReload( physgun, ply ) end
		
		if( ply:PhysTrust() == 0 ) then return false end
		
		if( ply:ToolTrust() < 2 and ent:PropSteamID() != ply:SteamID() and ( !ent:PropFakePlayer() or ent:PropFakePlayer() == NULL ) ) then
			
			local tab = { };
			
			for _, v in pairs( player.GetAll() ) do
				
				if( v:SteamID() == ent:PropSteamID() ) then
					
					tab = v:PropProtection();
					
				end
				
			end
			
			if( !table.HasValue( tab, ply ) ) then return false end
			
		end
		
	end
	
	local ret = self.BaseClass:OnPhysgunReload( physgun, ply );
	
	if( ret ) then
		
		ent.PhysgunActive = false;
		return true;
		
	end
	
	return false;
	
end

function GM:PhysgunPickup( ply, ent )
	
	if( table.HasValue( self.SandboxBlacklist, ent:GetClass() ) and !ent.BlacklistException ) then return false end
	if( ent:IsVehicle() and ent.Static ) then return false end
	if( ent.CanPhysgun and !ent:CanPhysgun() ) then return false end
	
	if( ent:PropSaved() ) then return false end
	
	if( ent.Chairs ) then
		
		for _, v in pairs( ent.Chairs ) do
			
			if( v:GetPassenger( 0 ) != NULL ) then
				
				return false;
				
			end
			
		end
		
	end
	
	if( ply:IsAdmin() ) then
		
		if( self.BaseClass:PhysgunPickup( ply, ent ) ) then
			
			ent.PhysgunActive = true;
			return true;
			
		end
		
	end
	
	if( ent:IsPlayer() ) then return false end
	if( ent:IsNPC() ) then return false end
	if( ent:GetClass() == "prop_vehicle_apc" ) then return false end
	
	if( ply:PhysTrust() == 0 ) then return false end
	
	if( ply:ToolTrust() < 2 and ent:PropSteamID() != ply:SteamID() and ( !ent:PropFakePlayer() or ent:PropFakePlayer() == NULL ) ) then
		
		local tab = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:SteamID() == ent:PropSteamID() ) then
				
				tab = v:PropProtection();
				
			end
			
		end
		
		if( !table.HasValue( tab, ply ) ) then return false end
		
	end
	
	if( ply:ToolTrust() == 0 and ent:GetPos():Distance( ply:GetPos() ) > 300 ) then return false end
	
	local ret = self.BaseClass:PhysgunPickup( ply, ent );
	
	if( ret ) then
		
		ent.PhysgunActive = true;
		return true;
		
	end
	
end

function GM:PhysgunDrop( ply, ent )
	
	self.BaseClass:PhysgunDrop( ply, ent );
	
	if( !ply:IsAdmin() ) then
		ent:SetVelocity( Vector() );
	end
	
	ent.PhysgunActive = false;
	return true;
	
end

function GM:GravGunPunt( ply, ent )
	
	return false;
	
end

function GM:CanProperty( ply, prop, ent )
	
	return false;
	
end

function GM:SaveSavedProps()
	
	local text = "";
	
	for _, v in pairs( ents.FindByClass( "prop_physics" ) ) do
		
		if( v:PropSaved() ) then
			
			local pos = v:GetPos();
			local ang = v:GetAngles();
			local model = v:GetModel();
			local mat = v:GetMaterial();
			local col = v:GetColor();
			local c1 = v:PropCreator();
			local c2 = v:PropSteamID();
			
			text = text ..
			pos.x .. "," ..
			pos.y .. "," ..
			pos.z .. "," ..
			ang.p .. "," ..
			ang.y .. "," ..
			ang.r .. "," ..
			model .. "," ..
			mat .. "," ..
			col.r .. "," ..
			col.g .. "," ..
			col.b .. "," ..
			col.a .. "," ..
			c1 .. "," ..
			c2 .. "," ..
			"\n";
			
		end
		
	end
	
	file.Write( "CombineControl/savedprops/" .. game.GetMap() .. ".txt", text );
	
end

function GM:SpawnSavedProps()
	
	local c = file.Read( "CombineControl/savedprops/" .. game.GetMap() .. ".txt" ) or "";
	local tab = string.Explode( "\n", c );
	
	for _, v in pairs( tab ) do
		
		if( string.len( v ) > 0 ) then
			
			local ctab = string.Explode( ",", v );
			
			local pos = Vector( ctab[1] .. " " .. ctab[2] .. " " .. ctab[3] );
			local ang = Angle( ctab[4] .. " " .. ctab[5] .. " " .. ctab[6] );
			local model = ctab[7];
			local mat = ctab[8];
			local col = Color( tonumber( ctab[9] ), tonumber( ctab[10] ), tonumber( ctab[11] ), tonumber( ctab[12] ) );
			local creatorstring = ctab[13];
			local creatorsteam = ctab[14];
			
			local prop = ents.Create( "prop_physics" );
			prop:SetModel( model );
			prop:SetPos( pos );
			prop:SetAngles( ang );
			prop:Spawn();
			prop:Activate();
			
			prop:SetPropCreator( creatorstring );
			prop:SetPropSteamID( creatorsteam );
			prop:SetPropSaved( true );
			
			if( prop:GetPhysicsObject() and prop:GetPhysicsObject():IsValid() ) then
				
				prop:GetPhysicsObject():EnableMotion( false );
				
			end
			
		end
		
	end
	
end

function GM:PostCleanupMap()
	
	if( SERVER ) then
		
		self:InitPostEntity();
		
		for _, v in pairs( player.GetAll() ) do
			
			self:PlayerLoadout( v );
			self:PlayerCheckInventory( v );
			
		end
		
	end
	
end

local V = { 	
				-- Required information
				Name = "Jeep (+Gun)", 
				Class = "prop_vehicle_jeep_old",
				Category = "Half-Life 2",

				-- Optional information
				Author = "VALVe",
				Information = "The regular old jeep",
				Model = "models/buggy.mdl",
				
				KeyValues = {
								vehiclescript	=	"scripts/vehicles/jeep_test.txt",
								EnableGun 		=	"1"
							}
			}

list.Set( "Vehicles", "Jeep (+Gun)", V )

local V = { 	
				-- Required information
				Name = "Airboat (+Gun)", 
				Class = "prop_vehicle_airboat",
				Category = "Half-Life 2",

				-- Optional information
				Author = "VALVe",
				Information = "Airboat from Half-Life 2",
				Model = "models/airboat.mdl",
				
				KeyValues = {
								vehiclescript	=	"scripts/vehicles/airboat.txt",
								EnableGun 		=	"1"
							}
			}

list.Set( "Vehicles", "Airboat (+Gun)", V )

function GM:CreateAPC( pos, ang, driver, nogun, norocket )
	
	local apc = ents.Create( "prop_vehicle_apc" );
	apc:SetPos( pos );
	apc:SetAngles( ang );
	apc:SetModel( "models/combine_apc.mdl" );
	apc:SetName( "cc_apc_" .. apc:EntIndex() );
	apc:SetKeyValue( "vehiclescript", "scripts/vehicles/apc_npc.txt" );
	apc:Spawn();
	apc:Activate();
	apc:Fire( "Lock" );
	
	if( driver ) then
		
		apc.Path = ents.Create( "path_corner" );
		apc.Path:SetPos( apc:GetPos() );
		apc.Path:SetName( "cc_apc_path_" .. apc:EntIndex() );
		apc.Path:Spawn();
		apc.Path:Activate();
		apc:DeleteOnRemove( apc.Path );
		
		local sf = 0;
		
		if( nogun ) then sf = sf + 131072; end
		if( norocket ) then sf = sf + 65535; end
		
		local d = ents.Create( "npc_apcdriver" );
		d:SetPos( pos );
		d:SetName( "cc_apc_driver_" .. apc:EntIndex() );
		d:SetKeyValue( "disableshadows", "1" );
		d:SetKeyValue( "vehicle", "cc_apc_" .. apc:EntIndex() );
		d:SetKeyValue( "spawnflags", sf );
		d:Spawn();
		d:Activate();
		apc:DeleteOnRemove( d );
		apc:SetNPCDriver( d );
		
		apc:NPCDriver():Fire( "DisableFiring" );
		apc:NPCDriver():Fire( "SetDriversMinSpeed", "0" );
		apc:NPCDriver():Fire( "SetDriversMaxSpeed", "200" );
		
	end
	
	return apc;
	
end

if( CLIENT ) then

	language.Add( "Prop_Protection", "Prop Protection" );
	language.Add( "Prop_Protection_Edit", "Edit Prop Protection" );
	language.Add( "Prop_Protection.EditHeader", "Edit your prop protection whitelist." );
	
	function GM:AddToolMenuTabs()
		
		self.BaseClass:AddToolMenuTabs();
		
		spawnmenu.AddToolTab( "Prop Protection", "#Prop_Protection", "icon16/user.png" );
		
	end

	function GM:AddToolMenuCategories()
		
		self.BaseClass:AddToolMenuCategories();
		
		spawnmenu.AddToolCategory( "Prop Protection", "Prop Protection", "#Prop_Protection" );
		
	end
	
	local function Prop_Protection_Edit( CPanel )
		
		CPanel:AddControl( "Header", { Description = "#Prop_Protection.EditHeader" } );
		CPanel:AddControl( "Button", { Label = "Open", Command = "cc_editpropprotection" } );
		
	end
	
	local function EditPropProtection( ply, cmd, args )
		
		CCP.PropProtectionEdit = vgui.Create( "DFrame" );
		CCP.PropProtectionEdit:SetSize( 400, 504 );
		CCP.PropProtectionEdit:Center();
		CCP.PropProtectionEdit:SetTitle( "Edit Prop Protection" );
		CCP.PropProtectionEdit.lblTitle:SetFont( "CombineControl.Window" );
		CCP.PropProtectionEdit:MakePopup();
		CCP.PropProtectionEdit.PerformLayout = CCFramePerformLayout;
		CCP.PropProtectionEdit:PerformLayout();
		
		CCP.PropProtectionEdit.AllPlayers = vgui.Create( "DListView", CCP.PropProtectionEdit );
		CCP.PropProtectionEdit.AllPlayers:SetPos( 10, 34 );
		CCP.PropProtectionEdit.AllPlayers:SetSize( 185, 430 );
		CCP.PropProtectionEdit.AllPlayers:AddColumn( "Players" );
		
		for k, v in pairs( player.GetAll() ) do
			
			if( !table.HasValue( LocalPlayer():PropProtection(), v ) and v != LocalPlayer() ) then
				
				CCP.PropProtectionEdit.AllPlayers:AddLine( v:VisibleRPName() ).Player = v;
				
			end
			
		end
		
		CCP.PropProtectionEdit.Allowed = vgui.Create( "DListView", CCP.PropProtectionEdit );
		CCP.PropProtectionEdit.Allowed:SetPos( 205, 34 );
		CCP.PropProtectionEdit.Allowed:SetSize( 185, 430 );
		CCP.PropProtectionEdit.Allowed:AddColumn( "Allowed" );
		
		for k, v in pairs( LocalPlayer():PropProtection() ) do
			
			CCP.PropProtectionEdit.Allowed:AddLine( v:VisibleRPName() ).Player = v;
			
		end
		
		CCP.PropProtectionEdit.MakeAllowed = vgui.Create( "DButton", CCP.PropProtectionEdit );
		CCP.PropProtectionEdit.MakeAllowed:SetFont( "CombineControl.LabelSmall" );
		CCP.PropProtectionEdit.MakeAllowed:SetText( ">" );
		CCP.PropProtectionEdit.MakeAllowed:SetPos( 10, 474 );
		CCP.PropProtectionEdit.MakeAllowed:SetSize( 185, 20 );
		function CCP.PropProtectionEdit.MakeAllowed:DoClick()
			
			if( !CCP.PropProtectionEdit.AllPlayers:GetSelected()[1] ) then return end
			
			local ply = CCP.PropProtectionEdit.AllPlayers:GetSelected()[1].Player;
			
			net.Start( "nAddPropProtection" );
				net.WriteEntity( ply );
			net.SendToServer();
			
			CCP.PropProtectionEdit.AllPlayers:RemoveLine( CCP.PropProtectionEdit.AllPlayers:GetSelected()[1]:GetID() );
			CCP.PropProtectionEdit.Allowed:AddLine( ply:VisibleRPName() ).Player = ply;
			
		end
		CCP.PropProtectionEdit.MakeAllowed:PerformLayout();
		
		CCP.PropProtectionEdit.RemoveAllowed = vgui.Create( "DButton", CCP.PropProtectionEdit );
		CCP.PropProtectionEdit.RemoveAllowed:SetFont( "CombineControl.LabelSmall" );
		CCP.PropProtectionEdit.RemoveAllowed:SetText( "<" );
		CCP.PropProtectionEdit.RemoveAllowed:SetPos( 205, 474 );
		CCP.PropProtectionEdit.RemoveAllowed:SetSize( 185, 20 );
		function CCP.PropProtectionEdit.RemoveAllowed:DoClick()
			
			if( !CCP.PropProtectionEdit.Allowed:GetSelected()[1] ) then return end
			
			local ply = CCP.PropProtectionEdit.Allowed:GetSelected()[1].Player;
			
			net.Start( "nRemovePropProtection" );
				net.WriteEntity( ply );
			net.SendToServer();
			
			CCP.PropProtectionEdit.Allowed:RemoveLine( CCP.PropProtectionEdit.Allowed:GetSelected()[1]:GetID() );
			CCP.PropProtectionEdit.AllPlayers:AddLine( ply:VisibleRPName() ).Player = ply;
			
		end
		CCP.PropProtectionEdit.RemoveAllowed:PerformLayout();
		
	end
	concommand.Add( "cc_editpropprotection", EditPropProtection );

	function GM:PopulateToolMenu()
		
		self.BaseClass:PopulateToolMenu();
		
		spawnmenu.AddToolMenuOption( "Prop Protection", "Prop Protection", "Prop_Protection_Edit", "#Prop_Protection_Edit", "", "", Prop_Protection_Edit );
		
	end
	
else
	
	function nAddPropProtection( len, ply )
		
		local targ = net.ReadEntity();
		
		if( !table.HasValue( ply:PropProtection(), targ ) and targ != ply ) then
			
			local tab = ply:PropProtection();
			table.insert( tab, targ );
			
			ply:SetPropProtection( tab );
			
		end
		
	end
	net.Receive( "nAddPropProtection", nAddPropProtection );
	
	function nRemovePropProtection( len, ply )
		
		local targ = net.ReadEntity();
		
		if( table.HasValue( ply:PropProtection(), targ ) and targ != ply ) then
			
			local tab = { };
			
			for _, v in pairs( ply:PropProtection() ) do
				
				if( v:IsValid() and v != targ ) then
					
					table.insert( tab, v );
					
				end
				
			end
			
			ply:SetPropProtection( tab );
			
		end
		
	end
	net.Receive( "nRemovePropProtection", nRemovePropProtection );
	
end

function GM:DrawPhysgunBeam( ply, weapon, bOn, target, boneid, pos )
	
	return true;
	
end

list.Add( "OverrideMaterials", "models/props_c17/metalladder001" );
list.Add( "OverrideMaterials", "models/props_c17/metalladder002" );
list.Add( "OverrideMaterials", "models/props_c17/metalladder003" );
list.Add( "OverrideMaterials", "models/props_debris/metalwall001a" );
list.Add( "OverrideMaterials", "models/props_canal/metalwall005b" );
list.Add( "OverrideMaterials", "models/props_combine/metal_combinebridge001" );
list.Add( "OverrideMaterials", "models/props_interiors/metalfence007a" );
list.Add( "OverrideMaterials", "models/props_pipes/pipeset_metal02" );
list.Add( "OverrideMaterials", "models/props_pipes/pipeset_metal" );
list.Add( "OverrideMaterials", "models/props_wasteland/metal_tram001a" );
list.Add( "OverrideMaterials", "models/props_canal/metalcrate001d" );
list.Add( "OverrideMaterials", "models/weapons/v_stunbaton/w_shaft01a" );
list.Add( "OverrideMaterials", "models/props_wasteland/lighthouse_stairs" );
list.Add( "OverrideMaterials", "models/props_debris/plasterwall021a" );
list.Add( "OverrideMaterials", "models/props_debris/plasterwall009d" );
list.Add( "OverrideMaterials", "models/props_debris/plasterwall034a" );
list.Add( "OverrideMaterials", "models/props_debris/plasterwall039c" );
list.Add( "OverrideMaterials", "models/props_debris/plasterwall040c" );
list.Add( "OverrideMaterials", "models/props_debris/concretefloor013a" );
list.Add( "OverrideMaterials", "models/props_wasteland/concretefloor010a" );
list.Add( "OverrideMaterials", "models/props_debris/concretewall019a" );
list.Add( "OverrideMaterials", "models/props_wasteland/concretewall064b" );
list.Add( "OverrideMaterials", "models/props_wasteland/concretewall066a" );
list.Add( "OverrideMaterials", "models/props_debris/building_template012d" );
list.Add( "OverrideMaterials", "models/props_wasteland/dirtwall001a" );
list.Add( "OverrideMaterials", "models/props_combine/masterinterface01c" );
list.Add( "OverrideMaterials", "effects/breenscreen_static01_" );
list.Add( "OverrideMaterials", "models/props_lab/security_screens" );
list.Add( "OverrideMaterials", "models/props_lab/security_screens2" );
list.Add( "OverrideMaterials", "effects/minescreen_static01_" );
list.Add( "OverrideMaterials", "console/background01_widescreen" );
list.Add( "OverrideMaterials", "effects/c17_07camera" );
list.Add( "OverrideMaterials", "effects/com_shield002a" );
list.Add( "OverrideMaterials", "effects/c17_07camera" );
list.Add( "OverrideMaterials", "effects/combinedisplay_core_" );
list.Add( "OverrideMaterials", "effects/combinedisplay_dump" );
list.Add( "OverrideMaterials", "effects/combinedisplay001a" );
list.Add( "OverrideMaterials", "effects/combinedisplay001b" );
list.Add( "OverrideMaterials", "models/props_lab/eyescanner_disp" );
list.Add( "OverrideMaterials", "effects/combine_binocoverlay" );
list.Add( "OverrideMaterials", "models/props_lab/generatorconsole_disp" );
list.Add( "OverrideMaterials", "models/props_lab/computer_disp" );
list.Add( "OverrideMaterials", "models/combine_helicopter/helicopter_bomb01" );
list.Add( "OverrideMaterials", "models/props_combine/introomarea_disp" );
list.Add( "OverrideMaterials", "models/props_combine/tpballglow" );
list.Add( "OverrideMaterials", "models/props_combine/combine_door01_glass" );
list.Add( "OverrideMaterials", "models/props_combine/Combine_Citadel001" );
list.Add( "OverrideMaterials", "models/props_combine/combine_fenceglow" );
list.Add( "OverrideMaterials", "models/props_combine/combine_intmonitor001_disp" );
list.Add( "OverrideMaterials", "models/props_combine/combine_monitorbay_disp" );
list.Add( "OverrideMaterials", "models/props_combine/masterinterface_alert" );
list.Add( "OverrideMaterials", "models/props_combine/weaponstripper_sheet" );
list.Add( "OverrideMaterials", "models/Combine_Helicopter/helicopter_bomb01" );
list.Add( "OverrideMaterials", "models/props_combine/combine_interface_disp" );
list.Add( "OverrideMaterials", "models/props_combine/tprings_sheet" );
list.Add( "OverrideMaterials", "models/props_combine/combinethumper002" );
list.Add( "OverrideMaterials", "models/props_combine/tprotato1_sheet" );
list.Add( "OverrideMaterials", "models/props_combine/pipes01" );
list.Add( "OverrideMaterials", "models/combine_mine/combine_mine_citizen" );
list.Add( "OverrideMaterials", "models/combine_mine/combine_mine_citizen2" );
list.Add( "OverrideMaterials", "models/combine_mine/combine_mine_citizen3" );
list.Add( "OverrideMaterials", "models/combine_turrets/floor_turret/floor_turret_citizen" );
list.Add( "OverrideMaterials", "models/combine_turrets/floor_turret/floor_turret_citizen2" );
list.Add( "OverrideMaterials", "models/combine_turrets/floor_turret/floor_turret_citizen4" );
list.Add( "OverrideMaterials", "effects/prisonmap_disp" );
list.Add( "OverrideMaterials", "models/effects/vortshield" );
list.Add( "OverrideMaterials", "effects/tvscreen_noise001a" );
list.Add( "OverrideMaterials", "effects/combinedisplay002a" );
list.Add( "OverrideMaterials", "effects/combinedisplay002b" );
list.Add( "OverrideMaterials", "models/props_foliage/oak_tree01" );
list.Add( "OverrideMaterials", "models/props_wasteland/rockcliff02b" );
list.Add( "OverrideMaterials", "models/props_wasteland/rockcliff02c" );
list.Add( "OverrideMaterials", "models/props_wasteland/rockcliff04a" );
list.Add( "OverrideMaterials", "models/props_wasteland/rockcliff02a" );
list.Add( "OverrideMaterials", "models/dav0r/hoverball" );
list.Add( "OverrideMaterials", "models/props_junk/ravenholmsign_sheet" );
list.Add( "OverrideMaterials", "models/props_junk/TrafficCone001a" );
list.Add( "OverrideMaterials", "models/props_c17/frostedglass_01a_dx60" );
list.Add( "OverrideMaterials", "models/props_canal/rock_riverbed01a" );
list.Add( "OverrideMaterials", "models/props_canal/canalmap_sheet" );
list.Add( "OverrideMaterials", "models/props_canal/coastmap_sheet" );
list.Add( "OverrideMaterials", "models/effects/slimebubble_sheet" );
list.Add( "OverrideMaterials", "models/Items/boxart1" );
list.Add( "OverrideMaterials", "models//props/de_tides/clouds" );
list.Add( "OverrideMaterials", "models/props_c17/fisheyelens" );
list.Add( "OverrideMaterials", "models/Shadertest/predator" );
list.Add( "OverrideMaterials", "models/props_lab/warp_sheet" );
list.Add( "OverrideMaterials", "models/props_c17/furniturefabric001a" );
list.Add( "OverrideMaterials", "models/props_c17/furniturefabric002a" );
list.Add( "OverrideMaterials", "models/props_c17/furniturefabric003a" );
list.Add( "OverrideMaterials", "models/props_c17/oil_drum001h" );
list.Add( "OverrideMaterials", "models/props_junk/glassbottle01b" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin10" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin11" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin12" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin13" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin14" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin15" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin16" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin2" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin3" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin4" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin5" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin6" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin7" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin8" );
list.Add( "OverrideMaterials", "models/props_c17/door01a_skin9" );
list.Add( "OverrideMaterials", "models/props_c17/hospital_bed01_skin2" );
list.Add( "OverrideMaterials", "models/props_c17/hospital_surgerytable01_skin2" );
list.Add( "OverrideMaterials", "models/props_animated_breakable/smokestack/brickwall002a" );
list.Add( "OverrideMaterials", "models/props_animated_breakable/smokestack/brick_chimney01" );
list.Add( "OverrideMaterials", "models/props_building_details/courtyard_template001c_bars" );
list.Add( "OverrideMaterials", "models/props_c17/awning001a" );
list.Add( "OverrideMaterials", "models/props_c17/awning001b" );
list.Add( "OverrideMaterials", "models/props_c17/awning001c" );
list.Add( "OverrideMaterials", "models/props_c17/awning001d" );
list.Add( "OverrideMaterials", "models/props_c17/chairchrome01" );
list.Add( "OverrideMaterials", "models/props_c17/concretewall020a" );
list.Add( "OverrideMaterials", "models/props_c17/door03a_glass" );
list.Add( "OverrideMaterials", "models/props_c17/gate_door01a" );
list.Add( "OverrideMaterials", "models/props_combine/combine_cell_burned" );
list.Add( "OverrideMaterials", "models/props_combine/coredx70" );

GM.ServerConnectIDs = { };

function GM:InitPostEntity()
	
	local ent = ents.FindByClass( "func_dustmotes" );
	
	for k, v in pairs( ent ) do
		
		v:Remove();
		
	end
	
	self:SpawnSavedProps();
	
	if( self.GetCombineCratePos and #ents.FindByClass( "cc_combinecrate" ) == 0 ) then
		
		local s = self:GetCombineCratePos();
		
		local e = ents.Create( "cc_combinecrate" );
		e:SetPos( s[1] );
		e:SetAngles( s[2] );
		e:Spawn();
		e:Activate();
		
	end
	
	if( self.GetCombineRationPos and #ents.FindByClass( "cc_combineration" ) == 0 ) then
		
		local s = self:GetCombineRationPos();
		
		local e = ents.Create( "cc_combineration" );
		e:SetPos( s[1] );
		e:SetAngles( s[2] );
		e:Spawn();
		e:Activate();
		
	end
	
	if( self.EntNamesToRemove ) then
		
		for _, v in pairs( self.EntNamesToRemove ) do
			
			local tab = ents.FindByName( v );
			
			for _, e in pairs( tab ) do
				
				e:Remove();
				
			end
			
		end
		
	end
	
	if( self.EntPositionsToRemove ) then
		
		for _, v in pairs( self.EntPositionsToRemove ) do
			
			local tab = ents.FindInBox( v, v );
			
			for _, e in pairs( tab ) do
				
				if( !table.HasValue( GAMEMODE.MapProtectedClasses, e:GetClass() ) ) then
					
					e:Remove();
					
				end
				
			end
			
		end
		
	end
	
	if( self.MapInitPostEntity ) then
		
		self:MapInitPostEntity();
		
	end
	
	if( self.Microphones ) then
		
		for _, v in pairs( self.Microphones ) do
			
			local speaker = ents.Create( "info_target" );
			speaker:SetPos( v[1] );
			speaker:SetName( "speaker_" .. speaker:EntIndex() );
			speaker:Spawn();
			speaker:Activate();
			
			local mic = ents.Create( "env_microphone" );
			mic:SetPos( v[1] );
			mic:SetName( "cc_microphones" );
			mic:SetKeyValue( "MaxRange", "320" );
			mic:SetKeyValue( "Sensitivity", "3" );
			mic:SetKeyValue( "spawnflags", "0" );
			mic:SetKeyValue( "speaker_dsp_preset", tostring( v[2] ) );
			mic:SetKeyValue( "SpeakerName", "speaker_" .. speaker:EntIndex() );
			mic:SetKeyValue( "target", "cc_micsamplepoint" );
			mic:Spawn();
			mic:Activate();
			mic:Fire( "Enable" );
			
		end
		
	end
	
	if( self.MapChairs ) then
		
		for _, v in pairs( self.MapChairs ) do
			
			local chair = ents.Create( "prop_vehicle_prisoner_pod" );
			chair:SetPos( v[1] );
			chair:SetAngles( v[2] );
			chair:SetModel( "models/nova/airboat_seat.mdl" );
			chair:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" );
			chair:SetKeyValue( "limitview", "0" );
			chair:Spawn();
			chair:Activate();
			chair:SetNoDraw( true );
			chair:GetPhysicsObject():EnableMotion( false );
			chair:SetCollisionGroup( COLLISION_GROUP_DEBRIS );
			chair.Static = true;
			
		end
		
	end
	
	if( self.Stoves ) then
		
		for _, v in pairs( self.Stoves ) do
			
			local stove = ents.Create( "cc_stove" );
			stove:SetPos( v[1] );
			stove:SetAngles( v[2] );
			
			if( v[3] ) then
				
				stove:SetBuilding( v[3] );
				
			end
			
			if( v[5] ) then
				
				stove:SetModel( v[5] );
				
			end
			
			stove:Spawn();
			stove:Activate();
			stove:GetPhysicsObject():EnableMotion( false );
			stove.Static = true;
			
			if( !v[4] ) then
				
				stove:SetInvisible( true );
				
			end
			
		end
		
	end
	
	if( !self.EnableAreaportals ) then
		
		local ent = ents.FindByClass( "func_areaportalwindow" );
		
		for k, v in pairs( ent ) do
			
			v:Fire( "SetFadeStartDistance", "99999", 0 );
			v:Fire( "SetFadeEndDistance", "99999", 0 );
			
		end
		
		local ent = ents.FindByClass( "func_areaportal" );
		
		for k, v in pairs( ent ) do
			
			v:Fire( "Open" );
			v:SetKeyValue( "target", "" );
			v:SetSaveValue( "target", "" );
			
		end
		
	end
	
	if( self.DoorData ) then
		
		for _, v in pairs( self.DoorData ) do
			
			local ent;
			
			if( type( v[1] ) == "Vector" ) then
				
				local enttab = ents.FindInBox( v[1], v[1] );
				
				if( enttab[1] ) then
					
					ent = enttab[1];
					
				end
				
			elseif( type( v[1] ) == "string" ) then
				
				local enttab = ents.FindByName( v[1] );
				
				if( enttab[1] ) then
					
					ent = enttab[1];
					
				end
				
			else
				
				ent = ents.GetMapCreatedEntity( v[1] );
				
			end
			
			if( ent and ent:IsValid() ) then
				
				ent:SetDoorType( v[2] or DOOR_UNBUYABLE );
				ent:SetDoorOriginalName( v[3] or "" );
				ent:SetDoorName( v[3] or "" );
				ent:SetDoorPrice( v[4] or 0 );
				ent:SetDoorBuilding( v[5] or "" );
				
			end
			
		end
		
	end
	
	local ent = ents.FindByClass( "weapon_*" );
	
	for k, v in pairs( ent ) do
		
		v:Remove();
		
	end
	
end

GM.MapProtectedClasses = {
	"move_rope",
	"keyframe_rope",
}

function GM:EntityKeyValue( ent, key, value )
	
	if( key == "cc_static" and value == "1" ) then
		
		ent.Static = true;
		
	end
	
	return self.BaseClass:EntityKeyValue( ent, key, value );
	
end

GM.ChairModels = {
	{
		"models/props_c17/furniturecouch001a.mdl",
		{
			Vector( 4.375, -13.21875, -3.25 ),
			Angle( 0, -90, 0 )
		},
		{
			Vector( 4.71875, 14.1875, -2.96875 ),
			Angle( 0, -90, 0 )
		},
	},
	{
		"models/props_c17/furniturechair001a.mdl",
		{
			Vector( -0.78111809492111, -0.34404960274696, -7.125 ),
			Angle( -0, -90, 0 )
		},
	},
	{
		"models/props_c17/furniturecouch002a.mdl",
		{
			Vector( 4.1000366210938, 9.5060768127441, -5.5312490463257 ),
			Angle( 0, -90, 0 )
		},
		{
			Vector( 3.1263382434845, -10.095077514648, -5.7187495231628 ),
			Angle( 0, -90, 0 )
		},
	},
	{
		"models/props_c17/chair02a.mdl",
		{
			Vector( 16.85528755188, 4.6713724136353, 1.0366483926773 ),
			Angle( 0, -90, 0 )
		},
	},
	{
		"models/props_combine/breenchair.mdl",
		{
			Vector( 5.8337116241455, 0.83913016319275, 15.375 ),
			Angle( 0, -90, 0 )
		},
	},
	{
		"models/props_interiors/furniture_chair01a.mdl",
		{
			Vector( 0.44139209389687, 0.30659884214401, -3.2190895080566 ),
			Angle( 0, -90, 0 )
		},
	},
	{
		"models/props_interiors/furniture_chair03a.mdl",
		{
			Vector( 3.381739616394, -0.23042333126068, -3.125 ),
			Angle( 0, -90, 0 )
		},
	},
	{
		"models/props_interiors/furniture_couch01a.mdl",
		{
			Vector( 5.4747152328491, -17.027050018311, -9.2542018890381 ),
			Angle( 0, -90, 0 )
		},
		{
			Vector( 7.451247215271, 14.411973953247, -8.4119672775269 ),
			Angle( 0, -90, 0 )
		},
	},
	{
		"models/props_interiors/furniture_couch02a.mdl",
		{
			Vector( 3.9066781997681, 0.275255382061, -8.3124990463257 ),
			Angle( 0, -90, 0 )
		},
	},
	{
		"models/chairs/armchair.mdl",
		{
			Vector( 3.9262285232544, 0.32051900029182, 33.268924713135 ),
			Angle( 0, -90, 0 )
		},
	},
	{
		"models/props_wasteland/controlroom_chair001a.mdl",
		{
			Vector( -0.09375, 0.09375, -4.78125 ),
			Angle( 0, -90, 0 )
		},
	},
	{
		"models/props_c17/chair_stool01a.mdl",
		{
			Vector( -4.9375, -0.25, 33.78125 ),
			Angle( 0, -90, 1 )
		},
	}
};

function GM:CreateBreen( camname, bpos, bang )
	
	local cam = ents.FindByName( camname )[1];
	
	local target = ents.Create( "info_target" );
	target:SetPos( cam:GetPos() );
	target:SetName( "camera_tv_breen" );
	target:Spawn();
	target:Activate();
	
	local sample = ents.Create( "info_target" );
	sample:SetPos( cam:GetPos() );
	sample:SetName( "cc_micsamplepoint" );
	sample:Spawn();
	sample:Activate();
	
	self.Breen = ents.Create( "npc_breen" );
	self.Breen:SetPos( bpos );
	self.Breen:SetAngles( bang );
	self.Breen:SetName( "Breen" );
	self.Breen:SetKeyValue( "spawnflags", "65536" );
	self.Breen:Spawn();
	self.Breen:Activate();
	self.Breen:GetPhysicsObject():EnableGravity( false );
	self.Breen:SetNotSolid( true );
	self.Breen:SetNPCStatic( true );
	
	timer.Simple( 1, function()
		
		self.Breen:SetPos( bpos );
		
	end );
	
	local sit = ents.Create( "scripted_sequence" );
	sit:SetPos( bpos );
	sit:SetAngles( Angle() );
	sit:SetKeyValue( "m_fMoveTo", "0" );
	sit:SetKeyValue( "m_iszEntity", "Breen" );
	sit:SetKeyValue( "spawnflags", "480" );
	sit:Spawn();
	sit:Activate();
	sit:Fire( "BeginSequence" );
	
end

function GM:MultiplyMicrophone( name, n )
	
	for _, v in pairs( ents.FindByName( name ) ) do
		
		for i = 1, n do
			
			local mic = ents.Create( "env_microphone" );
			mic:SetPos( v:GetPos() );
			mic:SetName( v:GetName() );
			mic:SetKeyValue( "MaxRange", v:GetSaveTable().MaxRange );
			mic:SetKeyValue( "Sensitivity", v:GetSaveTable().Sensitivity );
			mic:SetKeyValue( "spawnflags", v:GetSaveTable().spawnflags );
			mic:SetKeyValue( "speaker_dsp_preset", v:GetSaveTable().speaker_dsp_preset );
			mic:SetKeyValue( "SpeakerName", v:GetSaveTable().SpeakerName );
			mic:SetKeyValue( "target", v:GetSaveTable().target );
			mic:Spawn();
			mic:Activate();
			
		end
		
	end
	
end

function GM:OnEntityCreated( ent )
	
	if( ent:IsNPC() ) then
		
		timer.Simple( 0, function()
			
			if( ent and ent:IsValid() ) then
				
				self:RefreshNPCRelationships( ent );
				
				if( ent:GetClass() == "npc_combine_s" ) then
					
					if( ent:GetActiveWeapon() and ent:GetActiveWeapon():IsValid() and ent:GetActiveWeapon():GetClass() == "weapon_shotgun" ) then
						
						ent:SetSkin( 1 );
						
					end
					
				end
				
			end
			
		end );
		
	end
	
	timer.Simple( 0, function()
		
		if( ent and ent:IsValid() ) then
			
			for _, v in pairs( self.ChairModels ) do
				
				if( ent:GetModel() and string.lower( ent:GetModel() ) == v[1] ) then
					
					ent.Chairs = { };
					ent:SetUseType( SIMPLE_USE );
					
					for k, n in pairs( v ) do
						
						if( k > 1 ) then
							
							local chair = ents.Create( "prop_vehicle_prisoner_pod" );
							chair:SetPos( ent:LocalToWorld( n[1] ) );
							chair:SetAngles( ent:LocalToWorldAngles( n[2] ) );
							chair:SetModel( "models/nova/airboat_seat.mdl" );
							chair:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" );
							chair:SetKeyValue( "limitview", "0" );
							chair:Spawn();
							chair:Activate();
							chair:SetNoDraw( true );
							chair:SetCollisionGroup( COLLISION_GROUP_DEBRIS );
							chair:GetPhysicsObject():EnableCollisions( false );
							chair.Static = true;
							chair:SetParent( ent );
							
							table.insert( ent.Chairs, chair );
							
						end
						
					end
					
				end
				
			end
			
			if( ent:GetName() == "cc_replace_stove" ) then
				
				local stove = ents.Create( "cc_stove" );
				stove:SetPos( ent:GetPos() );
				stove:SetAngles( ent:GetAngles() );
				stove:SetInvisible( false );
				
				if( ent:GetSaveTable().DefaultAnim ) then
					
					stove:SetBuilding( ent:GetSaveTable().DefaultAnim );
					
				end
				
				stove:Spawn();
				stove:Activate();
				stove:SetModel( ent:GetModel() );
				stove:GetPhysicsObject():EnableMotion( false );
				stove.Static = true;
				
				ent:Remove();
				
			end
			
		end
		
	end );
	
end

function GM:SetupPlayerVisibility( ply, viewent )
	
	if( self.GetHL2CamPos ) then
		
		AddOriginToPVS( self:GetHL2CamPos()[1] );
		
	end
	
	if( self.GetCACamPos ) then
		
		AddOriginToPVS( self:GetCACamPos() );
		
	end
	
	if( self.CombineCameraView and self.CombineCameraView:IsValid() ) then
		
		AddOriginToPVS( self.CombineCameraView:GetPos() );
		
	end
	
end

function nSetJW( len, ply )
	
	if( ( !GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ) or !GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ).CanJW ) and !ply:IsAdmin() ) then return end
	
	local b = net.ReadBit();
	
	GAMEMODE:LogCombine( "[J] " .. ply:VisibleRPName() .. " turned Judgement Waiver " .. ( b == 1 and "on" or "off" ) .. ".", ply );
	
	GAMEMODE:SetJudgementWaiver( b );
	
	if( GAMEMODE:JudgementWaiver() == 1 ) then
		
		if( GAMEMODE.OnJWOn ) then GAMEMODE:OnJWOn() end
		
	else
		
		if( GAMEMODE.OnJWOff ) then GAMEMODE:OnJWOff() end
		
	end
	
end
net.Receive( "nSetJW", nSetJW );

function GM:CreateTV( pos, ang, broken, char )
	
	local prop = ents.Create( "cc_tv" );
	prop:SetPos( pos );
	prop:SetAngles( ang );
	prop:Spawn();
	prop:Activate();
	prop:SetDeployer( char );
	
	if( broken ) then
		
		prop:SetBroken( true );
		prop:SetTVOn( false );
		prop.TVHealth = 0;
		
		if( prop.Microphone and prop.Microphone:IsValid() ) then
			
			prop.Microphone:Remove();
			
		end
		
		if( prop.Speaker and prop.Speaker:IsValid() ) then
			
			prop.Speaker:Remove();
			
		end
		
	end
	
	return prop;
	
end

function GM:CreateMicrowave( pos, ang, broken, char )
	
	local prop = ents.Create( "cc_stove" );
	prop:SetPos( pos );
	prop:SetAngles( ang );
	prop:Spawn();
	prop:Activate();
	prop:SetDeployer( char );
	
	prop:SetModel( "models/props_c17/tv_monitor01.mdl" );
	prop:PhysicsInit( SOLID_VPHYSICS );
	prop:GetPhysicsObject():Wake();
	
	return prop;
	
end

GM.ConnectMessages = { };
GM.EntryPortSpawns = { };

local files = file.Find( GM.FolderName .. "/gamemode/maps/" .. game.GetMap() .. ".lua", "LUA", "namedesc" );

if( #files > 0 ) then

	for _, v in pairs( files ) do
		
		include( "maps/" .. v );
		AddCSLuaFile( "maps/" .. v );
		
	end
	
	MsgC( Color( 200, 200, 200, 255 ), "Serverside map lua file for " .. game.GetMap() .. " loaded.\n" );
	
else
	
	MsgC( Color( 200, 200, 200, 255 ), "Warning: No serverside map lua file for " .. game.GetMap() .. ".\n" );
	
end
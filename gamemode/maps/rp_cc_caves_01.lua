function GM:GetHL2CamPos()
	
	return { Vector( -6645, 6120, -569 ), Angle( -56, -106, 0 ) };
	
end

function GM:MapInitPostEntity()
	
	--self:CreateLocationPoint( Vector( -7924, 5220, 189 ), LOCATION_CANAL, 256, TRANSITPORT_CAVES_ENTRY );
	
	self:AddAntlionSpawn( Vector( -7270, 5126, -7413 ), 2 );
	self:AddAntlionSpawn( Vector( -7527, 6418, -7552 ), 2 );
	self:AddAntlionSpawn( Vector( -8204, 7690, -7596 ), 2 );
	self:AddAntlionSpawn( Vector( -7512, 8855, -7606 ), 2 );
	self:AddAntlionSpawn( Vector( -8233, 8493, -7562 ), 2 );
	self:AddAntlionSpawn( Vector( -8932, 8128, -7695 ), 2 );
	self:AddAntlionSpawn( Vector( -9479, 7723, -7771 ), 2 );
	self:AddAntlionSpawn( Vector( -10053, 7012, -7872 ), 2 );
	self:AddAntlionSpawn( Vector( -9785, 6506, -7909 ), 2 );
	self:AddAntlionSpawn( Vector( -9170, 6045, -7960 ), 2 );
	self:AddAntlionSpawn( Vector( -9895, 4805, -7965 ), 2 );
	self:AddAntlionSpawn( Vector( -9983, 4299, -8005 ), 2 );
	self:AddAntlionSpawn( Vector( -9281, 4042, -8021 ), 2 );
	self:AddAntlionSpawn( Vector( -8992, 3467, -8105 ), 2 );
	self:AddAntlionSpawn( Vector( -8334, 3165, -8141 ), 2 );
	self:AddAntlionSpawn( Vector( -7492, 3731, -8174 ), 2 );
	self:AddAntlionSpawn( Vector( -6786, 2994, -8200 ), 2 );
	
end

--[[GM.ConnectMessages[TRANSITPORT_CAVES_ENTRY] = "You've been here before. Outside, there's a few miles of wild forest leading into City 18's canal system.";

GM.EntryPortSpawns[TRANSITPORT_CAVES_ENTRY] = {
	Vector( -7979, 5588, 157 ),
	Vector( -7935, 5588, 150 ),
	Vector( -7936, 5677, 150 ),
	Vector( -7977, 5759, 139 ),
	Vector( -7920, 5836, 132 ),
	Vector( -7974, 5910, 118 ),
};--]]

GM.Music = GM.EP2Music;

function GM:MapSpawnNPC( ply, npc )
	
	if( npc:GetClass() == "npc_antlionguard" ) then
		
		npc:SetSkin( 1 );
		npc:SetKeyValue( "cavernbreed", "1" );
		npc:SetKeyValue( "incavern", "1" );
		
	end
	
end

GM.DoorData = {
	{ Vector( -6679, 2764, -661.75 ), DOOR_UNBUYABLE, "Shack" },
	{ Vector( -6752, 2915, -661.75 ), DOOR_UNBUYABLE, "Shack" },
	{ Vector( -6304, 2803, -597.75 ), DOOR_UNBUYABLE, "Shack" },
	{ Vector( -7199, 2940, -661.75 ), DOOR_UNBUYABLE, "Shack" },
	{ Vector( -7048, 3013, -661.75 ), DOOR_UNBUYABLE, "Shack" },
};

GM.Stoves = {
	{ Vector( -7104, 2380, -695 ), Angle( 0, 174, 0 ), nil, true },
};

GM.CurrentLocation = LOCATION_OUTLANDS;

if( SERVER ) then
	
	local function PowerOff( ply, args )
		
		ents.FindByName( "power_off" )[1]:Fire( "Trigger" );
		
	end
	concommand.AddAdmin( "rpa_poweroff", PowerOff );
	
	local function PowerOn( ply, args )
		
		ents.FindByName( "power_on" )[1]:Fire( "Trigger" );
		
	end
	concommand.AddAdmin( "rpa_poweron", PowerOn );
	
end
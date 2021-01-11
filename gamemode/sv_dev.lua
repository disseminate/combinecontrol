function ccClearInv( ply, cmd, args )
	
	if( game.IsDedicated() and !ply:IsSuperAdmin() ) then return end
	
	ply:LoadItemsFromString( "" );
	
end
concommand.Add( "rp_dev_clearinv", ccClearInv );

function ccShowInv( ply, cmd, args )
	
	if( game.IsDedicated() and !ply:IsSuperAdmin() ) then return end
	
	ply:PrintMessage( 2, tostring( #ply.Inventory ) .. " ITEMS" );
	
	for k, v in pairs( ply.Inventory ) do
		
		ply:PrintMessage( 2, tostring( k ) );
		
		for l, q in pairs( v ) do
			
			ply:PrintMessage( 2, "\t\"" .. l .. "\"\t" .. type( q ) .. "\t\"" .. tostring( q ) .. "\"" );
			
		end
		
	end
	
end
concommand.Add( "rp_dev_showinv", ccShowInv );

function ccSetConscious( ply, cmd, args )
	
	if( game.IsDedicated() and !ply:IsSuperAdmin() ) then return end
	
	ply:SetConsciousness( math.Clamp( tonumber( args[1] ), 0, 100 ) );
	
	if( ply:Consciousness() <= 0 and !ply:PassedOut() ) then
		
		ply:PassOut();
		
	end
	
end
concommand.Add( "rp_dev_setconsc", ccSetConscious );

function ccMakeDoorDev( ply, cmd, args )
	
	if( game.IsDedicated() and !ply:IsSuperAdmin() ) then return end
	
	if( !args[1] ) then
		
		ply:PrintMessage( 2, "Usage: rp_dev_doordev type name price building" );
		ply:PrintMessage( 2, "Type can be one of:" );
		ply:PrintMessage( 2, "\t0: Unbuyable" );
		ply:PrintMessage( 2, "\t1: Buyable" );
		ply:PrintMessage( 2, "\t2: Combine Openable (like big combine doors)" );
		ply:PrintMessage( 2, "\t3: Combine Lockable (like jail cells)" );
		ply:PrintMessage( 2, "\t4: Combine Assignable" );
		return;
		
	end
	
	local doortype = args[1];
	local name = args[2] or "";
	local price = tonumber( args[3] ) or 0;
	local building = args[4] or "";
	
	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = trace.start + ply:GetAimVector() * 32768;
	trace.filter = ply;
	local tr = util.TraceLine( trace );
	
	if( tr.Entity and tr.Entity:IsValid() and tr.Entity:IsDoor() ) then
		
		local pos = tr.Entity:GetPos();
		
		local doortypeid = tonumber( doortype ) or string.lower( doortype );
		if( doortypeid == "door_unbuyable" or doortypeid == "unbuyable" ) then doortypeid = 0 end
		if( doortypeid == "door_buyable" or doortypeid == "buyable" ) then doortypeid = 1 end
		if( doortypeid == "door_combineopen" or doortypeid == "combineopen" ) then doortypeid = 2 end
		if( doortypeid == "door_combinelock" or doortypeid == "combinelock" ) then doortypeid = 3 end
		if( doortypeid == "door_buyable_assignable" or doortypeid == "buyable_assignable" ) then doortypeid = 4 end
		
		local typestr = "";
		if( doortypeid == 0 ) then typestr = "DOOR_UNBUYABLE"; end
		if( doortypeid == 1 ) then typestr = "DOOR_BUYABLE"; end
		if( doortypeid == 2 ) then typestr = "DOOR_COMBINEOPEN"; end
		if( doortypeid == 3 ) then typestr = "DOOR_COMBINELOCK"; end
		if( doortypeid == 4 ) then typestr = "DOOR_BUYABLE_ASSIGNABLE"; end
		
		local entname = tr.Entity:GetName();
		local vecStr = tr.Entity:MapCreationID();
		
		local str = "{ ";
		str = str .. vecStr .. ", ";
		str = str .. typestr .. ", ";
		str = str .. "\"" .. name .. "\"";
		
		if( price != 0 ) then
			str = str .. ", " .. price;
		end
		
		if( building != "" ) then
			str = str .. ", \"" .. building .. "\"";
		end
		
		str = str .. " },";
		
		ply:PrintMessage( 2, str );
		
		tr.Entity:SetDoorType( doortypeid );
		tr.Entity:SetDoorOriginalName( name );
		tr.Entity:SetDoorName( name );
		tr.Entity:SetDoorPrice( price );
		tr.Entity:SetDoorBuilding( building );
		
	end
	
end
concommand.Add( "rp_dev_doordev", ccMakeDoorDev );

function ccDoorDevUnformatted( ply, cmd, args )
	
	if( game.IsDedicated() and !ply:IsSuperAdmin() ) then return end
	
	ply:PrintMessage( 2, "Doors without formatting:" );
	
	for _, v in pairs( game.GetDoors() ) do
		
		if( v:DoorType() == 0 and v:DoorOriginalName() == "" and v:DoorPrice() == 0 and v:DoorBuilding() == "" ) then
			
			ply:PrintMessage( 2, "\t" .. v:MapCreationID() );
			
		end
		
	end
	
	ply:PrintMessage( 2, "Use rp_dev_doordevgoto [num] to teleport to them." );
	
end
concommand.Add( "rp_dev_doordevtodo", ccDoorDevUnformatted );

function ccDoorDevAll( ply, cmd, args )
	
	if( game.IsDedicated() and !ply:IsSuperAdmin() ) then return end
	
	ply:PrintMessage( 2, "GM.DoorData = {" );
	
	for _, v in pairs( game.GetDoors() ) do
		
		if( v:DoorType() == 0 and v:DoorOriginalName() == "" and v:DoorPrice() == 0 and v:DoorBuilding() == "" ) then continue; end
		
		local pos = v:GetPos();
		
		local typestr = "";
		if( v:DoorType() == 0 ) then typestr = "DOOR_UNBUYABLE"; end
		if( v:DoorType() == 1 ) then typestr = "DOOR_BUYABLE"; end
		if( v:DoorType() == 2 ) then typestr = "DOOR_COMBINEOPEN"; end
		if( v:DoorType() == 3 ) then typestr = "DOOR_COMBINELOCK"; end
		if( v:DoorType() == 4 ) then typestr = "DOOR_BUYABLE_ASSIGNABLE"; end
		
		local name = v:DoorOriginalName();
		local price = v:DoorPrice();
		local building = v:DoorBuilding();
		
		local vecStr = v:MapCreationID();
		
		local str = "\t{ ";
		str = str .. vecStr .. ", ";
		str = str .. typestr .. ", ";
		str = str .. "\"" .. name .. "\"";
		
		if( price != 0 ) then
			str = str .. ", " .. price;
		end
		
		if( building != "" ) then
			str = str .. ", \"" .. building .. "\"";
		end
		
		str = str .. " },";
		
		ply:PrintMessage( 2, str );
		
	end
	
	ply:PrintMessage( 2, "};" );
	
end
concommand.Add( "rp_dev_doordevall", ccDoorDevAll );

function ccDoorDevDefault( ply, cmd, args )
	
	if( game.IsDedicated() and !ply:IsSuperAdmin() ) then return end
	
	ply:PrintMessage( 2, "GM.DoorData = {" );
	
	for _, v in pairs( game.GetDoors() ) do
		
		ply:PrintMessage( 2, "\t{ " .. v:MapCreationID() .. ", DOOR_UNBUYABLE, \"\", 0, \"\" }," );
		
	end
	
	ply:PrintMessage( 2, "};" );
	
end
concommand.Add( "rp_dev_doordevdefault", ccDoorDevDefault );

function ccDoorDevGoto( ply, cmd, args )
	
	if( game.IsDedicated() and !ply:IsSuperAdmin() ) then return end
	
	local arg = args[1];
	local e = ents.GetMapCreatedEntity( tonumber( arg ) );
	
	if( e and e:IsValid() ) then
		
		ply:SetPos( e:GetPos() );
		
	end
	
end
concommand.Add( "rp_dev_doordevgoto", ccDoorDevGoto );

function ccGetSeatPos( ply, cmd, args )
	
	if( game.IsDedicated() and !ply:IsSuperAdmin() ) then return end
	
	for _, v in pairs( ents.FindByClass( "prop_vehicle_prisoner_pod" ) ) do
		
		if( !v.Static ) then
			
			local p = v:GetPos() - Vector( 0, 0, 4 );
			local a = v:GetAngles();
			ply:PrintMessage( 2, "{ Vector( " .. tostring( math.ceil( p.x ) ) .. ", " .. tostring( math.ceil( p.y ) ) .. ", " .. tostring( math.ceil( p.z ) ) .. " ), Angle( 0, " .. tostring( math.ceil( a.y ) ) .. ", 0 ) }," );
			
		end
		
	end
	
end
concommand.Add( "rp_dev_getseatpositions", ccGetSeatPos );

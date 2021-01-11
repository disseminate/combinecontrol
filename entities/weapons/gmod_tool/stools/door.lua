TOOL.ClientConVar[ "class" ] = "prop_dynamic";
TOOL.ClientConVar[ "model" ] = "models/props_combine/combine_door01.mdl";
TOOL.ClientConVar[ "open" ] = "1";
TOOL.ClientConVar[ "close" ] = "2";
TOOL.ClientConVar[ "autoclose" ] = "0";
TOOL.ClientConVar[ "closetime" ] = "5";
TOOL.ClientConVar[ "hardware" ] = "1";
cleanup.Register( "door" );

TOOL.Category		= "Construction";
TOOL.Name			= "#Door";
TOOL.Command		= nil;
TOOL.ConfigName		= "";

if( SERVER ) then
	
	if( !ConVarExists( "sbox_maxdoors" ) ) then
		
		CreateConVar( "sbox_maxdoors", 5, FCVAR_NOTIFY );
		
	end
	
	local function OpenDoor( ply, ent, autoclose, closetime )
		
		if( !ent or !ent:IsValid() ) then return end
		
		ent:Fire( "SetAnimation", "Open" );
		
		if( autoclose == 1 ) then
			
			ent:Fire( "SetAnimation", "Close", closetime );
			
		end
		
	end
	
	local function CloseDoor( ply, ent )
		
		if( !ent or !ent:IsValid() ) then return end
		ent:Fire( "SetAnimation", "Close" );
		
	end
	numpad.Register( "door_open", OpenDoor );
	numpad.Register( "door_close", CloseDoor );
	
	function TOOL:MakeDoor( ply, tr, ang, model, open, close, autoclose, closetime, class, hardware )
		
		if( !ply:CheckLimit( "doors" ) ) then return end
		
		local door = ents.Create( class );
		door:SetModel( model );
		
		local min = door:OBBMins();
		local newpos = Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z - ( tr.HitNormal.z * min.z ) );
		door:SetPos( newpos );
		door:SetAngles( Angle( 0, ang.y, 0 ) );
		
		if( class == "prop_dynamic" ) then
			
			door:SetKeyValue( "solid", "6" );
			door:SetKeyValue( "MinAnimTime" , "1" );
			door:SetKeyValue( "MaxAnimTime" , "5" );
			
		elseif( class == "prop_door_rotating" ) then
			
			door:SetKeyValue( "hardware", hardware );
			door:SetKeyValue( "distance", "90" );
			door:SetKeyValue( "speed", "100" );
			door:SetKeyValue( "returndelay", "-1" );
			door:SetKeyValue( "spawnflags", "8192" );
			door:SetKeyValue( "forceclosed", "0" );
			
		else
			
			return;
			
		end
		
		door.BlacklistException = true;
		door:Spawn();
		door:Activate();
		
		numpad.OnDown( ply, open, "door_open", door, autoclose, closetime );
		if( class == "prop_dynamic" ) then
			numpad.OnDown( ply, close, "door_close", door, autoclose, closetime );
		end
		
		ply:AddCount( "doors", door );
		ply:AddCleanup( "doors", door );
		
		undo.Create( "Door" );
			undo.AddEntity( door );
			undo.SetPlayer( ply );
		undo.Finish();
		
	end
	
else
	
	language.Add( "tool.door.name", "Door" );
	language.Add( "tool.door.desc", "Spawn a door." );
	language.Add( "tool.door.0", "Click somewhere to spawn a door." );
	
	language.Add( "Undone_door", "Undone door." );
	language.Add( "Cleanup_door", "door" );
	language.Add( "SBoxLimit_doors", "Max doors reached." );
	language.Add( "Cleaned_door", "Cleaned up all doors." );
	
end


function TOOL:LeftClick( tr )
	
	if( !SERVER ) then return true end
	
	local model	= self:GetClientInfo( "model" );
	local open = self:GetClientNumber( "open" );
	local close = self:GetClientNumber( "close" );
	local class = self:GetClientInfo( "class" );
	local ply = self:GetOwner();
	local ang = ply:GetAimVector():Angle();
	local autoclose = self:GetClientNumber( "autoclose" );
	local closetime = self:GetClientNumber( "closetime" );
	local hardware = self:GetClientNumber( "hardware" );
	
	if( !ply:CheckLimit( "doors" ) ) then return false end
	
	self:MakeDoor( ply, tr, ang, model, open, close, autoclose, closetime, class, hardware );
	
	return true;

end

function TOOL.BuildCPanel( CPanel )
	
	CPanel:AddControl( "Header", { Text = "#Tool_door_name", Description = "#Tool_door_desc" } );
	
	local params = { Label = "#Presets", MenuButton = 1, Folder = "door", Options = {}, CVars = {} }
		
		params.Options.default = {
			door_model = "models/props_combine/combine_door01.mdl",
			door_open	= 1,
			door_close	= 2 };
		
		table.insert( params.CVars, "door_open" );
		table.insert( params.CVars, "door_close" );
		table.insert( params.CVars, "door_model" );
		
	CPanel:AddControl( "ComboBox", params );
	
	CPanel:AddControl( "Numpad", { Label = "#Door Open", Label2 = "#Door Close", Command = "door_open", Command2 = "door_close", ButtonSize = 22 } );
	
	local params = { Label = "#Models", Height = 150, Options = {} };
	params.Options[ "Tall Combine Door" ] = { door_class = "prop_dynamic", door_model = "models/props_combine/combine_door01.mdl" };
	params.Options[ "Elevator Door" ] = { door_class = "prop_dynamic", door_model = "models/props_lab/elevatordoor.mdl" };
	params.Options[ "Combine Door" ] = { door_class = "prop_dynamic", door_model = "models/combine_gate_Vehicle.mdl" };
	params.Options[ "Small Combine Door" ] = { door_class = "prop_dynamic", door_model = "models/combine_gate_citizen.mdl" };
	params.Options[ "Door #1" ] = { door_hardware = "1", door_class = "prop_door_rotating", door_model = "models/props_c17/door01_left.mdl" };
	params.Options[ "Door #2" ] = { door_hardware = "2", door_class = "prop_door_rotating", door_model = "models/props_c17/door01_left.mdl" };
	params.Options[ "Kleiner Blast Door" ] = { door_class = "prop_dynamic",door_model = "models/props_doors/doorKLab01.mdl" };
	CPanel:AddControl( "ListBox", params );
	
	CPanel:AddControl( "Slider", { Label = "#AutoClose Delay",
	Type	= "Float",
	Min		= 0,
	Max		= 100,
	Command = "door_closetime" } );
	
	CPanel:AddControl( "Checkbox", { Label = "#AutoClose", Command = "door_autoclose" } );
	
end

function TOOL:UpdateGhostThruster( ent, ply )
	
	if( !ent ) then return end
	if( !ent:IsValid() ) then return end
	
	local tr = ply:GetEyeTrace();
	if( !tr.Hit ) then return end
	
	local ang = ply:GetAimVector():Angle();
	local min = ent:OBBMins();
	local newpos = Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z - ( tr.HitNormal.z * min.z ) );
	ent:SetPos( newpos );
	ent:SetAngles( Angle( 0, ang.y, 0 ) );
	
end


function TOOL:Think()

	if( !self.GhostEntity or !self.GhostEntity:IsValid() or self.GhostEntity:GetModel() != self:GetClientInfo( "model" ) ) then
		
		self:MakeGhostEntity( self:GetClientInfo( "model" ), Vector(), Angle() );
		
	end
	
	self:UpdateGhostThruster( self.GhostEntity, self:GetOwner() );
	
end

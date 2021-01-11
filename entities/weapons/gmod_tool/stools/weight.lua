TOOL.Category		= "Construction";
TOOL.Name			= "#tool.weight.name";
TOOL.Command		= nil;
TOOL.ConfigName		= "";

TOOL.ClientConVar["set"] = "1";

if( CLIENT ) then
	
	language.Add( "tool.weight.name", "Weight" );
	language.Add( "tool.weight.desc", "Sets the weight of props." );
	language.Add( "tool_weight_desc", "Sets the weight of props." );
	language.Add( "tool.weight.0", "Primary: Set the weight. Secondary: Copy the weight from another prop. Reload: Reset the weight." );
	language.Add( "tool_weight_set", "Weight:" );
	
end

local function SetMass( ply, ent, data )
	
	if( CLIENT ) then return end
	
	if( data.Mass ) then
		
		local phys = ent:GetPhysicsObject();
		if( phys and phys:IsValid() ) then phys:SetMass( data.Mass ) end
		
	end
	
	duplicator.StoreEntityModifier( ent, "mass", data );
	
end

duplicator.RegisterEntityModifier( "mass", SetMass );

function TOOL:CanWeight( tr )
	
	if( !tr.Entity ) then return false end
	if( !tr.Entity:IsValid() ) then return false end
	if( tr.Entity:IsPlayer() ) then return false end
	if( SERVER and !( tr.Entity:GetPhysicsObject() and tr.Entity:GetPhysicsObject():IsValid() ) ) then return false end
	
	return true;
	
end

function TOOL:LeftClick( tr )
	
	if( !self:CanWeight( tr ) ) then return false end
	
	if( CLIENT ) then return true end
	
	if( !tr.Entity.OriginalWeight ) then
		
		tr.Entity.OriginalWeight = tr.Entity:GetPhysicsObject():GetMass();
		
	end
	
	local mass = tonumber( self:GetClientInfo( "set" ) );
	
	if( mass > 0 ) then
		
		SetMass( self:GetOwner(), tr.Entity, { Mass = mass } );
		
		DoPropSpawnedEffect( tr.Entity );
		
		return true;
		
	end
	
end

function TOOL:RightClick( tr )
	
	if( !self:CanWeight( tr ) ) then return false end
	
	if( CLIENT ) then return true end
	
	local mass = tr.Entity:GetPhysicsObject():GetMass();
	self:GetOwner():ConCommand( "weight_set " .. mass );
	
	return true;
	
end

function TOOL:Reload( tr )
	
	if( !self:CanWeight( tr ) ) then return false end
	if( CLIENT ) then return true end
	
	local o = tr.Entity.OriginalWeight;
	if( !o ) then return false end
	
	SetMass( self:GetOwner(), tr.Entity, { Mass = o } );
	
	return true;
	
end

function TOOL:Think()
	
	
	
end

function TOOL.BuildCPanel( cp )
	
	cp:AddControl( "Header", { Text = "#Tool_weight_name", Description	= "#Tool_weight_desc" }  );
	
	local params = { Label = "#Presets", MenuButton = 1, Folder = "weight", Options = {}, CVars = {} };
	
	params.Options.default = { weight_set = 3 };
	table.insert( params.CVars, "weight_set" );
	
	cp:AddControl( "ComboBox", params );
	cp:AddControl( "Slider", { Label = "#Tool_weight_set", Type = "Numeric", Min = "1", Max = "50000", Command = "weight_set" } );
end


if( CLIENT ) then
	
	language.Add( "tool.nocollideworld.name", "No Collide World" );
	language.Add( "tool.nocollideworld.desc", "Disable collisions between a prop and the world." );
	language.Add( "tool.nocollideworld.0", "Click to disable collisions." );
	
end

TOOL.Category		= "Construction"
TOOL.Name			= "#tool.nocollideworld.name"

function TOOL:LeftClick( tr )
	
	if( !tr.Entity or !tr.Entity:IsValid() ) then return false end
	if( tr.Entity:IsPlayer() ) then return false end
	if( tr.Entity:IsWorld() ) then return false end
	
	if( SERVER and !util.IsValidPhysicsObject( tr.Entity, tr.PhysicsBone ) ) then return false end
	
	if( CLIENT ) then return true end
	
	local ent = tr.Entity;
	local bone = tr.PhysicsBone;
	
	local const = constraint.NoCollideWorld( ent, bone );
	
	undo.Create( "No Collide World" );
		undo.AddEntity( const );
		undo.SetPlayer( self:GetOwner() );
	undo.Finish();
	
	DoPropSpawnedEffect( tr.Entity );

	return true;
	
end

function TOOL:RightClick( tr )
	
	return false;
	
end

local function CreateConstraintSystem()
	
	local ent = ents.Create( "phys_constraintsystem" );
	ent:SetKeyValue( "additionaliterations", GetConVarNumber( "gmod_physiterations" ) );
	ent:Spawn();
	ent:Activate();
	
	return ent;
	
end

local function FindOrCreateConstraintSystem(Ent1, Ent2)
	local System
	if !Ent1:IsWorld() and Ent1:GetTable().ConstraintSystem and Ent1:GetTable().ConstraintSystem:IsValid() then System = Ent1:GetTable().ConstraintSystem end
	if System and System:IsValid() and System:GetVar("constraints", 0) > 100 then System = nil end
	if !System and !Ent2:IsWorld() and Ent2:GetTable().ConstraintSystem and Ent2:GetTable().ConstraintSystem:IsValid() then System = Ent2:GetTable().ConstraintSystem end
	if System and System:IsValid() and System:GetVar("constraints", 0) > 100 then System = nil end
	if !System or !System:IsValid() then System = CreateConstraintSystem() end
	Ent1.ConstraintSystem = System
	Ent2.ConstraintSystem = System
	System.UsedEntities = System.UsedEntities or {}
	table.insert(System.UsedEntities, Ent1)
	table.insert(System.UsedEntities, Ent2)
	System:SetVar("constraints", System:GetVar("constraints", 0)+1)
	return System
end

function constraint.NoCollideWorld( ent, bone )
	
	if( !ent or !ent:IsValid() ) then return false end
	
	local phys = ent:GetPhysicsObjectNum( bone );
	local wphys = game.GetWorld():GetPhysicsObjectNum( 0 );
	
	if( !phys or !phys:IsValid() or !wphys or !wphys:IsValid() ) then return false end
	
	if( ent:GetTable().Constraints ) then
		
		for _, v in pairs( ent:GetTable().Constraints ) do
			
			if( v:IsValid() or v == game.GetWorld() ) then
				
				local tab = v:GetTable();
				
				if( tab.Type == "NoCollideWorld" and tab.Ent1 == ent ) then return false end
				
			end
			
		end
		
	end
	
	SetPhysConstraintSystem( FindOrCreateConstraintSystem( ent, game.GetWorld() ) );
	
	local physent = ents.Create( "phys_ragdollconstraint" );
	
	physent:SetKeyValue( "xmin", -180 );
	physent:SetKeyValue( "xmax", 180 );
	physent:SetKeyValue( "ymin", -180 );
	physent:SetKeyValue( "ymax", 180 );
	physent:SetKeyValue( "zmin", -180 );
	physent:SetKeyValue( "zmax", 180 );
	physent:SetKeyValue( "spawnflags", 3 );
	physent:SetPhysConstraintObjects( phys, wphys );
	physent:Spawn();
	physent:Activate();
	
	SetPhysConstraintSystem( NULL );
	
	constraint.AddConstraintTable( ent, physent, game.GetWorld() );
	
	local tab = {
		Type = "NoCollideWorld",
		Ent1 = ent,
		Ent2 = game.GetWorld(),
		Bone1 = bone,
		Bone2 = 0
	}
	
	physent:SetTable( tab );
	
	return physent;
	
end
duplicator.RegisterConstraint( "NoCollideWorld", constraint.NoCollideWorld, "Ent1", "Ent2", "Bone1", "Bone2" );
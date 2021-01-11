AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName		= "";
ENT.Author			= "";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= false;
ENT.AdminSpawnable		= false;

function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:SetupDataTables()
	
	self:NetworkVar( "Bool", 0, "StoveOn" );
	self:NetworkVar( "Bool", 1, "Invisible" );
	self:NetworkVar( "Bool", 2, "Broken" );
	self:NetworkVar( "String", 0, "Building" );
	self:NetworkVar( "Int", 0, "Deployer" );
	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );
	
	self:SetStoveOn( false );
	self:SetBroken( false );
	
	self:SetModel( "models/props_c17/furniturestove001a.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	
end

function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( self:GetBroken() ) then return end
	
	if( self:GetStoveOn() ) then
		
		local omin = self:OBBMins();
		local omax = self:OBBMaxs();
		
		omin.z = 20;
		omax.z = 30;
		
		local min, max = self:GetRotatedAABB( omin, omax );
		
		if( self:GetModel() == "models/props_wasteland/kitchen_stove001a.mdl" ) then
			
			min, max = self:GetRotatedAABB( Vector( -17, 5, 40 ), Vector( 17, 33, 50 ) );
			
		end
		
		if( self:GetModel() == "models/props_c17/tv_monitor01.mdl" ) then
			
			min, max = self:GetRotatedAABB( Vector( -20, -20, -8 ), Vector( 20, 20, 32 ) );
			
		end
		
		local enttab = ents.FindInBox( self:GetPos() + min, self:GetPos() + max );
		
		local bleach = nil;
		local drugbreen = nil;
		local smallmedkit = nil;
		local water = nil;
		local vodka = nil;
		
		local items = { };
		
		for _, v in pairs( enttab ) do
			
			if( v:GetClass() == "cc_item" ) then
				
				if( !items[v:GetItem()] ) then
					
					items[v:GetItem()] = v;
					
				end
				
			end
			
		end
		
		for _, v in pairs( GAMEMODE.Recipes ) do
			
			local good = true;
			
			for k, n in pairs( v[1] ) do
				
				if( !items[n] ) then good = false; end
				
			end
			
			if( good ) then
				
				local pos = nil;
				
				for _, n in pairs( items ) do
					
					if( v[1][1] == n:GetItem() ) then
						
						pos = n:GetPos();
						
					end
					
				end
				
				if( pos ) then
					
					for k, n in pairs( items ) do
						
						if( table.HasValue( v[1], k ) ) then
							
							n:Remove();
							
						end
						
					end
					
					if( v[3] ) then
						
						if( math.random( 1, 1 / v[4] ) == 1 ) then
							
							for k, n in pairs( v[3] ) do
								
								timer.Simple( ( k - 1 ) / 2, function()
									
									GAMEMODE:CreatePhysicalItem( n, pos, Angle() );
									
								end );
								
							end
							
						else
							
							for k, n in pairs( v[2] ) do
								
								timer.Simple( ( k - 1 ) / 2, function()
									
									GAMEMODE:CreatePhysicalItem( n, pos, Angle() );
									
								end );
								
							end
							
						end
						
					else
						
						for k, n in pairs( v[2] ) do
							
							timer.Simple( ( k - 1 ) / 2, function()
								
								GAMEMODE:CreatePhysicalItem( n, pos, Angle() );
								
							end );
							
						end
						
					end
					
				end
				
			end
			
		end
		
		if( self.ExplodeTime and CurTime() > self.ExplodeTime and self:GetModel() != "models/props_c17/tv_monitor01.mdl" ) then
			
			if( !self.NextExplodeCheck ) then self.NextExplodeCheck = CurTime() end
			
			if( CurTime() >= self.NextExplodeCheck ) then
				
				self.NextExplodeCheck = CurTime() + 60;
				
				if( math.random( 1, 5 ) == 1 ) then
					
					self:SetBroken( true );
					self:SetStoveOn( false );
					self.SteamEnt:Fire( "TurnOff" );
					
					local explo = ents.Create( "env_explosion" );
					explo:SetOwner( self );
					explo:SetPos( self:GetPos() );
					explo:SetKeyValue( "iMagnitude", "0" );
					explo:SetKeyValue( "iRadiusOverride", "0" );
					explo:Spawn();
					explo:Activate();
					explo:Fire( "Explode" );
					
					local fire = ents.Create( "env_fire" );
					fire:SetName( "cc_fire_" .. fire:EntIndex() );
					fire:SetPos( self:GetPos() + Vector( 0, 0, 32 ) );
					fire:SetKeyValue( "spawnflags", "134" );
					fire:SetKeyValue( "firesize", "32" );
					fire:SetKeyValue( "health", "5" );
					fire:Spawn();
					fire:Activate();
					
					local snd = ents.Create( "ambient_generic" );
					snd:SetPos( fire:GetPos() + Vector( 0, 0, 32 ) );
					snd:SetKeyValue( "health", "10" );
					snd:SetKeyValue( "message", "d1_town.MediumFireLoop" );
					snd:SetKeyValue( "spawnflags", "0" );
					snd:SetKeyValue( "SourceEntityName", "cc_fire_" .. fire:EntIndex() );
					snd:Spawn();
					snd:Activate();
					snd:Fire( "FadeOut", "1", 6 );
					snd:Fire( "Kill", "", 7 );
					
				end
				
			end
			
		end
		
	end
	
end

function ENT:Use( ply )
	
	if( self:GetBroken() ) then return end
	
	if( SERVER ) then
		
		if( self:GetBuilding() != "" and !table.HasValue( ply:OwnedBuildings(), self:GetBuilding() ) and !table.HasValue( ply:AssignedBuildings(), self:GetBuilding() ) ) then
			
			net.Start( "nUnownedStove" );
			net.Send( ply );
			return;
			
		end
		
		self:EmitSound( Sound( "buttons/lightswitch2.wav" ) );
		
		self:SetStoveOn( !self:GetStoveOn() );
		
		if( ( !self.SteamEnt or !self.SteamEnt:IsValid() ) and self:GetModel() != "models/props_c17/tv_monitor01.mdl" ) then
			
			local pos = self:GetPos();
			if( string.lower( self:GetModel() ) == "models/props_wasteland/kitchen_stove001a.mdl" ) then
				
				pos = self:GetPos() + self:GetRight() * -20 + self:GetUp() * 18;
				
			end
			
			self.SteamEnt = ents.Create( "env_smokestack" );
			self.SteamEnt:SetPos( pos );
			self.SteamEnt:SetKeyValue( "BaseSpread", "1" );
			self.SteamEnt:SetKeyValue( "SpreadSpeed", "30" );
			self.SteamEnt:SetKeyValue( "Speed", "50" );
			self.SteamEnt:SetKeyValue( "StartSize", "3" );
			self.SteamEnt:SetKeyValue( "EndSize", "5" );
			self.SteamEnt:SetKeyValue( "roll", "10");
			self.SteamEnt:SetKeyValue( "Rate", "700" );
			self.SteamEnt:SetKeyValue( "JetLength", "30" );
			self.SteamEnt:SetKeyValue( "twist", "5" );
			self.SteamEnt:SetKeyValue( "SmokeMaterial", "sprites/heatwave" );
			
			self.SteamEnt:Spawn();
			self.SteamEnt:SetParent( self );
			self.SteamEnt:Activate();
			self:DeleteOnRemove( self.SteamEnt );
			
		end
		
		if( self:GetStoveOn() ) then
			
			if( self.SteamEnt and self.SteamEnt:IsValid() ) then
				
				self.SteamEnt:Fire( "TurnOn" );
				
			end
			
			self.ExplodeTime = CurTime() + math.random( 600, 900 );
			self.NextExplodeCheck = nil;
			
		else
			
			if( self.SteamEnt and self.SteamEnt:IsValid() ) then
				
				self.SteamEnt:Fire( "TurnOff" );
				
			end
			
		end
		
	end
	
end

function ENT:CanPhysgun()
	
	return self:GetDeployer() > 0;
	
end

ENT.LightMat = Material( "particle/fire" );

function ENT:Draw()
	
	if( !self:GetInvisible() ) then
		
		self:DrawModel();
		self:DrawShadow( true );
		
		if( self:GetStoveOn() and self:GetModel() == "models/props_c17/tv_monitor01.mdl" ) then
			
			render.SetMaterial( self.LightMat );
			render.DrawSprite( self:GetPos() + self:GetForward() * 9 + self:GetRight() * -8 + self:GetUp() * 4, 8, 8, Color( 255, 255, 200, 255 ), false );
			
		end
		
	else
		
		self:DrawShadow( false );
		
	end
	
end
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
	
	self:NetworkVar( "Bool", 0, "TVOn" );
	self:NetworkVar( "Bool", 1, "Static" );
	self:NetworkVar( "Bool", 2, "Broken" );
	self:NetworkVar( "Int", 0, "Deployer" );
	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );
	
	self.TVHealth = 20;
	
	self:SetTVOn( true );
	self:SetBroken( false );
	
	self:SetModel( "models/props_c17/tv_monitor01.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	
	self.Screen = ents.Create( "prop_physics" );
	self.Screen:SetPos( self:GetPos() );
	self.Screen:SetAngles( self:GetAngles() );
	self.Screen:SetModel( "models/props_c17/tv_monitor01_screen.mdl" );
	self.Screen:SetParent( self );
	self.Screen:SetSolid( SOLID_NONE );
	self.Screen:SetMoveType( MOVETYPE_NONE );
	self.Screen:Spawn();
	self.Screen:Activate();
	self.Screen:SetNotSolid( true );
	
	self:DeleteOnRemove( self.Screen );
	
	local micsamplers = ents.FindByName( "cc_micsamplepoint" );
	
	if( #micsamplers == 0 ) then
		
		self:SetStatic( true );
		
	end
	
	self:CreateMicrophone();
	
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:Wake();
		
	end
	
end

function ENT:CreateMicrophone()
	
	if( !self:GetStatic() ) then
		
		self.Speaker = ents.Create( "info_target" );
		self.Speaker:SetPos( self:GetPos() );
		self.Speaker:SetName( "speaker_" .. self.Speaker:EntIndex() );
		self.Speaker:SetParent( self );
		self.Speaker:Spawn();
		self.Speaker:Activate();
		
		self:DeleteOnRemove( self.Speaker );
		
		self.Microphone = ents.Create( "env_microphone" );
		self.Microphone:SetPos( self:GetPos() );
		self.Microphone:SetName( "cc_microphones" );
		self.Microphone:SetParent( self );
		self.Microphone:SetKeyValue( "MaxRange", "320" );
		self.Microphone:SetKeyValue( "Sensitivity", "3" );
		self.Microphone:SetKeyValue( "spawnflags", "0" );
		self.Microphone:SetKeyValue( "speaker_dsp_preset", tostring( MICROPHONE_SMALL ) );
		self.Microphone:SetKeyValue( "SpeakerName", "speaker_" .. self.Speaker:EntIndex() );
		self.Microphone:SetKeyValue( "target", "cc_micsamplepoint" );
		self.Microphone:Spawn();
		self.Microphone:Activate();
		self.Microphone:Fire( "Enable" );
		
		self:DeleteOnRemove( self.Microphone );
		
	end
	
end

function ENT:OnTakeDamage( dmginfo )
	
	self:TakePhysicsDamage( dmginfo );
	
	if( self:GetBroken() ) then return end
	
	self.TVHealth = self.TVHealth - dmginfo:GetDamage();
	
	if( self.TVHealth <= 0 ) then
		
		self:SetBroken( true );
		self:SetTVOn( false );
		
		if( self.Microphone and self.Microphone:IsValid() ) then
			
			self.Microphone:Remove();
			
		end
		
		if( self.Speaker and self.Speaker:IsValid() ) then
			
			self.Speaker:Remove();
			
		end
		
	end
	
end

function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( self:GetBroken() ) then return end
	
	if( self:GetTVOn() and self:GetStatic() ) then
		
		if( !self.NextStaticSound ) then self.NextStaticSound = CurTime() end
		
		if( CurTime() >= self.NextStaticSound ) then
			
			local snd = Sound( "ambient/levels/prison/radio_random" .. math.random( 1, 15 ) .. ".wav" );
			self.NextStaticSound = CurTime() + SoundDuration( snd );
			self:EmitSound( snd );
			
		end
		
	end
	
end

function ENT:Use( ply )
	
	if( self:GetBroken() ) then return end
	
	if( SERVER ) then
		
		self:EmitSound( Sound( "buttons/lightswitch2.wav" ) );
		
		self:SetTVOn( !self:GetTVOn() );
		
		if( self.Microphone and self.Microphone:IsValid() ) then
			
			if( !self:GetTVOn() ) then
				
				self.Microphone:Fire( "Disable" );
				
			else
				
				self.Microphone:Fire( "Enable" );
				
			end
			
		end
		
		if( !self:GetTVOn() ) then
			
			for i = 1, 15 do
				
				self:StopSound( "ambient/levels/prison/radio_random" .. math.random( 1, 15 ) .. ".wav" );
				
			end
			
		end
		
	end
	
end

if( CLIENT ) then
	
	local tab = { };
	tab["$basetexture"] = "_rt_Camera";
	ENT.CameraMat = CreateMaterial( "tv_rendertarget", "UnlitGeneric", tab );
	
	local tab = { };
	tab["$basetexture"] = "decals/decal_posterbreentv";
	ENT.CameraMatOff = CreateMaterial( "tv_off", "UnlitGeneric", tab );
	
	ENT.CameraMatStatic = Material( "effects/breenscreen_static01_" );
	
end

function ENT:Draw()
	
	self:DrawModel();
	
	if( self:GetBroken() ) then return end
	
	if( self:GetTVOn() ) then
		
		local pos = self:GetPos();
		pos = pos + self:GetForward() * 6;
		pos = pos + self:GetRight() * 9;
		pos = pos + self:GetUp() * 7;
		
		local ang = self:GetAngles();
		ang:RotateAroundAxis( ang:Up(), 90 );
		ang:RotateAroundAxis( ang:Forward(), 90 );
		
		cam.Start3D2D( pos, ang, 0.03 );
			
			surface.SetDrawColor( 255, 255, 255, 255 );
			
			if( self:GetStatic() ) then
				surface.SetMaterial( self.CameraMatStatic );
			else
				if( CurTime() <= GAMEMODE:BreenEndTime() ) then
					surface.SetMaterial( self.CameraMat );
				else
					surface.SetMaterial( self.CameraMatOff );
				end
			end
			
			surface.DrawTexturedRect( 0, 0, 512, 400 );
			
		cam.End3D2D();
		
	end
	
end

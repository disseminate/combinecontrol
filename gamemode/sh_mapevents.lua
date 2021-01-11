local meta = FindMetaTable( "Entity" );

function GM:AddMapEvent( name, func )
	
	if( !self.MapEvents ) then self.MapEvents = { }; end
	
	self.MapEvents[name] = func;
	
end

function GM:PlayMapEvent( name )
	
	if( CLIENT ) then return end
	
	self.MapEvents[name]( self );
	
end

ME = { };

function ME.CreateEnvSpark( name, pos, delay, magnitude, length, flags )
	
	local ent = ents.Create( "env_spark" );
	ent:SetPos( pos );
	ent:SetName( name );
	ent:SetKeyValue( "spawnflags", flags or 0 );
	ent:SetKeyValue( "Magnitude", magnitude or 1 );
	ent:SetKeyValue( "MaxDelay", delay or 0 );
	ent:SetKeyValue( "TrailLength", length or 1 );
	ent:Spawn();
	ent:Activate();
	
	return ent;
	
end

function ME.CreateScriptedSequence( name, pos, ang, radius, moveto, targ, idle, play, postidle, flags )
	
	local ent = ents.Create( "scripted_sequence" );
	ent:SetPos( pos );
	ent:SetAngles( ang );
	ent:SetName( name );
	ent:SetKeyValue( "spawnflags", flags or 0 );
	ent:SetKeyValue( "m_flRadius", radius or 0 );
	ent:SetKeyValue( "m_fMoveTo", moveto or 1 );
	ent:SetKeyValue( "m_iszEntity", targ or "" );
	ent:SetKeyValue( "m_iszIdle", idle or "" );
	ent:SetKeyValue( "m_iszPlay", play or "" );
	ent:SetKeyValue( "m_iszPostIdle", postidle or "" );
	ent:Spawn();
	ent:Activate();
	
	return ent;
	
end

function ME.CreateLogicRelay( name, flags )
	
	local ent = ents.Create( "logic_relay" );
	ent:SetName( name );
	ent:SetKeyValue( "spawnflags", flags or 0 );
	ent:Spawn();
	ent:Activate();
	
	return ent;
	
end

function ME.CreateInfoTarget( name, pos, flags )
	
	local ent = ents.Create( "info_target" );
	ent:SetName( name );
	ent:SetPos( pos );
	ent:SetKeyValue( "spawnflags", flags or 0 );
	ent:Spawn();
	ent:Activate();
	
	return ent;
	
end

function ME.CreateAmbientGeneric( name, pos, sound, radius, source, flags )
	
	local ent = ents.Create( "ambient_generic" );
	ent:SetPos( pos );
	ent:SetName( name );
	ent:SetKeyValue( "spawnflags", flags or 48 );
	ent:SetKeyValue( "message", sound or "" );
	ent:SetKeyValue( "radius", radius or 1250 );
	ent:SetKeyValue( "SourceEntityName", source or "" );
	ent:Spawn();
	ent:Activate();
	
	return ent;
	
end

function ME.CreatePhysExplosion( name, pos, magnitude, limit, flags )
	
	local ent = ents.Create( "env_physexplosion" );
	ent:SetPos( pos );
	ent:SetName( name );
	ent:SetKeyValue( "spawnflags", flags or 1 );
	ent:SetKeyValue( "magnitude", magnitude or 100 );
	ent:SetKeyValue( "targetentityname", limit or "" );
	ent:Spawn();
	ent:Activate();
	
	return ent;
	
end

function ME.CreateEnvShooter( name, pos, ang, model, giblife, variance, velocity, gibs, sounds, sim, flags )
	
	local ent = ents.Create( "env_shooter" );
	ent:SetPos( pos );
	ent:SetAngles( ang );
	ent:SetName( name );
	ent:SetKeyValue( "spawnflags", flags or 0 );
	ent:SetKeyValue( "m_flGibLife", giblife or 4 );
	ent:SetKeyValue( "m_flVariance", variance or 0.15 );
	ent:SetKeyValue( "m_flVelocity", velocity or 200 );
	ent:SetKeyValue( "m_iGibs", gibs or 3 );
	ent:SetKeyValue( "shootmodel", model or "" );
	ent:SetKeyValue( "shootsounds", sounds or 4 );
	ent:SetKeyValue( "simulation", sim or 1 );
	ent:Spawn();
	ent:Activate();
	
	return ent;
	
end

function ME.CreatePhysImpact( name, pos, targ, flags )
	
	local ent = ents.Create( "env_physimpact" );
	ent:SetPos( pos );
	ent:SetName( name );
	ent:SetKeyValue( "spawnflags", flags or 0 );
	ent:SetKeyValue( "directionentityname", targ or "" );
	ent:Spawn();
	ent:Activate();
	
	return ent;
	
end

function ME.CreateEnvShake( name, pos, amp, dur, freq, radius, flags )
	
	local ent = ents.Create( "env_shake" );
	ent:SetPos( pos );
	ent:SetName( name );
	ent:SetKeyValue( "spawnflags", flags or 0 );
	ent:SetKeyValue( "amplitude", amp or 4 );
	ent:SetKeyValue( "duration", dur or 1 );
	ent:SetKeyValue( "frequency", freq or 2.5 );
	ent:SetKeyValue( "radius", radius or 500 );
	ent:Spawn();
	ent:Activate();
	
	return ent;
	
end

function ME.CreateAR2Explosion( name, pos, mat, flags )
	
	local ent = ents.Create( "env_ar2explosion" );
	ent:SetPos( pos );
	ent:SetName( name );
	ent:SetKeyValue( "spawnflags", flags or 0 );
	ent:SetKeyValue( "material", mat or "particle/particle_noisesphere" );
	ent:Spawn();
	ent:Activate();
	
	return ent;
	
end

function ME.CreateMonsterGeneric( name, pos, ang, model, flags )
	
	local ent = ents.Create( "monster_generic" );
	ent:SetPos( pos );
	ent:SetAngles( ang );
	ent:SetModel( model );
	ent:SetKeyValue( "spawnflags", flags or 0 );
	ent:Spawn();
	ent:Activate();
	
	return ent;
	
end

function meta:AddOutput( output, targ, input, param, delay, once )
	
	if( !param ) then param = ""; end
	if( !delay ) then delay = 0; end
	if( !once ) then once = 0; end
	
	self:Fire( "AddOutput", output .. " " .. targ .. ":" .. input .. ":" .. param .. ":" .. delay .. ":" .. once );
	
end

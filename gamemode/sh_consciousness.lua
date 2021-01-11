local meta = FindMetaTable( "Player" );

if( CLIENT ) then
	
	function nWakeUp( len )
		
		local ply = net.ReadEntity();
		
		if( LocalPlayer() == ply ) then
			
			ply.DrawWakeUp = CurTime();
			
		end
		
	end
	net.Receive( "nWakeUp", nWakeUp );
	
end

function meta:MakeRagdollClone()
	
	if( self:Ragdoll() and self:Ragdoll():IsValid() ) then
		
		self:Ragdoll():Remove();
		
	end
	
	local rag = ents.Create( "prop_ragdoll" );
	rag = ents.Create( "prop_ragdoll" );
	rag:SetPos( self:GetPos() );
	rag:SetAngles( self:GetAngles() );
	rag:SetModel( self:GetModel() );
	rag:SetSkin( self:GetSkin() );
	for i = 0, 20 do
		rag:SetBodygroup( i, self:GetBodygroup( i ) );
		rag:SetSubMaterial( i, self:GetSubMaterial( i ) );
	end
	rag:Spawn();
	rag:Activate();
	function rag:GetPlayerColor()
		
		if( !self:PropFakePlayer() or !self:PropFakePlayer():IsValid() ) then return Vector( 1, 1, 1 ) end
		
		return self:PropFakePlayer():GetPlayerColor();
		
	end
	
	rag:SetPropFakePlayer( self );
	self:SetRagdoll( rag );
	
	return rag;
	
end

function meta:SnapFromRagdollClone()
	
	if( self:Ragdoll() and self:Ragdoll():IsValid() ) then
		
		self:SetPos( self:Ragdoll():GetPos() );
		
		self:Ragdoll():Remove();
		
	end
	
end

function meta:PassOut()
	
	if( self:FlashlightIsOn() ) then
		
		self:Flashlight( false );
		
	end
	
	self:AllowFlashlight( false );
	
	self:SetPassedOut( true );
	
	self:ExitVehicle();
	self:SetNoTarget( true );
	self:SetNoDraw( true );
	
	for _, v in pairs( GAMEMODE.HandsWeapons ) do
		
		if( self:HasWeapon( v ) ) then
			
			self:SelectWeapon( v );
			break;
			
		end
		
	end
	
	self:SetHolstered( true );
	self:SetNotSolid( true );
	
	if( self:GetActiveWeapon() != NULL ) then
		
		self:GetActiveWeapon():SetNoDraw( true );
		
	end
	
	return self:MakeRagdollClone();
	
end

function meta:WakeUp( spawn )
	
	self:SetPassedOut( false );
	
	self:AllowFlashlight( true );
	
	self:SetNoTarget( false );
	self:SetNoDraw( false );
	self:SetNotSolid( false );
	
	if( self:GetActiveWeapon() != NULL ) then
		
		self:GetActiveWeapon():SetNoDraw( false );
		
	end
	
	if( !spawn ) then
		
		self:SnapFromRagdollClone();
		
		net.Start( "nWakeUp" );
			net.WriteEntity( self );
		net.Broadcast();
		
	end
	
end

function meta:TakeCDamage( amt )
	
	if( self:Armor() > 0 and amt > 0 ) then
		
		amt = amt * 0.75; -- armor
		
	end
	
	self:SetConsciousness( math.Clamp( self:Consciousness() - amt, 0, 100 ) );
	
	if( self:Consciousness() <= 0 and !self:PassedOut() ) then
		
		self:PassOut();
		
	end
	
	if( self:Consciousness() == 100 and self:PassedOut() ) then
		
		self:WakeUp();
		
	end
	
end

function GM:ConsciousThink( ply )
	
	if( !ply.ConsciousUpdate ) then
		
		ply.ConsciousUpdate = CurTime();
		
	end
	
	if( CurTime() >= ply.ConsciousUpdate ) then
		
		if( ply:Ragdoll() and ply:Ragdoll():IsValid() ) then
			
			ply:SetPos( ply:Ragdoll():GetPos() );
			
			if( ply:Ragdoll():GetVelocity():Length() > 15 ) then
				
				return;
				
			end
			
		end
		
		local d = 1 - ( ply:Toughness() / 100 ) * 0.7;
		d = d + ( ply:Hunger() / 100 ) * 1;
		
		ply.ConsciousUpdate = CurTime() + d;
		
		ply:TakeCDamage( -1 );
		
	end
	
end

function GM:HungerThink( ply )
	
	if( !self.UseHunger ) then
		
		if( tonumber( ply:Hunger() ) > 0 ) then
			
			ply:SetHunger( 0 );
			ply:UpdateCharacterField( "Hunger", ply:Hunger() );
			
		end
		
		return;
		
	end
	
	if( !ply.HungerUpdate ) then
		
		ply.HungerUpdate = CurTime();
		
	end
	
	if( CurTime() >= ply.HungerUpdate and ply:CharID() != -1 and ply:GetVelocity():Length2D() > 5 and !ply:IsEFlagSet( EFL_NOCLIP_ACTIVE ) ) then
		
		ply.HungerUpdate = CurTime() + 120;
		
		ply:SetHunger( math.Clamp( ply:Hunger() + 1, 0, 100 ) );
		ply:UpdateCharacterField( "Hunger", ply:Hunger() );
		
	end
	
end
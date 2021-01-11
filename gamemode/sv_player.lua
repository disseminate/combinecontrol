local meta = FindMetaTable( "Player" );

GM.CombineRadioFreq = 1000; -- dick weed

function GM:PlayerInitialSpawn( ply )
	
	if( !self.FullyLoaded ) then
		
		self:LogBug( "ERROR: PlayerInitialSpawn on player " .. ply:Nick() .. " before gamemode fully loaded." );
		return;
		
	end
	
	self.BaseClass:PlayerInitialSpawn( ply );
	
	ply:SetCustomCollisionCheck( true );
	ply:SetCanZoom( false );
	ply:Freeze( true );
	
	ply.AFKTime = CurTime();
	
	if( ply:IsBot() ) then
		
		return;
		
	end
	
	ply.SQLPlayerData = { };
	ply.SQLCharData = { };
	
	ply:SetHolstered( true );
	
end

function GM:PlayerInitialSpawnSafe( ply )
	
	ply:SetModelCC( table.Random( { "models/crow.mdl", "models/pigeon.mdl", "models/seagull.mdl" } ) );
	
	ply:LoadPlayerInfo();
	
	ply:SetRadioFreq( math.random( 0, 999 ) );
	ply:SyncAllGlobalData();
	
	ply:SetNotSolid( true );
	ply:SetMoveType( MOVETYPE_NOCLIP );
	
end

function GM:PlayerCheckFlag( ply, respawn )
	
	local flagtab = self:LookupCharFlag( ply:CharFlags() );
	local flag = self:LookupCombineFlag( ply:ActiveFlag() );
	local hasany = ply:HasAnyCombineFlag();
	
	if( #flagtab > 0 ) then
		
		ply:SetRadioFreq( math.random( 0, 999 ) );
		
		for _, v in pairs( flagtab ) do
			
			if( !v.Additive ) then
				
				ply:SetPlayerColor( Vector( v.Color.r, v.Color.g, v.Color.b ) / 255 );
				
				if( v.Team ) then
					
					ply:SetTeam( v.Team );
					
				end
				
				ply:SetModelCC( v.ModelFunc( ply ) );
				if( v.SetupModel ) then
					v.SetupModel( ply );
				end
				
			else
				
				ply:SetModelCC( ply.CharModel );
				
			end
			
			v.OnSpawn( ply );
			
		end
		
	elseif( flag ) then
		
		ply:SetModelCC( flag.ModelFunc( ply ) );
		if( flag.SetupModel ) then
			flag.SetupModel( ply );
		end
		
		ply:SetPlayerColor( Vector( flag.Color.r, flag.Color.g, flag.Color.b ) / 255 );
		
		ply:SetRadioFreq( self.CombineRadioFreq );
		
	elseif( ply.CharModel ) then
		
		ply:SetRadioFreq( math.random( 0, 999 ) );
		
		ply:SetModelCC( ply.CharModel );
		
	end
	
	self:RefreshNPCRelationships();
	
	if( ply.EntryPort and self.EntryPortSpawns[ply.EntryPort] ) then
		
		ply:SetPos( table.Random( self.EntryPortSpawns[ply.EntryPort] ) );
		return;
		
	end
	
	if( hasany or ply:HasCharFlag( "S" ) or ply:HasCharFlag( "W" ) ) then
		
		if( self.CombineSpawnpoints and respawn ) then
			
			ply:SetPos( table.Random( self.CombineSpawnpoints ) );
			
		end
		
	end
	
end

function GM:PlayerCheckInventory( ply )
	
	for _, v in pairs( ply.Inventory ) do
		
		if( !GAMEMODE:GetItemByID( v ) ) then continue end
		
		GAMEMODE:GetItemByID( v ).OnPlayerSpawn( v, ply );
		
	end
	
end

function GM:PlayerConnect( name, ip )
	
	if( !self.Books ) then
		
		self:LoadBooks();
		
	end
	
end

function GM:PlayerSpawn( ply )
	
	self.BaseClass:PlayerSpawn( ply );
	
	player_manager.SetPlayerClass( ply, "player_cc" );
	
	ply:SetNoCollideWithTeammates( false );
	ply:SetAvoidPlayers( false );
	
	ply:SetDuckSpeed( 0.3 );
	ply:SetUnDuckSpeed( 0.3 );
	
	ply:SetHolstered( true );
	
	ply:AllowFlashlight( true );
	
	ply:SetLastLegShot( -20 );
	
	ply:SetConsciousness( 100 );
	ply:WakeUp( true );
	
	ply.DrownDamage = 0;
	
	ply.Uniform = nil;
	
	ply:SetNotSolid( false );
	ply:SetMoveType( MOVETYPE_WALK );
	
	if( ply:Ragdoll() and ply:Ragdoll():IsValid() ) then
		
		ply:Ragdoll():Remove();
		
	end
	
	if( ply:IsBot() ) then
		
		if( !ply.CharCreateCompleted ) then
			
			local data = { };
			data.Date = os.date( "!%m/%d/%y %H:%M:%S" );
			data.RPName = ply:Nick();
			data.Model = table.Random( self.CitizenModels );
			data.CID = math.random( 1, 99999 );
			data.Money = 200;
			data.Loan = 500;
			data.CombineFlag = "";
			data.CharFlags = "";
			data.CombineSquad = "";
			data.CombineSquadID = 0;
			data.Inventory = "backpack:1";
			data.StatSpeed = 0;
			data.StatStrength = 0;
			data.StatToughness = 0;
			data.StatPerception = 0;
			data.StatAgility = 0;
			data.StatAim = 0;
			data.BusinessLicenses = 0;
			data.CombineAppStatus = 0;
			data.CombineAppDate = "";
			data.CriminalRecord = "";
			data.Hunger = 0;
			
			data.Title = "This bot, named " .. ply:Nick() .. ", was born today out of a Xen portal anomaly. They don't remember much, as they have no memories, and their motor functions are extremely hindered by the fact that they have no brain. They cannot speak, simply existing as a shell, forever doomed to wander around Garry's Mod roleplay servers, fruitlessly.";
			
			ply:LoadCharacter( data );
			
		end
		
		self:PlayerCheckFlag( ply );
		self:PlayerCheckInventory( ply, true );
		
		return;
		
	end
	
	if( !ply.InitialSafeSpawn ) then
		
		ply.InitialSafeSpawn = true;
		self:PlayerInitialSpawnSafe( ply );
		
	end
	
	if( !ply.CharCreateCompleted ) then return end
	
	self:PlayerCheckFlag( ply, true );
	self:PlayerCheckInventory( ply );
	
end

function GM:PlayerFlagLoadout( ply )
	
	local flagtab = self:LookupCharFlag( ply:CharFlags() );
	
	if( #flagtab > 0 ) then
		
		for _, v in pairs( flagtab ) do
			
			for _, n in pairs( v.Loadout ) do
				
				ply:Give( n );
				
			end
			
			for _, n in pairs( v.ItemLoadout ) do
				
				if( !ply:HasItem( n ) ) then
					
					ply:GiveItem( n, 1 );
					
				end
				
			end
			
			if( v.Additive ) then
				
				ply:Give( "weapon_cc_hands" );
				
			end
			
		end
		
	else
		
		local flag = self:LookupCombineFlag( ply:ActiveFlag() );
		
		if( flag ) then
			
			for _, n in pairs( flag.Loadout ) do
				
				if( !ply:HasItem( n ) ) then
					
					ply:GiveItem( n, 1 );
					
				end
				
			end
			
		end
		
		ply:Give( "weapon_cc_hands" );
		
	end
	
end

function GM:PlayerLoadout( ply )
	
	if( !ply.CharCreateCompleted ) then return end
	
	GAMEMODE:PlayerFlagLoadout( ply );
	
	if( ply:PhysTrust() == 1 or ply:IsAdmin() ) then
		
		ply:Give( "weapon_physgun" );
		
	end
	
	--ply:Give( "weapon_physcannon" );
	
	if( ply:ToolTrust() > 0 or ply:IsAdmin() ) then
		
		ply:Give( "gmod_tool" );
		
	end
	
end

function meta:LoadPlayer( data )
	
	self:SetToolTrust( tonumber( data.ToolTrust ), true );
	self:SetPhysTrust( tonumber( data.PhysTrust ), true );
	self:SetPropTrust( tonumber( data.PropTrust ), true );
	self:SetNewbieStatus( tonumber( data.NewbieStatus ), true );
	self:SetCustomMaxProps( tonumber( data.CustomMaxProps ), true );
	self:SetCustomMaxRagdolls( tonumber( data.CustomMaxRagdolls ), true );
	
	self:SetScoreboardTitle( data.ScoreboardTitle, true );
	self:SetScoreboardTitleC( Vector( data.ScoreboardTitleC ), true );
	self:SetScoreboardBadges( tonumber( data.ScoreboardBadges ), true );
	
	self:SetDonationAmount( tonumber( data.DonationAmount ), true );
	
end

function nRequestPData( len, ply )
	
	if( !ply.RequestedPData ) then
		
		ply:LoadPlayer( ply.SQLPlayerData );
		ply.RequestedPData = true;
		
	end
	
end
net.Receive( "nRequestPData", nRequestPData );

function meta:LoadCharacter( data )
	
	self.CharCreateCompleted = true;
	self:Freeze( false );
	
	self:StripWeapons();
	self:ClearDrug();
	
	self:SetTeam( TEAM_CITIZEN );
	self:SetActiveFlag( "" );
	
	self:SetCharCreationDate( data.Date );
	
	self:SetCharID( tonumber( data.id ) );
	
	self:SetRPName( data.RPName );
	self:SetDescription( data.Title );
	
	self.CharModel = data.Model;
	
	self:SetTrait( tonumber( data.Trait ) );
	
	self:SetCID( data.CID );
	self:SetMoney( tonumber( data.Money ) );
	
	self:SetCombineFlag( data.CombineFlag );
	self:SetCharFlags( data.CharFlags );
	
	self:SetCombineSquad( data.CombineSquad );
	self:SetCombineSquadID( tonumber( data.CombineSquadID ) );
	
	self:SetSpeed( tonumber( data.StatSpeed ) );
	self:SetStrength( tonumber( data.StatStrength ) );
	self:SetToughness( tonumber( data.StatToughness ) );
	self:SetPerception( tonumber( data.StatPerception ) );
	self:SetAgility( tonumber( data.StatAgility ) );
	self:SetAim( tonumber( data.StatAim ) );
	
	self:SetLoan( tonumber( data.Loan ) );
	
	self:SetBusinessLicenses( tonumber( data.BusinessLicenses ) );
	
	self:SetCriminalRecord( data.CriminalRecord );
	
	self:SetCombineAppStatus( tonumber( data.CombineAppStatus ) );
	self:SetCombineAppDate( data.CombineAppDate );
	
	self:SetHunger( tonumber( data.Hunger ) );
	self:SetCPRationDate( data.CPRationDate );
	
	self:LoadItemsFromString( data.Inventory );
	
	self.EntryPort = tonumber( data.EntryPort );
	
	self:UpdateCharacterField( "LastOnline", os.date( "!%m/%d/%y %H:%M:%S" ) );
	
	if( self:CombineFlag() != "" ) then
		
		self:SetTeam( TEAM_OFFCOMBINE );
		
	end
	
	if( self:IsBot() ) then return end
	
	self:SyncAllOtherData();
	
	self:PostLoadCharacter();
	
	self:Spawn();
	
end

function meta:PostLoadCharacter()
	
	if( !self:HasBadge( BADGE_BIRTHDAY ) and os.date( "!%m-%d" ) == "06-07" ) then
		
		self:SetScoreboardBadges( self:ScoreboardBadges() + BADGE_BIRTHDAY );
		self:UpdatePlayerField( "ScoreboardBadges", self:ScoreboardBadges() );
		
		self:AddMoney( 200 );
		self:UpdateCharacterField( "Money", tostring( self:Money() ) );
		
		net.Start( "nAddChat" );
			net.WriteVector( Vector( 200, 200, 200 ) );
			net.WriteString( "It's Disseminate's birthday today! You've been awarded 200 credits and a badge!" );
		net.Send( self );
		
	end
	
end

function GM:SpeedThink( ply )
	
	local walk, run, jump, crouch = ply:GetSpeeds();
	
	if( ply:GetRunSpeed() != run ) then
		
		ply:SetRunSpeed( run );
		
	end
	
	if( ply:GetWalkSpeed() != walk ) then
		
		ply:SetWalkSpeed( walk );
		
	end
	
	if( ply:GetJumpPower() != jump ) then
		
		ply:SetJumpPower( jump );
		
	end
	
	if( ply:GetCrouchedWalkSpeed() != math.floor( crouch / walk ) ) then
		
		ply:SetCrouchedWalkSpeed( math.floor( crouch / walk ) );
		
	end
	
	if( ply:GetVelocity():Length2D() > run and ply:OnGround() ) then
		
		if( !ply.NextJumpStat or CurTime() >= ply.NextJumpStat ) then
			
			ply.NextJumpStat = CurTime() + 10;
			
			ply:SetSpeed( math.Clamp( ply:Speed() + self:ScaledStatIncrease( ply, ply:Speed() ) * 0.02, 0, 100 ) );
			ply:UpdateCharacterField( "StatSpeed", tostring( ply:Speed() ), true );
			
		end
		
	end
	
end

function GM:FindUseEntity( ply, ent )
	
	if( ply:PassedOut() ) then return; end
	if( ply:TiedUp() and !( ent and ent:IsValid() and ent:IsVehicle() ) ) then return; end
	if( ply:MountedGun() and ply:MountedGun():IsValid() ) then return ply:MountedGun() end
	
	if( !ply.NextUseAPC ) then ply.NextUseAPC = CurTime() end
	
	if( ply:APC() and ply:APC():IsValid() ) then
		
		if( CurTime() >= ply.NextUseAPC ) then
			
			ply:SetPos( ply:APC():GetPos() + ply:APC():GetForward() * -200 + Vector( 0, 0, 20 ) );
			ply:SetAPC( NULL );
			
			ply:AllowFlashlight( true );
			
			ply:SetNoTarget( false );
			ply:SetNoDraw( false );
			ply:SetNotSolid( false );
			
			if( ply:GetActiveWeapon() != NULL ) then
				
				ply:GetActiveWeapon():SetNoDraw( false );
				
			end
			
			ply.NextUseAPC = CurTime() + 0.5;
			
		end
		
		return;
		
	elseif( ent and ent:IsValid() and ent:GetClass() == "prop_vehicle_apc" ) then
		
		if( CurTime() >= ply.NextUseAPC ) then
			
			if( ply:HasAnyCombineFlag() ) then
				
				ply:SetAPC( ent );
				
				if( ply:FlashlightIsOn() ) then
					
					ply:Flashlight( false );
					
				end
				
				ply:AllowFlashlight( false );
				
				ply:SetNoTarget( true );
				ply:SetNoDraw( true );
				
				for _, v in pairs( GAMEMODE.HandsWeapons ) do
					
					if( ply:HasWeapon( v ) ) then
						
						ply:SelectWeapon( v );
						break;
						
					end
					
				end
				
				ply:SetHolstered( true );
				ply:SetNotSolid( true );
				
				if( ply:GetActiveWeapon() != NULL ) then
					
					ply:GetActiveWeapon():SetNoDraw( true );
					
				end
				
			end
			
			ply.NextUseAPC = CurTime() + 0.5;
			
		end
		
		return;
		
	end
	
	return self.BaseClass:FindUseEntity( ply, ent );
	
end

function GM:PlayerUse( ply, ent )
	
	return self.BaseClass:PlayerUse( ply, ent );
	
end

function GM:KeyPress( ply, key )
	
	if( key == IN_USE ) then
		
		if( ply:HasAnyCombineFlag() ) then
			
			local tr = self:GetHandTrace( ply, 100 );
			
			if( tr.Entity and tr.Entity:IsValid() and tr.Entity:IsDoor() and tr.Entity:DoorType() == DOOR_COMBINEOPEN ) then
				
				tr.Entity:Fire( "Open" );
				
			end
			
		end
		
	end
	
end

function GM:PlayerSay( ply, text, t )
	
	return "";
	
end

function ccCSay( ply, cmd, args )
	
	if( ply:EntIndex() != 0 ) then return end
	
	local text = "";
	
	for i = 1, #args do
		
		text = text .. args[i] .. " ";
		
	end
	
	text = string.Trim( text );
	
	net.Start( "nConSay" );
		net.WriteString( text );
	net.Broadcast();
	
end
concommand.Add( "csay", ccCSay );

function GM:PlayerDeathSound()
	
	return true;
	
end

GM.BannedWeaponPickups = {
	"weapon_crowbar",
	"weapon_stunstick",
	"weapon_pistol",
	"weapon_smg1",
	"weapon_ar2",
	"weapon_shotgun",
	"weapon_crossbow",
	"weapon_357",
	"weapon_rpg",
	"weapon_annabelle",
};

GM.VortWeaponPickups = {
	"weapon_cc_vortigaunt",
	"weapon_cc_vortigaunt_slave",
	"weapon_cc_vortbroom",
	"weapon_cc_vortbroom_diss",
	"weapon_physgun",
	"weapon_physcannon",
	"gmod_tool",
};

GM.StalkerWeaponPickups = {
	"weapon_cc_stalker",
	"weapon_physgun",
	"weapon_physcannon",
	"gmod_tool",
};

function GM:PlayerCanPickupWeapon( ply, wep )
	
	if( table.HasValue( self.BannedWeaponPickups, wep:GetClass() ) ) then
		
		return false;
		
	end
	
	if( ply:HasCharFlag( "V" ) or ply:HasCharFlag( "W" ) ) then
		
		if( !table.HasValue( self.VortWeaponPickups, wep:GetClass() ) ) then
			
			return false;
			
		end
		
	end
	
	if( ply:HasCharFlag( "S" ) ) then
		
		if( !table.HasValue( self.StalkerWeaponPickups, wep:GetClass() ) ) then
			
			return false;
			
		end
		
	end
	
	return true;
	
end

function GM:EntityTakeDamage( ent, dmg )
	
	if( ent:GetClass() == "prop_ragdoll" and ent:PropFakePlayer() and ent:PropFakePlayer():IsValid() ) then
		
		if( ent:PropFakePlayer():IsEFlagSet( EFL_NOCLIP_ACTIVE ) ) then return end
		
		if( dmg:GetDamageType() == DMG_CRUSH ) then return end
		
		local pdmg = DamageInfo();
		pdmg:SetAttacker( dmg:GetAttacker() );
		pdmg:SetDamage( dmg:GetDamage() );
		pdmg:SetDamageForce( dmg:GetDamageForce() );
		pdmg:SetDamagePosition( ent:GetPos() );
		pdmg:SetInflictor( dmg:GetInflictor() );
		
		ent:PropFakePlayer():TakeDamageInfo( pdmg );
		
	end
	
	if( ent:IsVehicle() and ent:GetDriver() and ent:GetDriver():IsValid() ) then
		
		if( dmg:GetDamageType() == DMG_CRUSH ) then return end
		
		local pdmg = DamageInfo();
		pdmg:SetAttacker( dmg:GetAttacker() );
		pdmg:SetDamage( dmg:GetDamage() );
		pdmg:SetDamageForce( dmg:GetDamageForce() );
		pdmg:SetDamagePosition( ent:GetPos() );
		pdmg:SetInflictor( dmg:GetInflictor() );
		
		ent:GetDriver():TakeDamageInfo( pdmg );
		
	end
	
	if( ent:IsPlayer() ) then
		
		if( ent:IsEFlagSet( EFL_NOCLIP_ACTIVE ) or ent:Team() == TEAM_UNASSIGNED ) then
			
			dmg:ScaleDamage( 0 );
			return;
			
		end
		
		if( dmg:GetDamage() > 5 ) then
			
			if( !ent.NextDamageStat ) then ent.NextDamageStat = CurTime(); end
			
			if( CurTime() >= ent.NextDamageStat ) then
				
				ent.NextDamageStat = CurTime() + 10;
				
				ent:SetToughness( math.Clamp( ent:Toughness() + GAMEMODE:ScaledStatIncrease( ent, ent:Toughness() ) * 0.1, 0, 100 ) );
				ent:UpdateCharacterField( "StatToughness", tostring( ent:Toughness() ), true );
				
			end
			
		end
		
		dmg:ScaleDamage( 1 - ( ent:Toughness() / 100 ) * 0.5 );
		dmg:ScaleDamage( ent:DrugDamageMod() );
		dmg:ScaleDamage( math.Clamp( ( ent:Hunger() / 100 ) * 2, 1, 2 ) );
		
	end
	
	if( bit.band( dmg:GetDamageType(), DMG_BULLET ) == DMG_BULLET and dmg:GetAttacker():IsPlayer() ) then
		
		if( dmg:GetAttacker():GetPos():Distance( ent:GetPos() ) > 200 or ent:GetVelocity():Length() > 50 ) then
			
			if( !dmg:GetAttacker().NextShoot ) then dmg:GetAttacker().NextShoot = CurTime(); end
			
			if( CurTime() >= dmg:GetAttacker().NextShoot ) then
				
				dmg:GetAttacker().NextShoot = CurTime() + 5;
				
				dmg:GetAttacker():SetAim( math.Clamp( dmg:GetAttacker():Aim() + GAMEMODE:ScaledStatIncrease( dmg:GetAttacker(), dmg:GetAttacker():Aim() ) * 0.15, 0, 100 ) );
				dmg:GetAttacker():UpdateCharacterField( "StatAim", tostring( dmg:GetAttacker():Aim() ), true );
				
			end
			
		end
		
	end
	
	if( ent:IsNPC() ) then
		
		ent:AddEntityRelationship( dmg:GetAttacker(), D_HT, 99 );
		
	end
	
end

function GM:DoPlayerDeath( ply, attacker, dmg )
	
	if( ply.Inventory ) then
		
		for _, v in pairs( ply.Inventory ) do
			
			if( GAMEMODE:GetItemByID( v ) and GAMEMODE:GetItemByID( v ).OnPlayerDeath ) then
				
				GAMEMODE:GetItemByID( v ).OnPlayerDeath( v, ply );
				
			end
			
		end
		
	end
	
	if( self:LookupCombineFlag( ply:ActiveFlag() ) ) then
		
		EmitSentence( "METROPOLICE_DIE" .. math.random( 0, 8 ), ply:GetPos(), ply:EntIndex(), 0, 0.5, 100, 0, 100 );
		
		if( self.CombineDeathLineEnabled ) then
			
			local rf = { };
			
			for _, v in pairs( player.GetAll() ) do
				
				if( ply:RadioFreq() == v:RadioFreq() and ply != v and v:HasItem( "radio" ) ) then
					
					table.insert( rf, v );
					
				end
				
			end
			
			net.Start( "nChatRadioDeath" );
				net.WriteEntity( ply );
			net.Send( rf );
			
		end
		
	end
	
	if( self.UntieOnDeath ) then
		
		ply:SetTiedUp( false );
		
	end
	
	if( !ply:PassedOut() ) then
		
		ply:CreateRagdoll();
		
	end
	
end

function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )
	
	if( ply:IsEFlagSet( EFL_NOCLIP_ACTIVE ) or ply:Team() == TEAM_UNASSIGNED ) then
		
		dmginfo:ScaleDamage( 0 );
		return;
		
	end
	
	if( hitgroup == HITGROUP_HEAD ) then
		
		dmginfo:ScaleDamage( 2 );
		
	end
	
	if( hitgroup == HITGROUP_LEFTARM or
		hitgroup == HITGROUP_RIGHTARM or 
		hitgroup == HITGROUP_LEFTLEG or
		hitgroup == HITGROUP_RIGHTLEG or
		hitgroup == HITGROUP_GEAR ) then
		
		dmginfo:ScaleDamage( 0.25 );
		
	end
	
	if( hitgroup == HITGROUP_LEFTLEG or
		hitgroup == HITGROUP_RIGHTLEG ) then
		
		if( bit.band( dmginfo:GetDamageType(), DMG_BULLET ) == DMG_BULLET ) then
			
			local b = 15 - ( ply:Toughness() / 100 * 15 );
			b = b + ( ply:Hunger() / 100 ) * 10;
			
			if( CurTime() - ply:LastLegShot() >= b + 5 ) then
				
				ply:EmitSound( "Flesh.Break" );
				
			end
			
			ply:SetLastLegShot( CurTime() );
			
		end
		
	end
	
end

function GM:GetFallDamage( ply, speed )
	
	local b = 15 - ( ply:Toughness() / 100 * 15 );
	b = b + ( ply:Hunger() / 100 ) * 10;
	
	if( CurTime() - ply:LastLegShot() >= b + 5 ) then
		
		ply:EmitSound( "Flesh.Break" );
		
	end
	
	ply:SetLastLegShot( CurTime() );
	
	return self.BaseClass:GetFallDamage( ply, speed );
	
end

function GM:CanPlayerSuicide( ply )
	
	if( ply:CharID() == -1 ) then return false end
	if( ply:TiedUp() ) then return false end
	if( ply:PassedOut() ) then return false end
	if( ply:MountedGun() and ply:MountedGun():IsValid() ) then return false end
	if( ply:APC() and ply:APC():IsValid() ) then return false end
	
	return true;
	
end

function GM:PlayerShouldTakeDamage( ply, attacker )
	
	if( attacker:GetClass() == "prop_physics" or attacker:GetClass() == "prop_ragdoll" or attacker:GetClass() == "cc_item" ) then return false end
	
	return true;
	
end

function GM:EntityRemoved( ent )
	
	if( ent:GetClass() == "prop_ragdoll" ) then
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:RagdollIndex() == ent:EntIndex() ) then
				
				v:SetRagdollIndex( -1 );
				
			end
			
		end
		
		if( ent:PropFakePlayer() and ent:PropFakePlayer():IsValid() and ent:PropFakePlayer():PassedOut() ) then
			
			ent:PropFakePlayer():Kill();
			
		end
		
	end
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v:APC() == ent ) then
			
			v:SetPos( ent:GetPos() + Vector( 0, 0, 20 ) );
			v:SetAPC( NULL );
			
			local rag = v:PassOut();
			v:SetConsciousness( 80 );
			
			rag:GetPhysicsObject():SetVelocity( Vector( math.random( -5000000, 5000000 ), math.random( -5000000, 50000000 ), math.random( 500000, 5000000 ) ) );
			
		end
		
	end
	
end

function GM:PlayerDisconnected( ply )
	
	for _, v in pairs( game.GetDoors() ) do
		
		if( table.HasValue( v:DoorOwners(), ply:CharID() ) ) then
			
			if( table.Count( v:DoorOwners() ) == 1 ) then
				
				ply:SellDoor( v );
				
			else
				
				ply:RemoveDoorOwner( v );
				
			end
			
		end
		
		if( table.HasValue( v:DoorAssignedOwners(), ply ) ) then
			
			ply:RemoveDoorAssignedOwner( v );
			
		end
		
	end
	
	if( ply:Ragdoll() and ply:Ragdoll():IsValid() ) then
		
		ply:Ragdoll():Remove();
		
	end
	
	if( ply:ToolTrust() == 0 ) then
		
		for _, v in pairs( ents.FindByClass( "prop_physics" ) ) do
			
			if( ply:SteamID() == v:PropSteamID() ) then
				
				v:Remove();
				
			end
			
		end
		
	end
	
end

function GM:ShutDown()
	
	for _, ply in pairs( player.GetAll() ) do
		
		for _, v in pairs( game.GetDoors() ) do
			
			if( table.HasValue( v:DoorOwners(), ply:CharID() ) ) then
				
				if( table.Count( v:DoorOwners() ) == 1 ) then
					
					ply:SellDoor( v );
					
				else
					
					ply:RemoveDoorOwner( v );
					
				end
				
			end
			
			if( table.HasValue( v:DoorAssignedOwners(), ply ) ) then
				
				ply:RemoveDoorAssignedOwner( v );
				
			end
			
		end
		
	end
	
end

function GM:PlayerSpray( ply )
	
	return game.IsDedicated();
	
end

function GM:PlayerCanHearPlayersVoice( targ, ply )
	
	return !game.IsDedicated();
	
end

function GM:PlayerShouldTaunt( ply, act )
	
	return false;
	
end

function GM:CanPlayerEnterVehicle( ply, vehicle, role )
	
	if( self.BaseClass:CanPlayerEnterVehicle( ply, vehicle, role ) ) then
		
		if( vehicle.Static ) then
			
			vehicle.PlayerPos = ply:GetPos();
			vehicle.PlayerAngles = ply:EyeAngles();
			
		end
		
		if( !string.find( ply:GetModel(), "player" ) and vehicle:GetModel() != "models/vehicles/prisoner_pod_inner.mdl" ) then
			
			return false;
			
		end
		
		if( vehicle:GetParent() and vehicle:GetParent():IsValid() ) then
			
			if( vehicle:GetParent():GetVelocity():Length2D() > 1 ) then return false end
			
			local trace = { };
			trace.start = vehicle:GetPos();
			trace.endpos = trace.start + Vector( 0, 0, 64 );
			trace.filter = { vehicle, vehicle:GetParent() };
			
			local tr = util.TraceLine( trace );
			
			if( tr.Hit ) then return false end
			
			if( vehicle.PhysgunActive or vehicle:GetParent().PhysgunActive ) then return false end
			
			vehicle:GetParent():GetPhysicsObject():EnableMotion( false );
			
		end
		
		return true;
		
	end
	
	return false;
	
end

function GM:CanExitVehicle( vehicle, ply )
	
	if( vehicle.Static ) then
		
		vehicle.PlayerAngles = ply:EyeAngles();
		vehicle.PlayerAngles.r = 0;
		
	end
	
	return self.BaseClass:CanExitVehicle( vehicle, ply );
	
end

function GM:PlayerLeaveVehicle( ply, vehicle )
	
	if( vehicle.PlayerPos ) then
		
		ply:SetPos( vehicle.PlayerPos );
		
	end
	
	if( vehicle.PlayerAngles ) then
		
		ply:SetEyeAngles( vehicle.PlayerAngles );
		
	end
	
	vehicle.PlayerPos = nil;
	
end

function meta:WaterThink()
	
	if( !self:Alive() ) then return end
	
	local waterlevel = 3;
	local targ = self;
	
	if( self:PassedOut() ) then
		
		waterlevel = 1;
		targ = self:Ragdoll();
		
	end
	
	if( targ:WaterLevel() < waterlevel ) then
		
		self.AirFinished = CurTime() + 7;
		
		if( self.DrownDamage and self.DrownDamage > 0 ) then
			
			if( !self.PainFinished ) then self.PainFinished = 0 end
			
			if( self.PainFinished < CurTime() ) then
				
				self.PainFinished = CurTime() + 1;
				
				local dmg = DamageInfo();
				dmg:SetAttacker( game.GetWorld() );
				dmg:SetDamage( 10 );
				dmg:SetDamageForce( Vector() );
				dmg:SetDamagePosition( self:GetPos() );
				dmg:SetInflictor( game.GetWorld() );
				dmg:SetDamageType( DMG_DROWN );
				
				GAMEMODE:EntityTakeDamage( self, dmg );
				
				self:SetHealth( self:Health() + dmg:GetDamage() );
				self.DrownDamage = self.DrownDamage - 10;
				
			end
			
		end
		
	else
		
		if( !self:IsEFlagSet( EFL_NOCLIP_ACTIVE ) ) then
			
			if( self.AirFinished < CurTime() ) then
				
				if( !self.PainFinished ) then self.PainFinished = 0 end
				
				if( self.PainFinished < CurTime() ) then
					
					self.PainFinished = CurTime() + 1;
					
					local dmg = DamageInfo();
					dmg:SetAttacker( game.GetWorld() );
					dmg:SetDamage( 10 );
					dmg:SetDamageForce( Vector() );
					dmg:SetDamagePosition( self:GetPos() );
					dmg:SetInflictor( game.GetWorld() );
					dmg:SetDamageType( DMG_DROWN );
					
					if( !self.DrownDamage ) then self.DrownDamage = 0 end
					self.DrownDamage = math.min( self.DrownDamage + 10, 50 );
					
					self:TakeDamageInfo( dmg );
					
				end
				
			end
			
		end
		
	end
	
end

function nSetTyping( len, ply )
	
	local val = net.ReadUInt( 2 );
	ply:SetTyping( val );
	
end
net.Receive( "nSetTyping", nSetTyping );

function nApplyCombine( len, ply )
	
	local ta = util.TimeSinceDate( ply:CombineAppDate() );
	local da = math.floor( ta / ( 60 * 24 ) );
	
	local val1 = net.ReadString();
	local val2 = net.ReadString();
	local val3 = net.ReadString();
	local val4 = net.ReadString();
	
	if( string.len( val1 ) <= 2000 and string.len( val2 ) <= 2000 and string.len( val3 ) <= 2000 and string.len( val4 ) <= 2000 ) then
		
		GAMEMODE:AddCPApp( ply, val1, val2, val3, val4 );
		
	end
	
end
net.Receive( "nApplyCombine", nApplyCombine );

function nRequestCombineHousingDoors( len, ply )
	
	local tab = { };
	
	for k, v in pairs( game.GetDoors() ) do
		
		if( v:DoorType() == DOOR_BUYABLE_ASSIGNABLE ) then
			
			table.insert( tab, v );
			
		end
		
	end
	
	net.Start( "nReceiveCombineHousingDoors" );
		net.WriteUInt( #tab, 10 );
		for _, v in pairs( tab ) do
			net.WriteString( v:DoorName() );
			net.WriteUInt( v:EntIndex(), 16 );
			net.WriteUInt( #v:DoorAssignedOwners(), 6 );
			for _, n in pairs( v:DoorAssignedOwners() ) do
				if( n == -1 ) then
					net.WriteEntity( player.GetBots()[1] );
				else
					net.WriteEntity( n );
				end
			end
		end
	net.Send( ply );
	
end
net.Receive( "nRequestCombineHousingDoors", nRequestCombineHousingDoors );

function nGetCPAppsList( len, ply )
	
	if( !GAMEMODE:LookupCombineFlag( ply:CombineFlag() ).CanEditCPs ) then return end
	
	net.Start( "nCPAppsList" );
		net.WriteTable( GAMEMODE.CPAppsTable );
	net.Send( ply );
	
end
net.Receive( "nGetCPAppsList", nGetCPAppsList );

function nApproveCPApp( len, ply )
	
	if( !GAMEMODE:LookupCombineFlag( ply:CombineFlag() ).CanEditCPs ) then return end
	
	local appid = net.ReadUInt( 32 );
	
	if( GAMEMODE.CPAppsTable[appid] ) then
		
		local app = GAMEMODE.CPAppsTable[appid];
		
		local targ = nil;
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:CharID() == app.CharID ) then
				
				targ = v;
				break;
				
			end
			
		end
		
		if( targ and targ:IsValid() ) then
			
			targ:SetCombineFlag( "A" );
			
			targ:SetCombineAppStatus( CPAPP_SUCC );
			
			targ:UpdateCharacterField( "CombineFlag", targ:CombineFlag() );
			targ:UpdateCharacterField( "CombineAppStatus", targ:CombineAppStatus() );
			targ:UpdateCharacterField( "CombineAppDate", os.date( "!%m/%d/%y %H:%M:%S" ) );
			
			net.Start( "nCombineAccepted" );
			net.Send( targ );
			
		else
			
			GAMEMODE:UpdateCharacterFieldOffline( app.CharID, "CombineAppStatus", CPAPP_SUCC );
			GAMEMODE:UpdateCharacterFieldOffline( app.CharID, "CombineAppDate", os.date( "!%m/%d/%y %H:%M:%S" ) );
			
		end
		
		table.remove( GAMEMODE.CPAppsTable, appid );
		GAMEMODE:LogCombine( "[A] " .. ply:VisibleRPName() .. " approved character " .. app.Name .. "'s CP application.", ply );
		
		local function qS()
			
			GAMEMODE:LogSQL( "Character " .. app.Name .. "'s CP application was approved." );
			
		end
		
		mysqloo.Query( "DELETE FROM cc_cpapps WHERE CharID = '" .. app.CharID .. "'", qS );
		
		local tab = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:IsAdmin() ) then
				
				table.insert( tab, v );
				
			end
			
		end
		
		net.Start( "nCPAppsList" );
			net.WriteTable( GAMEMODE.CPAppsTable );
		net.Send( tab );
		
	end
	
end
net.Receive( "nApproveCPApp", nApproveCPApp );

function nDenyCPApp( len, ply )
	
	if( !GAMEMODE:LookupCombineFlag( ply:CombineFlag() ).CanEditCPs ) then return end
	
	local appid = net.ReadUInt( 32 );
	
	if( GAMEMODE.CPAppsTable[appid] ) then
		
		local app = GAMEMODE.CPAppsTable[appid];
		
		local targ = nil;
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:CharID() == app.CharID ) then
				
				targ = v;
				break;
				
			end
			
		end
		
		if( targ and targ:IsValid() ) then
			
			targ:SetCombineAppStatus( CPAPP_DENIED );
			
			targ:UpdateCharacterField( "CombineAppStatus", targ:CombineAppStatus() );
			targ:UpdateCharacterField( "CombineAppDate", os.date( "!%m/%d/%y %H:%M:%S" ) );
			
			net.Start( "nCombineDenied" );
			net.Send( targ );
			
		else
			
			GAMEMODE:UpdateCharacterFieldOffline( app.CharID, "CombineAppStatus", CPAPP_DENIED );
			GAMEMODE:UpdateCharacterFieldOffline( app.CharID, "CombineAppDate", os.date( "!%m/%d/%y %H:%M:%S" ) );
			
		end
		
		table.remove( GAMEMODE.CPAppsTable, appid );
		GAMEMODE:LogCombine( "[A] " .. ply:VisibleRPName() .. " denied character " .. app.Name .. "'s CP application.", ply );
		
		local function qS()
			
			GAMEMODE:LogSQL( "Character " .. app.Name .. "'s CP application was denied." );
			
		end
		
		mysqloo.Query( "DELETE FROM cc_cpapps WHERE CharID = '" .. app.CharID .. "'", qS );
		
		local tab = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:IsAdmin() ) then
				
				table.insert( tab, v );
				
			end
			
		end
		
		net.Start( "nCPAppsList" );
			net.WriteTable( GAMEMODE.CPAppsTable );
		net.Send( tab );
		
	end
	
end
net.Receive( "nDenyCPApp", nDenyCPApp );

function nPromoteRecruit( len, ply )
	
	if( !GAMEMODE:LookupCombineFlag( ply:CombineFlag() ).CanEditCPs ) then return end
	
	local steam = net.ReadString();
	local targ = nil;
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v:SteamID() == steam ) then
			
			targ = v;
			
		end
		
	end
	
	if( targ and targ:IsValid() ) then
		
		local f = v:CombineFlag();
		
		if( GAMEMODE:LookupCombineFlag( f ).PromoteTo ) then
			
			local nr = GAMEMODE:LookupCombineFlag( f ).PromoteTo;
			
			targ:SetCombineFlag( nr );
			
			if( targ:ActiveFlag() != nr ) then
				
				targ:SetActiveFlag( nr );
				GAMEMODE:PlayerCheckFlag( targ );
				
			end
			
			targ:UpdateCharacterField( "CombineFlag", targ:CombineFlag() );
			
			net.Start( "nCombinePromoted" );
			net.Send( targ );
			
			net.Start( "nRefreshSqL" );
			net.Broadcast();
			
			GAMEMODE:LogCombine( "[P] " .. ply:VisibleRPName() .. " promoted character " .. targ:VisibleRPName() .. ".", ply );
			
			net.Start( "nRefreshCombinePromotions" );
			net.Broadcast();
			
		end
		
	end
	
end
net.Receive( "nPromoteRecruit", nPromoteRecruit );

function nDemoteUnit( len, ply )
	
	if( !GAMEMODE:LookupCombineFlag( ply:CombineFlag() ).CanEditCPs ) then return end
	
	local steam = net.ReadString();
	local targ = nil;
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v:SteamID() == steam ) then
			
			targ = v;
			
		end
		
	end
	
	if( targ and targ:IsValid() ) then
		
		local f = v:CombineFlag();
		
		if( GAMEMODE:LookupCombineFlag( f ).DemoteTo ) then
			
			local nr = GAMEMODE:LookupCombineFlag( f ).DemoteTo;
			
			targ:SetCombineFlag( nr );
			
			if( targ:ActiveFlag() != nr ) then
				
				targ:SetActiveFlag( nr );
				GAMEMODE:PlayerCheckFlag( targ );
				
			end
			
			targ:UpdateCharacterField( "CombineFlag", targ:CombineFlag() );
			
			net.Start( "nCombineDemoted" );
			net.Send( targ );
			
			net.Start( "nRefreshSqL" );
			net.Broadcast();
			
			GAMEMODE:LogCombine( "[D] " .. ply:VisibleRPName() .. " demoted character " .. targ:VisibleRPName() .. " (" .. targ:VisibleRPName() .. ").", ply );
			
			net.Start( "nRefreshCombinePromotions" );
			net.Broadcast();
			
		end
		
	end
	
end
net.Receive( "nDemoteUnit", nDemoteUnit );

function nDropRation( len, ply )
	
	if( GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ) ) then
		
		if( !GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ).CanSpawn ) then return end
		
		if( GAMEMODE:Rations() > 0 ) then
			
			GAMEMODE:SetRations( GAMEMODE:Rations() - 1 );
			
			GAMEMODE:CreateItem( ply, "ration" );
			
			GAMEMODE:LogCombine( "[R] " .. ply:VisibleRPName() .. " dropped a ration.", ply );
			
		end
		
	end
	
end
net.Receive( "nDropRation", nDropRation );

function nDropPoster( len, ply )
	
	if( GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ) ) then
		
		if( !GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ).CanSpawn ) then return end
		
		if( GAMEMODE:Posters() > 0 ) then
			
			GAMEMODE:SetPosters( GAMEMODE:Posters() - 1 );
			
			GAMEMODE:CreateItem( ply, "poster" );
			
			GAMEMODE:LogCombine( "[P] " .. ply:VisibleRPName() .. " dropped a poster.", ply );
			
		end
		
	end
	
end
net.Receive( "nDropPoster", nDropPoster );

function nCPGetRosterList( len, ply )
	
	if( !GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ) ) then return end
	
	local function qS( ret )
		
		local tab = { };
		
		for _, v in pairs( ret ) do
			
			local rpname = v.RPName;
			local squad = v.CombineSquad;
			local squadid = tonumber( v.CombineSquadID );
			local cid = GAMEMODE:FormatCID( v.CID );
			local cpflag = v.CombineFlag;
			local lastonline = util.TimeSinceDate( v.LastOnline );
			local charid = v.id;
			
			if( lastonline == 0 ) then
				
				lastonline = "";
				
			else
				
				if( lastonline < 24 * 60 ) then
					
					lastonline = math.floor( lastonline / 60 ) .. " hours";
					
				else
					
					lastonline = math.floor( ( lastonline / 60 ) / 24 ) .. " days";
					
				end
				
			end
			
			table.insert( tab, { rpname, squad, squadid, cid, cpflag, lastonline, charid, util.TimeSinceDate( v.LastOnline ) } );
			
		end
		
		net.Start( "nCPRosterList" );
			net.WriteTable( tab );
		net.Send( ply );
		
		GAMEMODE:LogSQL( "Player " .. ply:Nick() .. " retrieved Combine roster." );
		
	end
	
	mysqloo.Query( "SELECT id, RPName, CombineSquad, CombineSquadID, CID, CombineFlag, LastOnline FROM cc_chars WHERE CombineFlag != ''", qS );
	
end
net.Receive( "nCPGetRosterList", nCPGetRosterList );

function nSetSquad( len, ply )
	
	if( !GAMEMODE:LookupCombineFlag( ply:CombineFlag() ).CanEditCPs ) then return end
	
	local targ = net.ReadEntity();
	local squad = net.ReadString();
	
	if( targ and targ:IsValid() and targ:HasAnyCombineFlag() and !GAMEMODE:LookupCombineFlag( targ:CombineFlag() ).CanEditCPs ) then
		
		GAMEMODE:LogCombine( "[S] " .. ply:VisibleRPName() .. " set " .. targ:VisibleRPName() .. "'s squad to " .. squad .. ".", ply );
		
		targ:SetCombineSquad( squad );
		targ:UpdateCharacterField( "CombineSquad", squad );
		
	end
	
end
net.Receive( "nSetSquad", nSetSquad );

function nSetSquadID( len, ply )
	
	if( !GAMEMODE:LookupCombineFlag( ply:CombineFlag() ).CanEditCPs ) then return end
	
	local targ = net.ReadEntity();
	local squadid = net.ReadUInt( 5 );
	
	if( targ and targ:IsValid() and targ:HasAnyCombineFlag() and !GAMEMODE:LookupCombineFlag( targ:CombineFlag() ).CanEditCPs ) then
		
		GAMEMODE:LogCombine( "[S] " .. ply:VisibleRPName() .. " set " .. targ:VisibleRPName() .. "'s squad ID to " .. squadid .. ".", ply );
		
		targ:SetCombineSquadID( squadid );
		targ:UpdateCharacterField( "CombineSquadID", squadid );
		
	end
	
end
net.Receive( "nSetSquadID", nSetSquadID );

function nUpdateRecord( len, ply )
	
	if( !GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ) ) then return end
	
	local text = net.ReadString();
	local targ = net.ReadEntity();
	
	text = string.sub( string.Trim( text ), 1, 1024 );
	
	GAMEMODE:LogCombine( "[C] " .. ply:VisibleRPName() .. " set " .. targ:VisibleRPName() .. "'s criminal record to \"" .. text .. "\".", ply );
	
	targ:SetCriminalRecord( text );
	targ:UpdateCharacterField( "CriminalRecord", text );
	
end
net.Receive( "nUpdateRecord", nUpdateRecord );

function nAddPrison( len, ply )
	
	if( !GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ) ) then return end
	
	local targ = net.ReadEntity();
	local duration = net.ReadUInt( 4 ) * 60;
	local reason = net.ReadString();
	
	if( duration < 1 * 60 or duration > 10 * 60 or string.len( reason ) > 100 ) then return end
	
	GAMEMODE:LogCombine( "[P] " .. ply:VisibleRPName() .. " imprisoned " .. targ:VisibleRPName() .. " for " .. string.ToMinutesSeconds( duration ) .. " (\"" .. reason .. "\").", ply );
	
	targ:SetPrisonReason( reason );
	targ:SetPrisonReleaseTime( CurTime() + duration );
	targ:SetPrisonNotified( 2 );
	targ:SetArrester( ply:VisibleRPName() );
	
end
net.Receive( "nAddPrison", nAddPrison );

function nRemovePrison( len, ply )
	
	if( !GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ) ) then return end
	
	local targ = net.ReadEntity();
	
	GAMEMODE:LogCombine( "[P] " .. ply:VisibleRPName() .. " released " .. targ:VisibleRPName() .. ".", ply );
	
	targ:SetPrisonReason( "" );
	targ:SetPrisonReleaseTime( 0 );
	targ:SetArrester( "" );
	
end
net.Receive( "nRemovePrison", nRemovePrison );

function GM:PrisonThink( ply )
	
	if( ply:PrisonNotified() == 2 and ply:PrisonReleaseTime() > 0 and math.ceil( ply:PrisonReleaseTime() - CurTime() ) <= 30 ) then
		
		ply:SetPrisonNotified( 1 );
		
		local rf = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:HasAnyCombineFlag() ) then
				
				table.insert( rf, v );
				
			end
			
		end
		
		net.Start( "nPrisonNotify30" );
			net.WriteEntity( ply );
		net.Send( rf );
		
	end
	
	if( ply:PrisonNotified() == 1 and ply:PrisonReleaseTime() > 0 and math.ceil( ply:PrisonReleaseTime() - CurTime() ) <= 0 ) then
		
		ply:SetPrisonNotified( 0 );
		
		local rf = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:HasAnyCombineFlag() ) then
				
				table.insert( rf, v );
				
			end
			
		end
		
		net.Start( "nPrisonNotify" );
			net.WriteEntity( ply );
		net.Send( rf );
		
	end
	
end

function nCPPK( len, ply )
	
	local cid = net.ReadUInt( 32 );
	local name = net.ReadString();
	
	if( GAMEMODE:LookupCombineFlag( ply:CombineFlag() ).CanEditCPs ) then
		
		GAMEMODE:DeleteCharacter( cid, ply:RPName(), name );
		
	end
	
end
net.Receive( "nCPPK", nCPPK );

function GM:PlayerButtonDown( ply, button )
	
	if( SERVER ) then
		
		ply.AFKTime = CurTime();
		
	end
	
	self.BaseClass:PlayerButtonDown( ply, button );
	
end

function GM:AFKThink( ply )
	
	if( self.AFKKickerEnabled and CurTime() - ply.AFKTime > self.AFKTime and ( #player.GetAll() / game.MaxPlayers() ) > self.AFKPercentage and ply:DonationAmount() == 0 and !ply:IsAdmin() and !ply:IsEventCoordinator() ) then
		
		ply:Kick( "Auto-kicked for being AFK" );
		
	end
	
end

function GM:APCThink( ply )
	
	if( ply:APC() and ply:APC():IsValid() ) then
		
		ply:SetPos( ply:APC():GetPos() );
		
	end
	
end

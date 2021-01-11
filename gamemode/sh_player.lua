local meta = FindMetaTable( "Player" );

GM.PlayerAccessors = {
	{ "ToolTrust", 			false, 	"UInt", 	0, 3 },
	{ "PhysTrust", 			false, 	"UInt", 	1, 1 },
	{ "PropTrust", 			false, 	"UInt", 	1, 1 },
	{ "NewbieStatus", 		false, 	"UInt", 	NEWBIE_STATUS_NEW, 1 },
	{ "CustomMaxProps", 	true, 	"UInt", 	0, 16 },
	{ "CustomMaxRagdolls", 	true, 	"UInt", 	0, 16 },
	{ "CharID", 			false, 	"Int", 		-1, 32 },
	{ "RPName", 			false, 	"String", 	"Unconnected" },
	{ "Description",		false, 	"String", 	"" },
	{ "Holstered", 			false, 	"Bit", 		true },
	{ "CID", 				false, 	"UInt", 	0, 17 },
	{ "Money", 				true, 	"UInt", 	0, 32 },
	{ "Trait", 				false, 	"UInt", 	TRAIT_NONE, 32 },
	{ "CombineFlag", 		false, 	"String", 	"" },
	{ "CombineSquad",		false,	"String",	"" },
	{ "CombineSquadID",		false,	"UInt",		0, 8 },
	{ "ActiveFlag", 		false, 	"String", 	"" },
	{ "CharFlags", 			false, 	"String", 	"" },
	{ "Loan", 				false, 	"UInt", 	0, 32 },
	{ "Consciousness", 		true, 	"Float", 	100 },
	{ "PassedOut", 			false, 	"Bit", 		false },
	{ "RadioFreq", 			true, 	"Float", 	0 },
	{ "Speed", 				false, 	"Float", 	0 },
	{ "Strength", 			false, 	"Float", 	0 },
	{ "Toughness", 			false, 	"Float", 	0 },
	{ "Perception", 		false, 	"Float", 	0 },
	{ "Agility", 			false, 	"Float", 	0 },
	{ "Aim", 				false, 	"Float", 	0 },
	{ "TiedUp",				false,	"Bit",		false },
	{ "CharCreationDate",	true,	"String",	"" },
	{ "LastLegShot",		false,	"Float",	-20 },
	{ "InAttack2",			false,	"Bit",		false },
	{ "BusinessLicenses",	false,	"Float",	0 },
	{ "Typing",				false,	"UInt",		0, 3 },
	{ "CombineAppStatus",	true,	"UInt",		CPAPP_NONE, 3 },
	{ "CombineAppDate",		true,	"String",	"" },
	{ "MountedGun",			false,	"Entity",	NULL },
	{ "ScoreboardTitle",	false,	"String",	"" },
	{ "ScoreboardTitleC",	false,	"Vector",	Vector( 200, 200, 200 ) },
	{ "ScoreboardBadges",	false,	"Float",	0 },
	{ "DonationAmount",		false,	"Float",	0 },
	{ "CriminalRecord",		false,	"String",	"" },
	{ "PrisonReleaseTime",	false,	"Float",	0 },
	{ "PrisonReason",		false,	"String",	"" },
	{ "PrisonNotified",		false,	"Float",	0 },
	{ "Arrester",			false,	"String",	"" },
	{ "PropProtection",		true,	"Table",	{ } },
	{ "Bottify",			false,	"Bit",		false },
	{ "RagdollIndex",		false,	"Int",		-1, 16 },
	{ "HideAdmin",			false,	"Bit",		false },
	{ "Hunger",				false,	"Float",	0 },
	{ "CPRationDate",		true,	"String",	"" },
	{ "APC",				true,	"Entity",	NULL },
};

for k, v in pairs( GM.PlayerAccessors ) do
	
	meta["Set" .. v[1]] = function( self, val, force )
		
		if( val == nil ) then return end
		
		if( SERVER ) then
			
			if( self[v[1] .. "Val"] == val and v[3] != "Table" and !force ) then return end
			
			self[v[1] .. "Val"] = val;
			
			if( v[2] ) then -- private
				
				if( self:IsBot() ) then return end
				
				net.Start( "nSet" .. v[1] );
					if( v[3] == "UInt" or v[3] == "Int" ) then
						net["Write" .. v[3]]( val, v[5] );
					else
						net["Write" .. v[3]]( val );
					end
				net.Send( self );
				
			else
				
				net.Start( "nSet" .. v[1] );
					net.WriteEntity( self );
					if( v[3] == "UInt" or v[3] == "Int" ) then
						net["Write" .. v[3]]( val, v[5] );
					else
						net["Write" .. v[3]]( val );
					end
				net.Broadcast();
				
			end
			
		else -- We're going to ATTEMPT to predict this...
			
			self[v[1] .. "Val"] = val;
			
		end
		
	end
	
	meta[v[1]] = function( self )
		
		if( self[v[1] .. "Val"] == nil ) then
			return v[4];
		end
		
		if( self[v[1] .. "Val"] == false ) then
			
			return false;
			
		end
		
		return self[v[1] .. "Val"];
		
	end
	
	if( SERVER ) then
		
		util.AddNetworkString( "nSet" .. v[1] );
		
	else
		
		local function nRecvData( len )
			
			if( v[2] ) then -- private
				
				local val;
				if( v[3] == "UInt" or v[3] == "Int" ) then
					val = net["Read" .. v[3]]( v[5] );
				else
					val = net["Read" .. v[3]]();
				end
				
				if( v[3] == "Bit" ) then
					val = tobool( val );
				end
				
				LocalPlayer()[v[1] .. "Val"] = val;
				
			else
				
				local ply = net.ReadEntity();

				local val;
				if( v[3] == "UInt" or v[3] == "Int" ) then
					val = net["Read" .. v[3]]( v[5] );
				else
					val = net["Read" .. v[3]]();
				end
				
				if( v[3] == "Bit" ) then
					val = tobool( val );
				end
				
				ply[v[1] .. "Val"] = val;
				
			end
			
		end
		net.Receive( "nSet" .. v[1], nRecvData );
		
	end
	
end

function meta:SyncAllData( ply )
	
	for _, n in pairs( GAMEMODE.PlayerAccessors ) do
		
		if( !n[2] ) then
			
			net.Start( "nSet" .. n[1] );
				net.WriteEntity( self );
				if( n[3] == "UInt" or n[3] == "Int" ) then
					net["Write" .. n[3]]( self[n[1]]( self ), n[5] );
				else
					net["Write" .. n[3]]( self[n[1]]( self ) );
				end
			if( ply ) then
				net.Send( ply );
			else
				net.Broadcast();
			end
			
		end
		
	end
	
end

function meta:SyncAllOtherData()
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v != self ) then
			
			for _, n in pairs( GAMEMODE.PlayerAccessors ) do
				
				if( !n[2] ) then
					
					net.Start( "nSet" .. n[1] );
						net.WriteEntity( v );
						if( n[3] == "UInt" or n[3] == "Int" ) then
							net["Write" .. n[3]]( v[n[1]]( v ), n[5] );
						else
							net["Write" .. n[3]]( v[n[1]]( v ) );
						end
					net.Send( self );
					
				end
				
			end
			
		end
		
	end
	
end

function nRequestPlayerData( len, ply )
	
	if( CLIENT ) then return end
	
	local ent = net.ReadEntity();
	
	ent:SyncAllData( ply );
	
end
net.Receive( "nRequestPlayerData", nRequestPlayerData );

function nRequestAllPlayerData( len, ply )
	
	if( CLIENT ) then return end
	
	if( !ply.NextSyncPlayerData ) then ply.NextSyncPlayerData = 0 end
	
	if( CurTime() < ply.NextSyncPlayerData ) then return end
	
	ply.NextSyncPlayerData = CurTime() + 1;
	
	ply:SyncAllOtherData();
	
end
net.Receive( "nRequestAllPlayerData", nRequestAllPlayerData );

function GM:FormatCID( cid )
	
	local l = string.len( cid );
	
	if( l <= 0 ) then
		
		return "00000";
		
	elseif( l == 1 ) then
		
		return "0000" .. cid;
		
	elseif( l == 2 ) then
		
		return "000" .. cid;
		
	elseif( l == 3 ) then
		
		return "00" .. cid;
		
	elseif( l == 4 ) then
		
		return "0" .. cid;
		
	end
	
	return cid;
	
end

function meta:FormattedCID()
	
	local cid = tostring( self:CID() );
	return GAMEMODE:FormatCID( cid );
	
end

function meta:AddMoney( money )
	
	if( CLIENT ) then return end
	
	self:SetMoney( math.floor( self:Money() + money ) );
	
end

function GM:FreezePlayer( ply, time )
	
	ply.FreezeTime = math.max( ply.FreezeTime or 0, CurTime() + time );
	
end

function GM:Move( ply, move )
	
	if( ply.FreezeTime and CurTime() < ply.FreezeTime ) then
		
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
		move:SetVelocity( Vector() );
		
	end
	
	if( ply:PassedOut() ) then
		
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
		move:SetVelocity( Vector() );
		
	end
	
	if( ply:MountedGun() and ply:MountedGun():IsValid() ) then
		
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
		move:SetVelocity( Vector() );
		
	end
	
	if( ply:APC() and ply:APC():IsValid() ) then
		
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
		move:SetVelocity( Vector() );
		
	end
	
	return self.BaseClass:Move( ply, move );
	
end

function GM:SetupMove( ply, move )
	
	if( ply.FreezeTime and CurTime() < ply.FreezeTime ) then
		
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
		move:SetVelocity( Vector() );
		
	end
	
	if( ply:PassedOut() ) then
		
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
		move:SetVelocity( Vector() );
		
	end
	
	if( ply:MountedGun() and ply:MountedGun():IsValid() ) then
		
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
		move:SetVelocity( Vector() );
		
	end
	
	if( ply:APC() and ply:APC():IsValid() ) then
		
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
		move:SetVelocity( Vector() );
		
	end
	
	if( SERVER and move:KeyPressed( IN_JUMP ) ) then
		
		if( ply:OnGround() ) then
			
			if( !ply.NextAgility ) then ply.NextAgility = CurTime(); end
			
			if( !ply:OnGround() and !ply:IsEFlagSet( EFL_NOCLIP_ACTIVE ) and CurTime() >= ply.NextAgility ) then
				
				ply.NextAgility = CurTime() + 10;
				
				ply:SetAgility( math.Clamp( ply:Agility() + GAMEMODE:ScaledStatIncrease( ply, ply:Agility() ) * 0.1, 0, 100 ) );
				ply:UpdateCharacterField( "StatAgility", tostring( ply:Agility() ), true );
				
			end
			
		end
		
	end
	
	return self.BaseClass:SetupMove( ply, move );
	
end

GM.BotDeadRemarks = {
	"gordead_ques01",
	"gordead_ques02",
	"gordead_ques06",
	"gordead_ques07",
	"gordead_ques10",
	"gordead_ques11",
	"gordead_ques14",
	"gordead_ans01",
	"gordead_ans02",
	"gordead_ans03",
	"gordead_ans04",
	"gordead_ans05",
	"gordead_ans07",
	"gordead_ans10",
	"gordead_ans14",
	"gordead_ans19",
};

GM.BotTargetedSounds = {
	"excuseme01",
	"excuseme02",
	"pardonme01",
	"pardonme02",
};

function meta:Ragdoll()
	
	if( self:RagdollIndex() == -1 ) then return NULL end
	
	return ents.GetByIndex( self:RagdollIndex() );
	
end

function meta:SetRagdoll( ent )
	
	self:SetRagdollIndex( ent:EntIndex() );
	
end

GM.BotIdleSounds = {
	"doingsomething",
	"getgoingsoon",
	"question02",
	"question04",
	"question05",
	"question06",
	"question07",
	"question09",
	"question11",
	"question12",
	"question13",
	"question15",
	"question16",
	"question17",
	"question18",
	"question19",
	"question20",
	"question22",
	"question23",
	"question25",
	"question27",
	"question28",
	"question29",
	"question30",
}

function GM:StartCommand( bot, cmd )
	
	if( !bot:IsBot() and !bot:Bottify() ) then return end
	
	if( !bot.AI ) then bot.AI = { } end
	
	if( !bot.AI.Next ) then bot.AI.Next = CurTime() end
	
	cmd:ClearButtons();
	cmd:ClearMovement();
	cmd:SetViewAngles( bot:EyeAngles() );
	
	if( !bot:Alive() ) then
		
		cmd:SetButtons( IN_JUMP );
		bot.AI.Next = CurTime() + 3;
		bot.AI.Target = nil;
		return;
		
	end
	
	if( bot:PassedOut() ) then
		
		bot.AI.Next = CurTime() + 3;
		bot.AI.Target = nil;
		return;
		
	end
	
	if( bot.AI.Target and bot.AI.Target:IsValid() ) then
		
		if( !bot.AI.Target:Alive() ) then
			
			bot.AI.Target = nil;
			bot.AI.Next = CurTime() + 4;
			
			local gender = ( bot:Gender() == GENDER_FEMALE ) and "female" or "male";
			local remark = table.Random( self.BotDeadRemarks );
			bot:EmitSound( Sound( "*vo/npc/" .. gender .. "01/" .. remark .. ".wav" ), 80 );
			
			return;
			
		end
		
		if( bot.AI.Target:InVehicle() or bot.AI.Target:GetNoDraw() ) then
			
			bot.AI.Target = nil;
			return;
			
		end
		
	end
	
	if( !bot.AI.Target or !bot.AI.Target:IsValid() ) then
		
		local dist = 400;
		local closest = nil;
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v != bot and v:Alive() and !v:InVehicle() and !v:GetNoDraw() ) then
				
				if( bot:CanSee( v ) ) then
					
					local d = v:GetPos():Distance( bot:GetPos() );
					
					if( d < dist ) then
						
						dist = d;
						closest = v;
						
					end
					
				end
				
			end
			
		end
		
		if( closest and closest:IsValid() ) then
			
			bot.AI.Target = closest;
			
			local gender = ( bot:Gender() == GENDER_FEMALE ) and "female" or "male";
			local remark = table.Random( self.BotTargetedSounds );
			bot:EmitSound( Sound( "*vo/npc/" .. gender .. "01/" .. remark .. ".wav" ), 80 );
			return;
			
		end
		
	end
	
	if( !bot.AI.Target or !bot.AI.Target:IsValid() ) then return end
	
	local eyeang = ( bot.AI.Target:EyePos() - bot:EyePos() ):GetNormal():Angle();
	
	eyeang.p = math.NormalizeAngle( eyeang.p );
	eyeang.y = math.NormalizeAngle( eyeang.y );
	eyeang.r = math.NormalizeAngle( eyeang.r );
	
	local dist = bot:GetPos():Distance( bot.AI.Target:GetPos() );
	
	if( dist > 200 ) then
		
		cmd:SetButtons( bit.bor( cmd:GetButtons(), IN_SPEED ) );
		
	end
	
	if( bot:Gender() != GENDER_FEMALE and bot.AI.Target:Gender() == GENDER_FEMALE ) then
		
		cmd:SetForwardMove( bot:GetMaxSpeed() );
		
	else
		
		if( dist > 50 ) then
			
			cmd:SetForwardMove( bot:GetMaxSpeed() );
			
		end
		
	end
	
	if( CurTime() >= bot.AI.Next ) then
		
		if( dist <= 50 ) then
			
			if( bot:Gender() != GENDER_FEMALE and bot.AI.Target:Gender() == GENDER_FEMALE ) then
				
				bot:EmitSound( Sound( "vo/npc/male01/hi0" .. math.random( 1, 2 ) .. ".wav" ), 80 );
				bot.AI.Next = CurTime() + 0.2;
				
			else
				
				if( math.random( 1, 3 ) == 1 ) then
					
					local gender = ( bot:Gender() == GENDER_FEMALE ) and "female" or "male";
					local remark = table.Random( self.BotIdleSounds );
					bot:EmitSound( Sound( "*vo/npc/" .. gender .. "01/" .. remark .. ".wav" ), 80 );
					
				end
				
				bot.AI.Next = CurTime() + math.random( 20, 30 );
				
			end
			
			return;
			
		end
		
		bot.AI.Next = CurTime() + 0.1;
		
	end
	
	cmd:SetViewAngles( eyeang );
	bot:SetEyeAngles( eyeang );
	
end

function meta:HasPlayerModel()
	
	if( string.find( string.lower( self:GetModel() ), "/player/" ) ) then
		
		return true;
		
	end
	
	return false;
	
end

function meta:HasVortigauntModel()
	
	if( self:GetModel() == "models/vortigaunt.mdl" or self:GetModel() == "models/vortigaunt_slave.mdl" or self:GetModel() == "models/vortigaunt_doctor.mdl" ) then
		
		return true;
		
	end
	
	return false;
	
end

function meta:HasBadge( b )
	
	if( bit.band( self:ScoreboardBadges(), b ) == b ) then return true end
	return false;
	
end

function GM:PlayerFootstep( ply, pos, foot, s, vol, rf )
	
	if( ply:GetModel() == "models/player/police.mdl" or ply:GetModel() == "models/player/police_fem.mdl" ) then
		
		if( ply:GetVelocity():Length2D() > 150 ) then
			if( foot == 0 ) then
				ply:EmitSound( "NPC_MetroPolice.RunFootstepLeft" );
			else
				ply:EmitSound( "NPC_MetroPolice.RunFootstepRight" );
			end
		else
			if( foot == 0 ) then
				ply:EmitSound( "NPC_MetroPolice.FootstepLeft" );
			else
				ply:EmitSound( "NPC_MetroPolice.FootstepRight" );
			end
		end
		
		return;
		
	end
	
	if( ply:HasVortigauntModel() ) then
		
		if( foot == 0 ) then
			ply:EmitSound( "NPC_Vortigaunt.FootstepLeft" );
		else
			ply:EmitSound( "NPC_Vortigaunt.FootstepRight" );
		end
		
		return;
		
	end
	
	if( ply:GetModel() == "models/stalker.mdl" ) then
		
		if( foot == 0 ) then
			ply:EmitSound( "NPC_Stalker.FootstepLeft" );
		else
			ply:EmitSound( "NPC_Stalker.FootstepRight" );
		end
		
		return;
		
	end
	
	if( ply:GetModel() == "models/zombie/classic.mdl" ) then
		
		if( foot == 0 ) then
			ply:EmitSound( "Zombie.FootstepLeft" );
		else
			ply:EmitSound( "Zombie.FootstepRight" );
		end
		
		return;
		
	end
	
	if( ply:GetModel() == "models/zombie/fast.mdl" ) then
		
		if( foot == 0 ) then
			ply:EmitSound( "NPC_FastZombie.FootstepLeft" );
		else
			ply:EmitSound( "NPC_FastZombie.FootstepRight" );
		end
		
		return;
		
	end
	
	if( ply:GetModel() == "models/zombie/poison.mdl" ) then
		
		if( foot == 0 ) then
			ply:EmitSound( "NPC_PoisonZombie.FootstepLeft" );
		else
			ply:EmitSound( "NPC_PoisonZombie.FootstepRight" );
		end
		
		return;
		
	end
	
	if( ply:GetModel() == "models/headcrabclassic.mdl" or ply:GetModel() == "models/lamarr.mdl" ) then
		
		ply:EmitSound( "NPC_Headcrab.Footstep" );
		
		return;
		
	end
	
	if( ply:GetModel() == "models/headcrab.mdl" ) then
		
		ply:EmitSound( "NPC_FastHeadcrab.Footstep" );
		
		return;
		
	end
	
	if( ply:GetModel() == "models/headcrabblack.mdl" ) then
		
		ply:EmitSound( "NPC_BlackHeadcrab.Footstep" );
		
		return;
		
	end
	
	if( ply:GetModel() == "models/antlion.mdl" ) then
		
		ply:EmitSound( "NPC_Antlion.Footstep" );
		
		return;
		
	end
	
	if( ply:GetModel() == "models/antlion_guard.mdl" ) then
		
		ply:EmitSound( "NPC_AntlionGuard.StepHeavy" );
		
		return;
		
	end
	
	self.BaseClass:PlayerFootstep( ply, pos, foot, s, vol, rf );
	
end

function meta:GetSpeeds()
	
	local w = 90;
	local r = 150 + self:Speed() * 0.7;
	local j = 160 + self:Agility() * 0.5;
	local c = 90;
	
	if( self:HasTrait( TRAIT_MULE ) ) then
		
		r = 130 + self:Speed() * 0.7;
		
	end
	
	r = r * ( 1 - ( self:Hunger() / 100 ) / 4 );
	j = j * ( 1 - ( self:Hunger() / 100 ) / 4 );
	
	if( self:LastLegShot() > 0 and !self:HasDrug( DRUG_ANTLION ) ) then
		
		local d = CurTime() - self:LastLegShot();
		
		local b = 15 - ( self:Toughness() / 100 * 15 );
		b = b + ( self:Hunger() / 100 ) * 10;
		
		if( d < b ) then
			
			r = 90;
			j = 0;
			
		elseif( d < b + 5 ) then
			
			local perc = ( d - b ) / 5;
			
			r = 90 + ( 60 + self:Speed() * 0.7 ) * perc;
			j = ( 160 + self:Agility() * 0.5 ) * perc;
			
		end
		
	end
	
	r = r * self:DrugSpeedMod();
	
	if( string.lower( self:GetModel() ) == "models/stalker.mdl" ) then
		
		w = 36.89;
		r = 36.89;
		c = 36.89;
		j = 0;
		return w, r, j, c;
		
	end
	
	if( self:InventoryWeight() > self:InventoryMaxWeight() ) then
		
		w = 40;
		r = 40;
		c = 40;
		
	end
	
	return w, r, j, c;
	
end

function player.GetCombine()
	
	local tab = { };
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v:HasAnyCombineFlag() ) then
			
			table.insert( tab, v );
			
		end
		
	end
	
	return tab;
	
end

function player.GetActiveCombine()
	
	local tab = { };
	
	for _, v in pairs( player.GetAll() ) do
		
		if( GAMEMODE:LookupCombineFlag( v:ActiveFlag() ) ) then
			
			table.insert( tab, v );
			
		end
		
	end
	
	return tab;
	
end

function player.GetByCharID( id )
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v:CharID() == id ) then
			
			return v;
			
		end
		
	end
	
end

function meta:HasCombineModel()
	
	if( string.find( string.lower( self:GetModel() ), "police" ) ) then return true end
	return false;
	
end

function meta:VisibleRPName()
	
	local flag = GAMEMODE:LookupCombineFlag( self:ActiveFlag() );
	
	if( flag ) then
		
		return GAMEMODE:CPName( self:RPName(), self:CombineSquad(), self:CombineSquadID(), self:FormattedCID(), flag );
		
	end
	
	return self:RPName();
	
end

function GM:CPName( name, squad, squadid, cid, flag )
	
	local nameformat = "$CID";
	if( flag and flag.CharName ) then
		nameformat = flag.CharName;
	end
	
	if( squad == "" ) then squad = "UNASSIGNED"; end
	
	nameformat = string.gsub( nameformat, "$SQUAD", squad );
	nameformat = string.gsub( nameformat, "$ID", squadid );
	nameformat = string.gsub( nameformat, "$CID", cid );
	
	return nameformat;
	
end

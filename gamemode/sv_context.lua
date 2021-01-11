function nCBuyDoor( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local ent = net.ReadEntity();
	
	if( ply:GetPos():Distance( ent:GetPos() ) > 128 ) then return end
	
	if( ent and ent:IsValid() and ent:IsDoor() and ( ent:DoorType() == DOOR_BUYABLE or ent:DoorType() == DOOR_BUYABLE_ASSIGNABLE ) and #ent:DoorOwners() == 0 and #ent:DoorAssignedOwners() == 0 and ply:CombineBuyDoors() ) then
		
		if( ply:Money() >= ent:DoorPrice() ) then
			
			ply:BuyDoor( ent );
			
		end
		
	end
	
end
net.Receive( "nCBuyDoor", nCBuyDoor );

function nCSellDoor( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local ent = net.ReadEntity();
	
	if( ply:GetPos():Distance( ent:GetPos() ) > 128 ) then return end
	
	if( ent and ent:IsValid() and ent:IsDoor() and ( ent:DoorType() == DOOR_BUYABLE or ent:DoorType() == DOOR_BUYABLE_ASSIGNABLE ) and table.HasValue( ent:DoorOwners(), ply:CharID() ) ) then
		
		ply:SellDoor( ent );
		
	end
	
end
net.Receive( "nCSellDoor", nCSellDoor );

function nCLockUnlock( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local ent = net.ReadEntity();
	
	if( ply:GetPos():Distance( ent:GetPos() ) > 128 ) then return end
	
	if( ent and ent:IsValid() and ent:IsDoor() and ply:CanLock( ent ) ) then
		
		if( ent:GetSaveTable().m_bLocked ) then
			
			ply:EmitSound( "doors/door_latch3.wav", 100, math.random( 90, 110 ) );
			ent:Fire( "Unlock" );
			
		else
			
			ply:EmitSound( "doors/door_locked2.wav", 100, math.random( 90, 110 ) );
			ent:Fire( "Lock" );
			
		end
		
	end
	
end
net.Receive( "nCLockUnlock", nCLockUnlock );

function nCNameDoor( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local ent = net.ReadEntity();
	local val = net.ReadString();
	
	if( ply:GetPos():Distance( ent:GetPos() ) > 128 ) then return end
	
	if( ent and ent:IsValid() and ent:IsDoor() and table.HasValue( ent:DoorOwners(), ply:CharID() ) ) then
		
		if( string.len( val ) <= 50 and string.len( val ) >= 1 ) then
			
			ent:SetDoorName( val );
			
		end
		
	end
	
end
net.Receive( "nCNameDoor", nCNameDoor );

function nCMakeOwner( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local ent = net.ReadEntity();
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( ent:GetPos() ) > 128 ) then return end
	
	if( ent and ent:IsValid() and ent:IsDoor() and table.HasValue( ent:DoorOwners(), ply:CharID() ) ) then
		
		if( targ and targ:IsValid() and !table.HasValue( ent:DoorOwners(), targ:CharID() ) and targ:CombineBuyDoors() ) then
			
			targ:AddDoorOwner( ent );
			
		end
		
	end
	
end
net.Receive( "nCMakeOwner", nCMakeOwner );

function nCRemoveOwner( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local ent = net.ReadEntity();
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( ent:GetPos() ) > 128 ) then return end
	
	if( ent and ent:IsValid() and ent:IsDoor() and table.HasValue( ent:DoorOwners(), ply:CharID() ) ) then
		
		if( targ and targ:IsValid() and table.HasValue( ent:DoorOwners(), targ:CharID() ) and targ:CombineBuyDoors() ) then
			
			targ:RemoveDoorOwner( ent );
			
		end
		
	end
	
end
net.Receive( "nCRemoveOwner", nCRemoveOwner );

function nCAssignOwner( len, ply )
	
	local ent = Entity( net.ReadUInt( 16 ) );
	local targ = net.ReadEntity();
	
	if( ent and ent:IsValid() and ent:IsDoor() and ent:DoorType() == DOOR_BUYABLE_ASSIGNABLE and ply:HasAnyCombineFlag() ) then
		
		if( targ and targ:IsValid() and !table.HasValue( ent:DoorAssignedOwners(), targ:CharID() ) and targ:CombineBuyDoors() ) then
			
			targ:AddDoorAssignedOwner( ent );
			
		end
		
	end
	
end
net.Receive( "nCAssignOwner", nCAssignOwner );

function nCUnassignOwner( len, ply )
	
	local ent = Entity( net.ReadUInt( 16 ) );
	local targ = net.ReadEntity();
	
	if( ent and ent:IsValid() and ent:IsDoor() and ent:DoorType() == DOOR_BUYABLE_ASSIGNABLE and ply:HasAnyCombineFlag() ) then
		
		if( targ and targ:IsValid() and table.HasValue( ent:DoorAssignedOwners(), targ:CharID() ) and targ:CombineBuyDoors() ) then
			
			targ:RemoveDoorAssignedOwner( ent );
			
		end
		
	end
	
end
net.Receive( "nCUnassignOwner", nCUnassignOwner );

function nCGiveCredits( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local amt = net.ReadUInt( 32 );
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( ply:Money() >= amt ) then
		
		ply:AddMoney( -amt );
		targ:AddMoney( amt );
		
		ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
		targ:UpdateCharacterField( "Money", tostring( targ:Money() ) );
		
		net.Start( "nCReceiveCredits" );
			net.WriteUInt( amt, 32 );
			net.WriteEntity( ply );
		net.Send( targ );
		
	end
	
end
net.Receive( "nCGiveCredits", nCGiveCredits );

function nCExamine( len, ply )
	
	if( !ply.NextExamine ) then ply.NextExamine = CurTime(); end
	
	if( CurTime() >= ply.NextExamine ) then
		
		ply.NextExamine = CurTime() + 10;
		
		ply:SetPerception( math.Clamp( ply:Perception() + GAMEMODE:ScaledStatIncrease( ply, ply:Perception() ) * 0.3, 0, 100 ) );
		ply:UpdateCharacterField( "StatPerception", tostring( ply:Perception() ), true );
		
	end
	
end
net.Receive( "nCExamine", nCExamine );

function nCPatDownStart( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	local mul = 1;
	
	if( ply:HasTrait( TRAIT_SPEEDY ) or targ:HasTrait( TRAIT_SPEEDY ) ) then
		
		mul = 0.5;
		
	end
	
	net.Start( "nCreateTimedProgressBar" );
		net.WriteFloat( 5 * mul );
		net.WriteString( "Being pat down..." );
		net.WriteEntity( ply );
	net.Send( targ );
	
end
net.Receive( "nCPatDownStart", nCPatDownStart );

function nCPatDown( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetVelocity():Length2D() <= 5 ) then
		
		local tab = { };
		
		for k, v in pairs( targ.Inventory ) do
			
			if( ( v == "radio" or v == "crdevice" ) and targ:HasTrait( TRAIT_SPY ) ) then
				
				if( !targ.NextTraitSpy ) then targ.NextTraitSpy = 0 end
				
				if( CurTime() >= targ.NextTraitSpy ) then
					
					targ.NextTraitSpy = CurTime() + 1200;
					
				else
					
					tab[k] = v;
					
				end
				
			else
				
				tab[k] = v;
				
			end
			
		end
		
		net.Start( "nCPattedDown" );
			net.WriteTable( tab );
		net.Send( ply );
		
	end
	
end
net.Receive( "nCPatDown", nCPatDown );

function nCTieUpStart( len, ply )
	
	if( !ply:HasItem( "zipties" ) ) then return end
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	net.Start( "nCreateTimedProgressBar" );
		net.WriteFloat( 5 );
		net.WriteString( "Being tied up..." );
		net.WriteEntity( ply );
	net.Send( targ );
	
end
net.Receive( "nCTieUpStart", nCTieUpStart );

function nCTieUp( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetVelocity():Length2D() <= 5 and ply:HasItem( "zipties" ) ) then
		
		targ:SetTiedUp( true );
		for _, v in pairs( GAMEMODE.HandsWeapons ) do
			
			if( targ:HasWeapon( v ) ) then
				
				targ:SelectWeapon( v );
				break;
				
			end
			
		end
		
	end
	
end
net.Receive( "nCTieUp", nCTieUp );

function nCUntieStart( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	net.Start( "nCreateTimedProgressBar" );
		net.WriteFloat( 2 );
		net.WriteString( "Being untied..." );
		net.WriteEntity( ply );
	net.Send( targ );
	
end
net.Receive( "nCUntieStart", nCUntieStart );

function nCUntie( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetVelocity():Length2D() <= 5 ) then
		
		targ:SetTiedUp( false );
		
	end
	
end
net.Receive( "nCUntie", nCUntie );

function nCSlitThroat( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 64 ) then return end
	
	if( targ:PassedOut() and ply:HasItem( "weapon_cc_knife" ) and targ:GetVelocity():Length2D() <= 5 ) then
		
		ply:SelectWeapon( "weapon_cc_knife" );
		ply:SetHolstered( false );
		
		ply:EmitSound( "Weapon_Knife.Hit" );
		
		local dmg = DamageInfo();
		dmg:SetAttacker( ply );
		dmg:SetDamage( 200 );
		dmg:SetDamageForce( Vector( 0, 0, 1 ) );
		dmg:SetDamagePosition( targ:GetPos() );
		dmg:SetDamageType( DMG_SLASH );
		dmg:SetInflictor( ply:GetWeapon( "weapon_cc_knife" ) );
		
		targ:TakeDamageInfo( dmg );
		
	end
	
end
net.Receive( "nCSlitThroat", nCSlitThroat );

function nCTakeRadio( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetClass() == "cc_radio" and ply:CharID() == targ:GetDeployer() ) then
		
		targ:Remove();
		ply:GiveItem( "bigradio" );
		
	end
	
end
net.Receive( "nCTakeRadio", nCTakeRadio );

function nCRadioChannel( len, ply )
	
	local targ = net.ReadEntity();
	local val = net.ReadFloat();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetClass() == "cc_radio" ) then
		
		if( val >= 0 ) then
			
			if( val <= 999 ) then
				
				targ:SetChannel( val );
				
			end
			
		end
		
	end
	
end
net.Receive( "nCRadioChannel", nCRadioChannel );

function nCTakeTurret( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	local flag = GAMEMODE:LookupCombineFlag( ply:CombineFlag() );
	
	if( flag and targ:GetClass() == "npc_turret_floor" ) then
		
		if( flag and table.HasValue( flag.ItemLoadout, "combineturret" ) ) then
			
			if( ply:CanTakeItem( "combineturret" ) ) then
				
				targ:Remove();
				ply:GiveItem( "combineturret" );
				
			end
			
		end
		
	end
	
end
net.Receive( "nCTakeTurret", nCTakeTurret );

function nCTakeTV( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetClass() == "cc_tv" and ply:CanTakeItem( "television" ) and ply:CharID() == targ:GetDeployer() ) then
		
		if( targ:GetBroken() ) then
			
			targ:Remove();
			ply:GiveItem( "brokentelevision" );
			
		else
			
			targ:Remove();
			ply:GiveItem( "television" );
			
		end
		
	end
	
end
net.Receive( "nCTakeTV", nCTakeTV );

function nCRepairTV( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetClass() == "cc_tv" and targ:GetBroken() and ply:HasItem( "scrapelectronics" ) ) then
		
		local perc = math.Clamp( ( ply:Perception() + ply:DrugPerceptionMod() ) / 100, 0, 100 );
		
		if( perc ) then
			
			local p = perc;
			
			if( ply:HasTrait( TRAIT_GREASE ) ) then
				
				p = p / 2;
				
			end
			
			if( math.random( 1, math.ceil( 1 / ( 1 - p ) + 0.01 ) ) == 1 ) then
				
				net.Start( "nCElectrocuteTV" );
				net.Send( ply );
				
				local dmg = DamageInfo();
				dmg:SetAttacker( targ );
				dmg:SetDamage( 20 );
				dmg:SetDamageForce( Vector() );
				dmg:SetDamagePosition( targ:GetPos() );
				dmg:SetInflictor( targ );
				
				ply:TakeDamageInfo( dmg );
				
				local spark = ents.Create( "env_spark" );
				spark:SetPos( targ:GetPos() );
				spark:Spawn();
				spark:Activate();
				spark:Fire( "SparkOnce" );
				spark:Fire( "Kill", "", 1 );
				
				return;
				
			end
			
			if( perc >= 0.2 ) then
				
				if( ply:HasTrait( TRAIT_GREASE ) ) then
					
					perc = perc / 2;
					
				end
				
				net.Start( "nCTVRepair" );
					net.WriteFloat( ( 1 - perc ) * 60 + 5 );
					net.WriteEntity( targ );
				net.Send( ply );
				
			else
				
				net.Start( "nCPercLevel" );
				net.Send( ply );
				
			end
			
		end
		
	end
	
end
net.Receive( "nCRepairTV", nCRepairTV );

function nCTVRepairDone( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetClass() == "cc_tv" and targ:GetBroken() and ply:HasItem( "scrapelectronics" ) ) then
		
		ply:RemoveItem( ply:GetInventoryItem( "scrapelectronics" ) );
		
		targ:SetBroken( false );
		targ.TVHealth = 20;
		
		targ:CreateMicrophone();
		
		ply:SetPerception( math.Clamp( ply:Perception() + GAMEMODE:ScaledStatIncrease( ply, ply:Perception() ), 0, 100 ) );
		ply:UpdateCharacterField( "StatPerception", tostring( ply:Perception() ), true );
		
	end
	
end
net.Receive( "nCTVRepairDone", nCTVRepairDone );

function nCTakeMicrowave( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetClass() == "cc_stove" and ply:CanTakeItem( "microwave" ) and ply:CharID() == targ:GetDeployer() ) then
		
		targ:Remove();
		ply:GiveItem( "microwave" );
		
	end
	
end
net.Receive( "nCTakeMicrowave", nCTakeMicrowave );

function nCRepairStove( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetClass() == "cc_stove" and targ:GetBroken() and ply:HasItem( "scrapelectronics" ) ) then
		
		local perc = math.Clamp( ( ply:Perception() + ply:DrugPerceptionMod() ) / 100, 0, 100 );
		
		if( perc >= 0.2 ) then
			
			if( ply:HasTrait( TRAIT_GREASE ) ) then
				
				perc = perc / 2;
				
			end
			
			net.Start( "nCStoveRepair" );
				net.WriteFloat( ( 1 - perc ) * 60 + 5 );
				net.WriteEntity( targ );
			net.Send( ply );
			
		else
			
			net.Start( "nCPercLevel" );
			net.Send( ply );
			
		end
		
	end
	
end
net.Receive( "nCRepairStove", nCRepairStove );

function nCStoveRepairDone( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetClass() == "cc_stove" and targ:GetBroken() and ply:HasItem( "scrapelectronics" ) ) then
		
		ply:RemoveItem( ply:GetInventoryItem( "scrapelectronics" ) );
		
		targ:SetBroken( false );
		
		ply:SetPerception( math.Clamp( ply:Perception() + GAMEMODE:ScaledStatIncrease( ply, ply:Perception() ), 0, 100 ) );
		ply:UpdateCharacterField( "StatPerception", tostring( ply:Perception() ), true );
		
	end
	
end
net.Receive( "nCStoveRepairDone", nCStoveRepairDone );
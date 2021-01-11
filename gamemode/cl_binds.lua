local meta = FindMetaTable( "Player" );

GM.MastermindBinds = {
	"+forward",
	"+back",
	"+moveright",
	"+moveleft",
	"+jump",
	"+duck",
	"+speed",
	"+use",
	"+attack",
	"+menu_context",
	"+menu",
	"noclip",
	"undo",
	"jpeg",
};

function GM:PlayerBindPress( ply, bind, down )
	
	if( down and !self.CharCreateOpened ) then
		
		return true;
		
	end
	
	if( down and self:InIntroCam() ) then
		
		return true;
		
	end
	
	if( down and self.CombineCameraView ) then
		
		if( bind != "messagemode" ) then
			
			self.CombineCameraView = nil;
			return true;
			
		end
		
	end
	
	if( down and string.find( bind, "messagemode" ) ) then
		
		self:CreateChatbox();
		return true;
		
	end
	
	if( down and string.find( bind, "showspare2" ) and LocalPlayer():IsAdmin() ) then
		
		self:CreateAdminMenu();
		return true;
		
	end
	
	if( down and self.Mastermind ) then
		
		if( !table.HasValue( self.MastermindBinds, bind ) ) then
			
			if( bind == "gm_showhelp" ) then
				
				self:CreateNPCModifierMenu();
				
			end
			
			if( bind == "gm_showteam" ) then
				
				self:CreateNPCCreatorMenu();
				
			end
			
			return true;
			
		end
		
	end
	
	if( down and string.find( bind, "showhelp" ) ) then
		
		self:CreateHelpMenu();
		return true;
		
	end
	
	if( down and string.find( bind, "showteam" ) ) then
		
		if( LocalPlayer():TiedUp() ) then
			
			self:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You can't switch characters while tied up.", { CB_ALL, CB_OOC } );
			return true;
			
		end
		
		if( table.Count( self.Characters ) >= self.MaxCharacters ) then
			self.CCMode = CC_SELECT_C;
		else
			self.CCMode = CC_CREATESELECT_C;
		end
		self:CreateCharEditor();
		
		return true;
		
	end
	
	if( down and string.find( bind, "showspare1" ) ) then
		
		self:CreatePlayerMenu();
		return true;
		
	end
	
	if( down and string.find( bind, "rp_toggleholster" ) and !input.IsKeyDown( KEY_B ) ) then
		
		if( LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon() != NULL ) then
			
			if( LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun" or
				LocalPlayer():GetActiveWeapon():GetClass() == "gmod_tool" or
				LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physcannon" or
				LocalPlayer():GetActiveWeapon():GetClass() == "weapon_cc_stalker" ) then
				
				return false;
				
			end
			
		end
		
		if( LocalPlayer():PassedOut() ) then return end
		if( LocalPlayer():TiedUp() ) then return end
		if( LocalPlayer():MountedGun() and LocalPlayer():MountedGun():IsValid() ) then return end
		
		net.Start( "nToggleHolster" );
		net.SendToServer();
		
		if( LocalPlayer():GetActiveWeapon() != NULL ) then
			
			if( LocalPlayer():GetActiveWeapon().Holsterable ) then
				
				LocalPlayer():SetHolstered( !LocalPlayer():Holstered() );
				
			else
				
				LocalPlayer():SetHolstered( false );
				
			end
			
		end
		
		return true;
		
	end
	
	if( down and string.find( bind, "+menu_context" ) ) then
		
		if( LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon():GetClass() != "gmod_tool" ) then
			
			if( self.Mastermind ) then
				
				gui.EnableScreenClicker( true );
				
			else
				
				local trace = { };
				trace.start = LocalPlayer():GetShootPos();
				trace.endpos = trace.start + LocalPlayer():GetAimVector() * 32768;
				trace.filter = LocalPlayer();
				local tr = util.TraceLine( trace );
				
				self:CreateCCContext( tr.Entity );
				gui.EnableScreenClicker( true );
				
			end
			
			return true;
			
		end
		
	end
	
	if( !down and string.find( bind, "+menu_context" ) ) then
		
		gui.EnableScreenClicker( false );
		self.MastermindSelected = nil;
		
		if( LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon() != NULL and LocalPlayer():GetActiveWeapon():GetClass() != "gmod_tool" ) then
			
			if( !self.Mastermind ) then
				
				self:RemoveCCContext();
				
			end
			
			return true;
			
		end
		
	end
	
	local b = 15 - ( ply:Toughness() / 100 * 15 );
	b = b + ( ply:Hunger() / 100 ) * 10;
	
	if( CurTime() - ply:LastLegShot() < b ) then
		
		if( down and string.find( bind, "+jump" ) and ply:GetMoveType() == 2 ) then
			
			return true;
			
		end
		
	end
	
	if( string.lower( ply:GetModel() ) == "models/stalker.mdl" ) then
		
		if( down and string.find( bind, "+jump" ) and ply:GetMoveType() == 2 ) then
			
			return true;
			
		end
		
		if( down and string.find( bind, "+duck" ) and ply:GetMoveType() == 2 ) then
			
			return true;
			
		end
		
	end
	
	if( ply.FreezeTime and CurTime() < ply.FreezeTime ) then
		
		if( down and string.find( bind, "+jump" ) ) then
			
			return true;
			
		end
		
		if( down and string.find( bind, "+duck" ) ) then
			
			return true;
			
		end
		
	end
	
	if( ply:MountedGun() and ply:MountedGun():IsValid() ) then
		
		if( down and string.find( bind, "+jump" ) ) then
			
			return true;
			
		end
		
		if( down and string.find( bind, "+duck" ) ) then
			
			return true;
			
		end
		
	end
	
	if( down and string.find( bind, "invnext" ) and !LocalPlayer():KeyDown( IN_ATTACK ) and !LocalPlayer():KeyDown( IN_ATTACK2 ) and !LocalPlayer():TiedUp() and !LocalPlayer():InVehicle() and LocalPlayer():Alive() ) then
		
		self:WeaponSelectScrollDown();
		return true;
		
	end
	
	if( down and string.find( bind, "invprev" ) and !LocalPlayer():KeyDown( IN_ATTACK ) and !LocalPlayer():KeyDown( IN_ATTACK2 ) and !LocalPlayer():TiedUp() and !LocalPlayer():InVehicle() and LocalPlayer():Alive() ) then
		
		self:WeaponSelectScrollUp();
		return true;
		
	end
	
	if( down and string.find( bind, "attack" ) and self:WeaponSelectOpen() and !LocalPlayer():KeyDown( IN_ATTACK ) and !LocalPlayer():KeyDown( IN_ATTACK2 ) and !LocalPlayer():TiedUp() and !LocalPlayer():InVehicle() and LocalPlayer():Alive() ) then
		
		self:WeaponSelectClick();
		return true;
		
	end
	
	if( down and string.find( bind, "slot" ) and !LocalPlayer():TiedUp() and !LocalPlayer():InVehicle() and LocalPlayer():Alive() ) then
		
		local a, _ = string.gsub( bind, "slot", "" );
		local n = tonumber( a );
		
		if( n == 1 or n == 2 or n == 3 ) then
			
			self:WeaponSelectNumber( n );
			
		end
		
		return true;
		
	end
	
	if( down and string.find( bind, "+attack" ) and LocalPlayer():TiedUp() ) then
		
		return true;
		
	end
	
	if( down and string.find( bind, "+reload" ) and LocalPlayer():TiedUp() ) then
		
		return true;
		
	end
	
end

function GM:ToggleHolsterThink()
	
	if( !self.ToggleHolsterPressed ) then self.ToggleHolsterPressed = false; end
	
	if( vgui.CursorVisible() ) then self.ToggleHolsterPressed = false; return end
	
	if( input.IsKeyDown( KEY_B ) and !self.ToggleHolsterPressed ) then
		
		self.ToggleHolsterPressed = true;
		
		if( LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon() != NULL ) then
			
			if( LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun" or
				LocalPlayer():GetActiveWeapon():GetClass() == "gmod_tool" or
				LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physcannon" or
				LocalPlayer():GetActiveWeapon():GetClass() == "weapon_cc_stalker" ) then
				
				return false;
				
			end
			
		end
		
		if( LocalPlayer():PassedOut() ) then return end
		if( LocalPlayer():TiedUp() ) then return end
		if( LocalPlayer():MountedGun() and LocalPlayer():MountedGun():IsValid() ) then return end
		
		net.Start( "nToggleHolster" );
		net.SendToServer();
		
		if( LocalPlayer():GetActiveWeapon() != NULL ) then
			
			if( LocalPlayer():GetActiveWeapon().Holsterable ) then
				
				LocalPlayer():SetHolstered( !LocalPlayer():Holstered() );
				
			else
				
				LocalPlayer():SetHolstered( false );
				
			end
			
		end
		
	elseif( !input.IsKeyDown( KEY_B ) and self.ToggleHolsterPressed ) then
		
		self.ToggleHolsterPressed = false;
		
	end
	
end
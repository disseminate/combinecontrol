GM.TimedProgressBars = { };

function GM:CreateTimedProgressBar( time, text, ply, cb )
	
	table.insert( self.TimedProgressBars, {
		Start = CurTime(),
		End = CurTime() + time,
		Text = text,
		Player = ply,
		CB = cb
	} );
	
end

function nCreateTimedProgressBar( len )
	
	local t = net.ReadFloat();
	local text = net.ReadString();
	local targ = net.ReadEntity();
	
	GAMEMODE:CreateTimedProgressBar( t, text, targ, function() end );
	
end
net.Receive( "nCreateTimedProgressBar", nCreateTimedProgressBar );

function nCReceiveCredits( len )
	
	local amt = net.ReadUInt( 32 );
	local ply = net.ReadEntity();
	
	GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", ply:VisibleRPName() .. " gave you " .. amt .. " credits.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nCReceiveCredits", nCReceiveCredits );

function nCElectrocuteTV( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You got an electric shock!", { CB_ALL, CB_IC } );
	
end
net.Receive( "nCElectrocuteTV", nCElectrocuteTV );

function nCPercLevel( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You take a look, and realize you can't figure this out. Maybe if you were more perceptive, you would have some idea of where to start.", { CB_ALL, CB_IC } );
	
end
net.Receive( "nCPercLevel", nCPercLevel );

function nCTVRepair( len )
	
	local time = net.ReadFloat();
	local ent = net.ReadEntity();
	
	GAMEMODE:CreateTimedProgressBar( time, "Repairing...", ent, function()
		
		if( !ent or !ent:IsValid() ) then return end
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You successfully repair the TV with the scrap electronics.", { CB_ALL, CB_IC } );
		
		net.Start( "nCTVRepairDone" );
			net.WriteEntity( ent );
		net.SendToServer();
		
	end );
	
end
net.Receive( "nCTVRepair", nCTVRepair );

function nCStoveRepair( len )
	
	local time = net.ReadFloat();
	local ent = net.ReadEntity();
	
	GAMEMODE:CreateTimedProgressBar( time, "Repairing...", ent, function()
		
		if( !ent or !ent:IsValid() ) then return end
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You successfully repair the stove with the scrap electronics.", { CB_ALL, CB_IC } );
		
		net.Start( "nCStoveRepairDone" );
			net.WriteEntity( ent );
		net.SendToServer();
		
	end );
	
end
net.Receive( "nCStoveRepair", nCStoveRepair );

function nUnownedStove( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You don't own this stove! It's rude to mess with other people's stuff.", { CB_ALL, CB_IC } );
	
end
net.Receive( "nUnownedStove", nUnownedStove );

function nCPattedDown( len )
	
	local inv = net.ReadTable();
	
	local panel = vgui.Create( "DFrame" );
	panel:SetSize( 800, 426 );
	panel:Center();
	panel:SetTitle( "Inventory" );
	panel.lblTitle:SetFont( "CombineControl.Window" );
	panel:MakePopup();
	panel.PerformLayout = CCFramePerformLayout;
	panel:PerformLayout();
	
	local model = vgui.Create( "DModelPanel", panel );
	model:SetPos( 420, 34 );
	model:SetModel( "" );
	model:SetSize( panel:GetWide() - 430, 200 );
	model:SetFOV( 20 );
	model:SetCamPos( Vector( 50, 50, 50 ) );
	model:SetLookAt( Vector( 0, 0, 0 ) );
	
	function model:LayoutEntity() end
	
	local p = model.Paint;
	
	function model:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 150 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
		p( self, w, h );
		
	end
	
	local title = vgui.Create( "DLabel", panel );
	title:SetText( "" );
	title:SetPos( 420, 244 );
	title:SetFont( "CombineControl.LabelGiant" );
	title:SetSize( panel:GetWide() - 430 - 110, 22 );
	title:PerformLayout();
	
	local desc = vgui.Create( "DLabel", panel );
	desc:SetText( "No item selected." );
	desc:SetPos( 420, 274 );
	desc:SetFont( "CombineControl.LabelSmall" );
	desc:SetSize( panel:GetWide() - 430, 14 );
	desc:SetAutoStretchVertical( true );
	desc:SetWrap( true );
	desc:PerformLayout();
	
	if( #inv == 0 ) then
		
		desc:SetText( "They don't have any items." );
		
	end
	
	local scroll = vgui.Create( "DScrollPanel", panel );
	scroll:SetPos( 10, 34 );
	scroll:SetSize( 400, panel:GetTall() - 50 );
	function scroll:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 150 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	local x = 0;
	local y = 0;
	
	for k, v in pairs( inv ) do
		
		local icon = vgui.Create( "DModelPanel", scroll );
		icon.Item = v;
		icon.InventoryID = k;
		
		icon:SetPos( x, y );
		icon:SetModel( GAMEMODE:GetItemByID( icon.Item ).Model );
		icon:SetSize( 48, 48 );
		
		if( GAMEMODE:GetItemByID( icon.Item ).LookAt ) then
			
			icon:SetFOV( GAMEMODE:GetItemByID( icon.Item ).FOV );
			icon:SetCamPos( GAMEMODE:GetItemByID( icon.Item ).CamPos );
			icon:SetLookAt( GAMEMODE:GetItemByID( icon.Item ).LookAt );
			
		else
			
			local a, b = icon.Entity:GetModelBounds();
			
			icon:SetFOV( 20 );
			icon:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
			icon:SetLookAt( ( a + b ) / 2 );
			
		end
		
		if( GAMEMODE:GetItemByID( icon.Item ).IconMaterial ) then icon.Entity:SetMaterial( GAMEMODE:GetItemByID( icon.Item ).IconMaterial ) end
		if( GAMEMODE:GetItemByID( icon.Item ).IconColor ) then icon.Entity:SetColor( GAMEMODE:GetItemByID( icon.Item ).IconColor ) end
		
		function icon:LayoutEntity() end
		
		x = x + 48 + 10;
		
		if( x > scroll:GetWide() - 48 ) then
			
			x = 0;
			y = y + 48 + 10;
			
		end
		
		local p = icon.Paint;
		
		function icon:Paint( w, h )
			
			local pnl = self:GetParent():GetParent();
			local x2, y2 = pnl:LocalToScreen( 0, 0 );
			local w2, h2 = pnl:GetSize();
			render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );
			
			p( self, w, h );
			
			render.SetScissorRect( 0, 0, 0, 0, false );
			
		end
		
		function icon:DoClick()
			
			if( model.Entity and model.Entity:IsValid() ) then
				
				model.Entity:SetMaterial( "" );
				model.Entity:SetColor( Color( 255, 255, 255, 255 ) );
				
			end
			
			model:SetModel( GAMEMODE:GetItemByID( self.Item ).Model );
			title:SetText( GAMEMODE:GetItemByID( self.Item ).Name );
			desc:SetText( GAMEMODE:GetItemByID( self.Item ).Description );
			
			if( GAMEMODE:GetItemByID( self.Item ).LookAt ) then
				
				model:SetFOV( GAMEMODE:GetItemByID( self.Item ).FOV );
				model:SetCamPos( GAMEMODE:GetItemByID( self.Item ).CamPos );
				model:SetLookAt( GAMEMODE:GetItemByID( self.Item ).LookAt );
				
			else
				
				local a, b = model.Entity:GetModelBounds();
				
				model:SetFOV( 20 );
				model:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
				model:SetLookAt( ( a + b ) / 2 );
				
			end
			
			if( GAMEMODE:GetItemByID( self.Item ).IconMaterial ) then model.Entity:SetMaterial( GAMEMODE:GetItemByID( self.Item ).IconMaterial ) end
			if( GAMEMODE:GetItemByID( self.Item ).IconColor ) then model.Entity:SetColor( GAMEMODE:GetItemByID( self.Item ).IconColor ) end
			
		end
		
	end
	
end
net.Receive( "nCPattedDown", nCPattedDown );

function GM:GetCCOptions( ent, dist )
	
	local tab = { };
	
	if( ent and ent:IsValid() and ent:GetClass() == "prop_ragdoll" ) then
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:Ragdoll() and v:Ragdoll():IsValid() and v:Ragdoll() == ent ) then
				
				ent = v;
				CCSelectedEnt = ent;
				
			end
			
		end
		
	end
	
	if( ent and ent:IsValid() ) then
		
		if( ent:IsDoor() ) then
			
			if( LocalPlayer():TiedUp() ) then return tab end
			if( LocalPlayer():PassedOut() ) then return tab end
			
			if( ( ent:DoorType() == DOOR_BUYABLE or ent:DoorType() == DOOR_BUYABLE_ASSIGNABLE ) and #ent:DoorOwners() == 0 and #ent:DoorAssignedOwners() == 0 and LocalPlayer():CombineBuyDoors() ) then
				
				local option = { "Buy", function()
					
					if( LocalPlayer():Money() >= ent:DoorPrice() ) then
						
						net.Start( "nCBuyDoor" );
							net.WriteEntity( ent );
						net.SendToServer();
						
					else
						
						self:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need more money to do that!", { CB_ALL, CB_IC } );
						
					end
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			elseif( ( ent:DoorType() == DOOR_BUYABLE or ent:DoorType() == DOOR_BUYABLE_ASSIGNABLE ) and table.HasValue( ent:DoorOwners(), LocalPlayer():CharID() ) ) then
				
				local option = { "Sell", function()
					
					net.Start( "nCSellDoor" );
						net.WriteEntity( ent );
					net.SendToServer();
					
					self:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You sold the door for 80% of its original value (" .. tostring( math.floor( ent:DoorPrice() * 0.8 ) ) .. " credits).", { CB_ALL, CB_IC } );
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
			if( table.HasValue( ent:DoorOwners(), LocalPlayer():CharID() ) ) then
				
				local option = { "Rename", function()
					
					self:CCCreateDoorNameEdit();
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
				local option = { "Manage Owners", function()
					
					self:CCCreateDoorOwnersEdit();
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
			if( LocalPlayer():CanLock( ent ) ) then
				
				local option = { "Lock/Unlock", function()
					
					net.Start( "nCLockUnlock" );
						net.WriteEntity( ent );
					net.SendToServer();
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
		elseif( ent:IsPlayer() ) then
			
			local option = { "Examine", function()
				
				self:CCCreatePlayerViewer( CCSelectedEnt );
				
				net.Start( "nCExamine" );
				net.SendToServer();
				
			end, nil, self:GetPlayerSight() };
			
			table.insert( tab, option );
			
			if( LocalPlayer():TiedUp() ) then return tab end
			if( LocalPlayer():PassedOut() ) then return tab end
			
			local option = { "Give Credits", function()
				
				self:CCCreateGiveCredits();
				
			end, nil, 100 };
			
			table.insert( tab, option );
			
			local option = { "Pat Down", function()
				
				net.Start( "nCPatDownStart" );
					net.WriteEntity( ent );
				net.SendToServer();
				
				local mul = 1;
				
				if( LocalPlayer():HasTrait( TRAIT_SPEEDY ) or ent:HasTrait( TRAIT_SPEEDY ) ) then
					
					mul = 0.5;
					
				end
				
				GAMEMODE:CreateTimedProgressBar( 5 * mul, "Patting Down...", ent, function()
					
					net.Start( "nCPatDown" );
						net.WriteEntity( ent );
					net.SendToServer();
					
				end );
				
			end, nil, 100 };
			
			table.insert( tab, option );
			
			if( ent:TiedUp() ) then
				
				local option = { "Untie", function()
					
					net.Start( "nCUntieStart" );
						net.WriteEntity( ent );
					net.SendToServer();
					
					GAMEMODE:CreateTimedProgressBar( 2, "Untying...", ent, function()
						
						net.Start( "nCUntie" );
							net.WriteEntity( ent );
						net.SendToServer();
						
					end );
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			elseif( LocalPlayer():HasItem( "zipties" ) ) then
				
				local option = { "Tie Up", function()
					
					net.Start( "nCTieUpStart" );
						net.WriteEntity( ent );
					net.SendToServer();
					
					GAMEMODE:CreateTimedProgressBar( 5, "Tying...", ent, function()
						
						net.Start( "nCTieUp" );
							net.WriteEntity( ent );
						net.SendToServer();
						
					end );
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
			if( ent:PassedOut() and LocalPlayer():HasItem( "weapon_cc_knife" ) and ent:GetVelocity():Length2D() <= 5 ) then
				
				local option = { "Slit Throat", function()
					
					net.Start( "nCSlitThroat" );
						net.WriteEntity( ent );
					net.SendToServer();
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
		elseif( ent:GetClass() == "cc_item" ) then
			
			if( string.len( GAMEMODE:GetItemByID( ent:GetItem() ).Description ) > 0 ) then
				
				local option = { "Examine", function()
					
					self:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", GAMEMODE:GetItemByID( ent:GetItem() ).Description, { CB_ALL, CB_IC } );
					
					net.Start( "nCExamine" );
					net.SendToServer();
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
		elseif( ent:GetClass() == "cc_radio" ) then
			
			if( LocalPlayer():CharID() == ent:GetDeployer() ) then
				
				local option = { "Take", function()
					
					net.Start( "nCTakeRadio" );
						net.WriteEntity( ent );
					net.SendToServer();
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
			local option = { "Channel", function()
				
				CCP.RadioSelector = vgui.Create( "DFrame" );
				CCP.RadioSelector:SetSize( 250, 114 );
				CCP.RadioSelector:Center();
				CCP.RadioSelector:SetTitle( "Change Channel (0-999)" );
				CCP.RadioSelector.lblTitle:SetFont( "CombineControl.Window" );
				CCP.RadioSelector:MakePopup();
				CCP.RadioSelector.PerformLayout = CCFramePerformLayout;
				CCP.RadioSelector:PerformLayout();
				
				CCP.RadioSelector.Entry = vgui.Create( "DTextEntry", CCP.RadioSelector );
				CCP.RadioSelector.Entry:SetFont( "CombineControl.LabelBig" );
				CCP.RadioSelector.Entry:SetPos( 10, 34 );
				CCP.RadioSelector.Entry:SetSize( 100, 30 );
				CCP.RadioSelector.Entry:PerformLayout();
				CCP.RadioSelector.Entry:RequestFocus();
				CCP.RadioSelector.Entry:SetNumeric( true );
				CCP.RadioSelector.Entry:SetValue( ent:GetChannel() );
				CCP.RadioSelector.Entry:SetCaretPos( string.len( CCP.RadioSelector.Entry:GetValue() ) );
				
				CCP.RadioSelector.OK = vgui.Create( "DButton", CCP.RadioSelector );
				CCP.RadioSelector.OK:SetFont( "CombineControl.LabelSmall" );
				CCP.RadioSelector.OK:SetText( "OK" );
				CCP.RadioSelector.OK:SetPos( 190, 74 );
				CCP.RadioSelector.OK:SetSize( 50, 30 );
				function CCP.RadioSelector.OK:DoClick()
					
					local val = tonumber( CCP.RadioSelector.Entry:GetValue() );
					
					if( val >= 0 ) then
						
						if( val <= 999 ) then
							
							CCP.RadioSelector:Remove();
							
							GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You change the radio channel to " .. tostring( val ) .. ".", { CB_ALL, CB_IC } );
							
							net.Start( "nCRadioChannel" );
								net.WriteEntity( ent );
								net.WriteFloat( val );
							net.SendToServer();
							
						else
							
							GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Highest channel is 999.", { CB_ALL, CB_IC } );
							
						end
						
					else
						
						GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Lowest channel is 0.", { CB_ALL, CB_IC } );
						
					end
					
				end
				CCP.RadioSelector.OK:PerformLayout();
				
				CCP.RadioSelector.Entry.OnEnter = CCP.RadioSelector.OK.DoClick;
				
			end, nil, 100 };
			
			table.insert( tab, option );
			
		elseif( ent:GetClass() == "npc_turret_floor" ) then
			
			local flag = GAMEMODE:LookupCombineFlag( LocalPlayer():ActiveFlag() );
			
			if( flag and table.HasValue( flag.ItemLoadout, "combineturret" ) ) then
				
				if( LocalPlayer():CanTakeItem( "combineturret" ) ) then
					
					local option = { "Take", function()
						
						net.Start( "nCTakeTurret" );
							net.WriteEntity( ent );
						net.SendToServer();
						
					end, nil, 100 };
					
					table.insert( tab, option );
					
				end
				
			end
			
		elseif( ent:GetClass() == "cc_tv" ) then
			
			if( LocalPlayer():CharID() == ent:GetDeployer() ) then
				
				if( LocalPlayer():CanTakeItem( "television" ) ) then
					
					local option = { "Take", function()
						
						net.Start( "nCTakeTV" );
							net.WriteEntity( ent );
						net.SendToServer();
						
					end, nil, 100 };
					
					table.insert( tab, option );
					
				end
				
			end
			
			if( ent:GetBroken() ) then
				
				local option = { "Repair", function()
					
					if( !LocalPlayer():HasItem( "scrapelectronics" ) ) then
						
						GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need scrap electronics to repair this!", { CB_ALL, CB_OOC } );
						return;
						
					end
					
					net.Start( "nCRepairTV" );
						net.WriteEntity( ent );
					net.SendToServer();
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
		elseif( ent:GetClass() == "cc_stove" ) then
			
			if( LocalPlayer():CharID() == ent:GetDeployer() ) then
				
				if( LocalPlayer():CanTakeItem( "microwave" ) ) then
					
					local option = { "Take", function()
						
						net.Start( "nCTakeMicrowave" );
							net.WriteEntity( ent );
						net.SendToServer();
						
					end, nil, 100 };
					
					table.insert( tab, option );
					
				end
				
			end
			
			if( ent:GetBroken() ) then
				
				local option = { "Repair", function()
					
					if( !LocalPlayer():HasItem( "scrapelectronics" ) ) then
						
						GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need scrap electronics to repair this!", { CB_ALL, CB_OOC } );
						return;
						
					end
					
					net.Start( "nCRepairStove" );
						net.WriteEntity( ent );
					net.SendToServer();
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
		elseif( ent:GetClass() == "cc_paper" ) then
			
			local option = { "Read", function()
				
				net.Start( "nCExamine" );
				net.SendToServer();
				
				local paper = vgui.Create( "DFrame" );
				paper:SetSize( 400, 600 );
				paper:Center();
				paper:SetTitle( "" );
				paper:MakePopup();
				paper.PerformLayout = CCFramePerformLayout;
				paper:PerformLayout();
				paper.Paint = function( panel, w, h )
					
					surface.SetDrawColor( 255, 255, 255, 255 );
					surface.DrawRect( 0, 0, w, h );
					
				end
				
				local entry = vgui.Create( "DTextEntry", paper );
				entry:SetFont( "CombineControl.Written" );
				entry:SetPos( 10, 34 );
				entry:SetSize( 380, 526 );
				entry:SetMultiline( true );
				entry:PerformLayout();
				entry:SetTextColor( Color( 0, 0, 0, 255 ) )
				entry:SetDrawBackground( false );
				entry:SetValue( ent:GetText() );
				entry:SetEditable( false );
				
			end, nil, 100 };
			
			table.insert( tab, option );
			
		end
		
	end
	
	if( GAMEMODE.VoicesEnabled and GAMEMODE.Voices[LocalPlayer():Gender()] ) then
		
		for k, v in pairs( GAMEMODE.Voices[LocalPlayer():Gender()] ) do
			
			local option = { "Voice: " .. v[1], function()
				
				net.Start( "nSayVoice" );
					net.WriteUInt( k, 8 );
				net.SendToServer();
				
			end, true };
			
			table.insert( tab, option );
			
		end
		
	end
	
	for k, v in pairs( self:GetValidGestures( LocalPlayer() ) ) do
		
		local option = { k, function()
			
			LocalPlayer():PlaySignal( v );
			
		end, true };
		
		table.insert( tab, option );
		
	end
	
	for k, v in pairs( self:GetValidExpressions( LocalPlayer() ) ) do
		
		local option = { k, function()
			
			net.Start( "nPlayExpression" );
				net.WriteString( v );
			net.SendToServer();
			
		end, true };
		
		table.insert( tab, option );
		
	end
	
	return tab;
	
end

function GM:CCCreateDoorNameEdit()
	
	CCP.DoorNameEdit = vgui.Create( "DFrame" );
	CCP.DoorNameEdit:SetSize( 300, 114 );
	CCP.DoorNameEdit:Center();
	CCP.DoorNameEdit:SetTitle( "Change Door Name" );
	CCP.DoorNameEdit.lblTitle:SetFont( "CombineControl.Window" );
	CCP.DoorNameEdit:MakePopup();
	CCP.DoorNameEdit.PerformLayout = CCFramePerformLayout;
	CCP.DoorNameEdit:PerformLayout();
	
	CCP.DoorNameEdit.Label = vgui.Create( "DLabel", CCP.DoorNameEdit );
	CCP.DoorNameEdit.Label:SetText( string.len( CCSelectedEnt:DoorName() ) .. "/50" );
	CCP.DoorNameEdit.Label:SetPos( 10, 74 );
	CCP.DoorNameEdit.Label:SetSize( 280, 22 );
	CCP.DoorNameEdit.Label:SetFont( "CombineControl.LabelGiant" );
	CCP.DoorNameEdit.Label:PerformLayout();
	
	CCP.DoorNameEdit.Entry = vgui.Create( "DTextEntry", CCP.DoorNameEdit );
	CCP.DoorNameEdit.Entry:SetFont( "CombineControl.LabelBig" );
	CCP.DoorNameEdit.Entry:SetPos( 10, 34 );
	CCP.DoorNameEdit.Entry:SetSize( 280, 30 );
	CCP.DoorNameEdit.Entry:PerformLayout();
	CCP.DoorNameEdit.Entry:SetValue( CCSelectedEnt:DoorName() );
	CCP.DoorNameEdit.Entry:RequestFocus();
	CCP.DoorNameEdit.Entry:SetCaretPos( string.len( CCP.DoorNameEdit.Entry:GetValue() ) );
	function CCP.DoorNameEdit.Entry:OnChange()
		
		if( CCP.DoorNameEdit.Label ) then
			
			local val = self:GetValue();
			
			local col = Color( 200, 200, 200, 255 );
			
			if( string.len( string.Trim( val ) ) > 50 or string.len( string.Trim( val ) ) < 1 ) then
				
				col = Color( 200, 0, 0, 255 );
				
			end
			
			CCP.DoorNameEdit.Label:SetText( string.len( string.Trim( val ) ) .. "/50" );
			CCP.DoorNameEdit.Label:SetTextColor( col );
			
		end
		
	end
	
	CCP.DoorNameEdit.OK = vgui.Create( "DButton", CCP.DoorNameEdit );
	CCP.DoorNameEdit.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.DoorNameEdit.OK:SetText( "OK" );
	CCP.DoorNameEdit.OK:SetPos( 240, 74 );
	CCP.DoorNameEdit.OK:SetSize( 50, 30 );
	function CCP.DoorNameEdit.OK:DoClick()
		
		local val = string.Trim( CCP.DoorNameEdit.Entry:GetValue() );
		
		if( string.len( val ) <= 50 and string.len( val ) >= 1 ) then
			
			CCP.DoorNameEdit:Remove();
			
			net.Start( "nCNameDoor" );
				net.WriteEntity( CCSelectedEnt );
				net.WriteString( val );
			net.SendToServer();
			
		else
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Name must be between 1 and 50 characters.", { CB_ALL, CB_OOC } );
			
		end
		
	end
	CCP.DoorNameEdit.OK:PerformLayout();
	
	CCP.DoorNameEdit.Entry.OnEnter = CCP.DoorNameEdit.OK.DoClick;
	
end

function GM:CCCreateDoorOwnersEdit()
	
	CCP.DoorOwnersEdit = vgui.Create( "DFrame" );
	CCP.DoorOwnersEdit:SetSize( 400, 504 );
	CCP.DoorOwnersEdit:Center();
	CCP.DoorOwnersEdit:SetTitle( "Manage Door Owners" );
	CCP.DoorOwnersEdit.lblTitle:SetFont( "CombineControl.Window" );
	CCP.DoorOwnersEdit:MakePopup();
	CCP.DoorOwnersEdit.PerformLayout = CCFramePerformLayout;
	CCP.DoorOwnersEdit:PerformLayout();
	
	CCP.DoorOwnersEdit.AllPlayers = vgui.Create( "DListView", CCP.DoorOwnersEdit );
	CCP.DoorOwnersEdit.AllPlayers:SetPos( 10, 34 );
	CCP.DoorOwnersEdit.AllPlayers:SetSize( 185, 430 );
	CCP.DoorOwnersEdit.AllPlayers:AddColumn( "Characters" );
	
	for k, v in pairs( player.GetAll() ) do
		
		if( !table.HasValue( CCSelectedEnt:DoorOwners(), v:CharID() ) and !table.HasValue( CCSelectedEnt:DoorAssignedOwners(), v:CharID() ) and !v:HasAnyCombineFlag() ) then
			
			CCP.DoorOwnersEdit.AllPlayers:AddLine( v:VisibleRPName() ).Player = v;
			
		end
		
	end
	
	CCP.DoorOwnersEdit.Owners = vgui.Create( "DListView", CCP.DoorOwnersEdit );
	CCP.DoorOwnersEdit.Owners:SetPos( 205, 34 );
	CCP.DoorOwnersEdit.Owners:SetSize( 185, 430 );
	CCP.DoorOwnersEdit.Owners:AddColumn( "Owners" );
	
	for k, v in pairs( CCSelectedEnt:DoorOwners() ) do
		
		if( v != LocalPlayer():CharID() ) then
			
			if( player.GetByCharID( v ) and player.GetByCharID( v ):IsValid() ) then
				
				CCP.DoorOwnersEdit.Owners:AddLine( player.GetByCharID( v ):VisibleRPName() ).Player = player.GetByCharID( v );
				
			end
			
		end
		
	end
	
	CCP.DoorOwnersEdit.MakeOwner = vgui.Create( "DButton", CCP.DoorOwnersEdit );
	CCP.DoorOwnersEdit.MakeOwner:SetFont( "CombineControl.LabelSmall" );
	CCP.DoorOwnersEdit.MakeOwner:SetText( ">" );
	CCP.DoorOwnersEdit.MakeOwner:SetPos( 10, 474 );
	CCP.DoorOwnersEdit.MakeOwner:SetSize( 185, 20 );
	function CCP.DoorOwnersEdit.MakeOwner:DoClick()
		
		if( !CCP.DoorOwnersEdit.AllPlayers:GetSelected()[1] ) then return end
		
		local ply = CCP.DoorOwnersEdit.AllPlayers:GetSelected()[1].Player;
		
		net.Start( "nCMakeOwner" );
			net.WriteEntity( CCSelectedEnt );
			net.WriteEntity( ply );
		net.SendToServer();
		
		CCP.DoorOwnersEdit.AllPlayers:RemoveLine( CCP.DoorOwnersEdit.AllPlayers:GetSelected()[1]:GetID() );
		CCP.DoorOwnersEdit.Owners:AddLine( ply:VisibleRPName() ).Player = ply;
		
	end
	CCP.DoorOwnersEdit.MakeOwner:PerformLayout();
	
	CCP.DoorOwnersEdit.RemoveOwner = vgui.Create( "DButton", CCP.DoorOwnersEdit );
	CCP.DoorOwnersEdit.RemoveOwner:SetFont( "CombineControl.LabelSmall" );
	CCP.DoorOwnersEdit.RemoveOwner:SetText( "<" );
	CCP.DoorOwnersEdit.RemoveOwner:SetPos( 205, 474 );
	CCP.DoorOwnersEdit.RemoveOwner:SetSize( 185, 20 );
	function CCP.DoorOwnersEdit.RemoveOwner:DoClick()
		
		if( !CCP.DoorOwnersEdit.Owners:GetSelected()[1] ) then return end
		
		local ply = CCP.DoorOwnersEdit.Owners:GetSelected()[1].Player;
		
		net.Start( "nCRemoveOwner" );
			net.WriteEntity( CCSelectedEnt );
			net.WriteEntity( ply );
		net.SendToServer();
		
		CCP.DoorOwnersEdit.Owners:RemoveLine( CCP.DoorOwnersEdit.Owners:GetSelected()[1]:GetID() );
		CCP.DoorOwnersEdit.AllPlayers:AddLine( ply:VisibleRPName() ).Player = ply;
		
	end
	CCP.DoorOwnersEdit.RemoveOwner:PerformLayout();
	
end

function GM:CCCreateGiveCredits()
	
	CCP.GiveCredits = vgui.Create( "DFrame" );
	CCP.GiveCredits:SetSize( 250, 114 );
	CCP.GiveCredits:Center();
	CCP.GiveCredits:SetTitle( "Give Credits" );
	CCP.GiveCredits.lblTitle:SetFont( "CombineControl.Window" );
	CCP.GiveCredits:MakePopup();
	CCP.GiveCredits.PerformLayout = CCFramePerformLayout;
	CCP.GiveCredits:PerformLayout();
	
	CCP.GiveCredits.Entry = vgui.Create( "DTextEntry", CCP.GiveCredits );
	CCP.GiveCredits.Entry:SetFont( "CombineControl.LabelBig" );
	CCP.GiveCredits.Entry:SetPos( 10, 34 );
	CCP.GiveCredits.Entry:SetSize( 100, 30 );
	CCP.GiveCredits.Entry:PerformLayout();
	CCP.GiveCredits.Entry:RequestFocus();
	CCP.GiveCredits.Entry:SetNumeric( true );
	CCP.GiveCredits.Entry:SetCaretPos( string.len( CCP.GiveCredits.Entry:GetValue() ) );
	
	CCP.GiveCredits.Label = vgui.Create( "DLabel", CCP.GiveCredits );
	CCP.GiveCredits.Label:SetText( "Credits" );
	CCP.GiveCredits.Label:SetPos( 120, 34 );
	CCP.GiveCredits.Label:SetSize( 130, 30 );
	CCP.GiveCredits.Label:SetFont( "CombineControl.LabelBig" );
	CCP.GiveCredits.Label:PerformLayout();
	
	CCP.GiveCredits.OK = vgui.Create( "DButton", CCP.GiveCredits );
	CCP.GiveCredits.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.GiveCredits.OK:SetText( "OK" );
	CCP.GiveCredits.OK:SetPos( 190, 74 );
	CCP.GiveCredits.OK:SetSize( 50, 30 );
	function CCP.GiveCredits.OK:DoClick()
		
		if( !CCSelectedEnt or !CCSelectedEnt:IsValid() ) then return end
		
		local val = tonumber( CCP.GiveCredits.Entry:GetValue() );
		
		if( !val or math.floor( val ) < 1 ) then
			
			CCP.GiveCredits:Remove();
			return;
			
		end
		
		if( LocalPlayer():GetPos():Distance( CCSelectedEnt:GetPos() ) > 100 ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "They're too far away.", { CB_ALL, CB_OOC } );
			return;
			
		end
		
		val = math.floor( val );
		
		if( LocalPlayer():Money() >= val ) then
			
			CCP.GiveCredits:Remove();
			
			net.Start( "nCGiveCredits" );
				net.WriteUInt( val, 32 );
				net.WriteEntity( CCSelectedEnt );
			net.SendToServer();
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You gave " .. CCSelectedEnt:VisibleRPName() .. " " .. val .. " credits.", { CB_ALL, CB_OOC } );
			
		else
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You don't have this many credits!", { CB_ALL, CB_OOC } );
			
		end
		
	end
	CCP.GiveCredits.OK:PerformLayout();
	
	CCP.GiveCredits.Entry.OnEnter = CCP.GiveCredits.OK.DoClick;
	
end

function GM:CCCreatePlayerViewer( ent )
	
	if( !ent or !ent:IsValid() ) then return end
	
	CCP.PlayerViewer = vgui.Create( "DFrame" );
	CCP.PlayerViewer:SetSize( 800, 426 );
	CCP.PlayerViewer:Center();
	CCP.PlayerViewer:SetTitle( ent:VisibleRPName() );
	CCP.PlayerViewer.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerViewer:MakePopup();
	CCP.PlayerViewer.PerformLayout = CCFramePerformLayout;
	CCP.PlayerViewer:PerformLayout();
	
	CCP.PlayerViewer.CharacterModel = vgui.Create( "DModelPanel", CCP.PlayerViewer );
	CCP.PlayerViewer.CharacterModel:SetPos( 10, 34 );
	CCP.PlayerViewer.CharacterModel:SetModel( ent:GetModel() );
	CCP.PlayerViewer.CharacterModel.Entity:SetSkin( ent:GetSkin() );
	for i = 0,  20 do
		CCP.PlayerViewer.CharacterModel.Entity:SetBodygroup( i, ent:GetBodygroup( i ) );
		CCP.PlayerViewer.CharacterModel.Entity:SetSubMaterial( i, ent:GetSubMaterial( i ) );
	end
	
	CCP.PlayerViewer.CharacterModel:SetSize( 200, 382 );
	CCP.PlayerViewer.CharacterModel:SetFOV( 20 );
	CCP.PlayerViewer.CharacterModel:SetCamPos( Vector( 50, 0, 56 ) );
	CCP.PlayerViewer.CharacterModel:SetLookAt( Vector( 0, 0, 56 ) );
	function CCP.PlayerViewer.CharacterModel:DoClick()
		
		self:StartScene( "scenes/expressions/citizen_angry_idle_01.vcd" );
		
	end
	function CCP.PlayerViewer.CharacterModel.Entity:GetPlayerColor()
		
		if( !ent or !ent:IsValid() ) then return Vector( 1, 1, 1 ) end
		
		return ent:GetPlayerColor();
		
	end
	
	CCP.PlayerViewer.CharacterName = vgui.Create( "DLabel", CCP.PlayerViewer );
	CCP.PlayerViewer.CharacterName:SetText( ent:RPName() );
	CCP.PlayerViewer.CharacterName:SetPos( 220, 34 );
	CCP.PlayerViewer.CharacterName:SetSize( 540, 22 );
	CCP.PlayerViewer.CharacterName:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerViewer.CharacterName:PerformLayout();
	
	CCP.PlayerViewer.CharacterDescScroll = vgui.Create( "DScrollPanel", CCP.PlayerViewer );
	CCP.PlayerViewer.CharacterDescScroll:SetPos( 220, 64 );
	CCP.PlayerViewer.CharacterDescScroll:SetSize( 540, 352 );
	function CCP.PlayerViewer.CharacterDescScroll:Paint( w, h ) end
	
	CCP.PlayerViewer.CharacterDesc = vgui.Create( "CCLabel" );
	CCP.PlayerViewer.CharacterDesc:SetPos( 0, 0 );
	CCP.PlayerViewer.CharacterDesc:SetSize( 530, 10 );
	CCP.PlayerViewer.CharacterDesc:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerViewer.CharacterDesc:SetText( ent:Description() );
	CCP.PlayerViewer.CharacterDesc:PerformLayout();
	
	CCP.PlayerViewer.CharacterDescScroll:AddItem( CCP.PlayerViewer.CharacterDesc );
	
end

function GM:CreateCCContext( ent )
	
	CloseDermaMenus();
	
	CCSelectedEnt = ent;
	local dist = 0;
	
	if( ent and ent:IsValid() ) then
		
		dist = LocalPlayer():GetPos():Distance( ent:GetPos() );
		
	end
	
	local options = self:GetCCOptions( CCSelectedEnt, dist );
	
	gui.EnableScreenClicker( true );
	
	local menu = DermaMenu();
	menu:SetPos( gui.MousePos() );
	
	for _, v in pairs( options ) do
		
		if( !v[4] or ( v[4] and dist <= v[4] ) ) then
			
			menu:AddOption( v[1], function()
				
				gui.EnableScreenClicker( false );
				
				if( ( !CCSelectedEnt or !CCSelectedEnt:IsValid() ) and !v[3] ) then return end
				
				if( !v[3] and CCSelectedEnt and CCSelectedEnt:IsValid() and LocalPlayer():GetPos():Distance( CCSelectedEnt:GetPos() ) > v[4] ) then return end
				
				v[2]( CCSelectedEnt );
				
			end );
			
		end
		
	end
	
	menu:Open();
	
end

function GM:RemoveCCContext( d )
	
	gui.EnableScreenClicker( false );
	CloseDermaMenus();
	
end
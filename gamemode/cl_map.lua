GM.ConnectMessages = { };
GM.EntryPortSpawns = { };

local files = file.Find( GM.FolderName .. "/gamemode/maps/" .. game.GetMap() .. ".lua", "LUA", "namedesc" );

if( #files > 0 ) then

	for _, v in pairs( files ) do
		
		include( "maps/" .. v );
		
	end
	
	MsgC( Color( 200, 200, 200, 255 ), "Clientside map lua file for " .. game.GetMap() .. " loaded.\n" );
	
else
	
	MsgC( Color( 200, 200, 200, 255 ), "Warning: No clientside map lua file for " .. game.GetMap() .. ".\n" );
	
end

function GM:OnEntityCreated( ent )
	
	if( ent:IsPlayer() ) then
		
		if( ent != LocalPlayer() ) then
			
			net.Start( "nRequestPlayerData" );
				net.WriteEntity( ent );
			net.SendToServer();
			
		end
		
	end
	
end

function GM:CreateParticleEmitters()
	
	if( !self.Emitter2D ) then
		
		self.Emitter2D = ParticleEmitter( LocalPlayer():GetPos() );
		
	else
		
		self.Emitter2D:SetPos( LocalPlayer():GetPos() );
		
	end
	
	if( !self.Emitter3D ) then
		
		self.Emitter3D = ParticleEmitter( LocalPlayer():GetPos(), true );
		
	else
		
		self.Emitter3D:SetPos( LocalPlayer():GetPos() );
		
	end
	
end

function GM:JWThink()
	
	if( self:JudgementWaiver() == 1 ) then
		
		if( !self.NextJWSound ) then self.NextJWSound = CurTime() + 6 end
		if( !self.NextJWCitySound ) then self.NextJWCitySound = CurTime() end
		
		if( CurTime() >= self.NextJWCitySound ) then
			
			self.NextJWCitySound = CurTime() + 180;
			surface.PlaySound( "npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav" );
			
		end
		
		if( CurTime() >= self.NextJWSound ) then
			
			self.NextJWSound = CurTime() + 30;
			surface.PlaySound( "ambient/alarms/citadel_alert_loop2.wav" );
			
		end
		
	end
	
end

function nConnect( len )
	
	local ip = net.ReadString();
	
	LocalPlayer():ConCommand( "connect " .. ip .. "\n" );
	
end
net.Receive( "nConnect", nConnect );

function nServerOffer( len )
	
	local loc = net.ReadUInt( 5 );
	local port = net.ReadUInt( 5 );
	
	if( CCP.ServerOffer and CCP.ServerOffer:IsValid() ) then return end
	
	if( !GAMEMODE.NextLocationChange ) then GAMEMODE.NextLocationChange = CurTime() end
	
	if( CurTime() > GAMEMODE.NextLocationChange ) then
		
		GAMEMODE.NextLocationChange = CurTime() + 10;
		
		CCP.ServerOffer = vgui.Create( "DFrame" );
		CCP.ServerOffer:SetSize( 400, 200 );
		CCP.ServerOffer:Center();
		CCP.ServerOffer:SetTitle( "Location Change" );
		CCP.ServerOffer.lblTitle:SetFont( "CombineControl.Window" );
		CCP.ServerOffer:MakePopup();
		CCP.ServerOffer.PerformLayout = CCFramePerformLayout;
		CCP.ServerOffer:PerformLayout();
		
		CCP.ServerOffer.WarningLabel = vgui.Create( "DLabel", CCP.ServerOffer );
		CCP.ServerOffer.WarningLabel:SetText( GAMEMODE.ConnectMessages[port] .. "\n\nIf you go, you will no longer have access to your character in your current location, until you come back. Close this window if you want to stay here." );
		CCP.ServerOffer.WarningLabel:SetPos( 10, 34 );
		CCP.ServerOffer.WarningLabel:SetSize( 380, 14 );
		CCP.ServerOffer.WarningLabel:SetFont( "CombineControl.LabelSmall" );
		CCP.ServerOffer.WarningLabel:PerformLayout();
		CCP.ServerOffer.WarningLabel:SetWrap( true );
		CCP.ServerOffer.WarningLabel:SetAutoStretchVertical( true );
		
		CCP.ServerOffer.OK = vgui.Create( "DButton", CCP.ServerOffer );
		CCP.ServerOffer.OK:SetFont( "CombineControl.LabelSmall" );
		CCP.ServerOffer.OK:SetText( "Go" );
		CCP.ServerOffer.OK:SetPos( 400 - 60, 200 - 40 );
		CCP.ServerOffer.OK:SetSize( 50, 30 );
		function CCP.ServerOffer.OK:DoClick()
			
			net.Start( "nServerOfferAccept" );
				net.WriteUInt( loc, 5 );
				net.WriteUInt( port, 5 );
			net.SendToServer();
			
			CCP.ServerOffer:Remove();
			
		end
		CCP.ServerOffer.OK:PerformLayout();
		
	end
	
end
net.Receive( "nServerOffer", nServerOffer );
function GM:ScoreboardHide()
	
	if( CCP.Scoreboard ) then
		
		CCP.Scoreboard:Remove();
		
	end
	
	CCP.Scoreboard = nil;
	
end

function GM:ScoreboardShow()
	
	CCP.Scoreboard = vgui.Create( "DPanel" );
	CCP.Scoreboard:SetSize( 500, 600 );
	CCP.Scoreboard:Center();
	CCP.Scoreboard:MakePopup();
	
	function CCP.Scoreboard:Paint( w, h )
		
		draw.RoundedBox( 0, 0, 0, w, h, Color( 30, 30, 30, 230 ) );
		draw.RoundedBox( 0, 0, 0, w, 50, Color( 20, 20, 20, 255 ) );
		
		surface.SetFont( "CombineControl.LabelMassive" );
		surface.SetTextColor( 200, 200, 200, 255 );
		surface.SetTextPos( 10, 10 );
		surface.DrawText( "CombineControl" );
		
		return true

	end
	
	CCP.Scoreboard.Players = vgui.Create( "DScrollPanel", CCP.Scoreboard );
	CCP.Scoreboard.Players:SetPos( 0, 50 );
	CCP.Scoreboard.Players:SetSize( 500, CCP.Scoreboard:GetTall() - 50 );
	function CCP.Scoreboard.Players:Paint( w, h ) end
	
	local y = 10;
	
	for _, v in pairs( table.GetKeys( team.GetAllTeams() ) ) do
		
		if( team.NumPlayers( v ) > 0 ) then
			
			local name = vgui.Create( "DLabel", CCP.Scoreboard.Players );
			name:SetText( team.GetName( v ) );
			name:SetPos( 10, y );
			name:SetFont( "CombineControl.LabelGiant" );
			name:SizeToContents();
			name:PerformLayout();
			CCP.Scoreboard.Players:AddItem( name );
			
			y = y + 32;
			
			local n = true;
			
			for _, v in pairs( team.GetPlayers( v ) ) do
				
				self:ScoreboardAdd( v, y, n );
				y = y + 48;
				n = !n;
				
			end
			
			y = y + 10;
			
		end
		
	end
	
	CCP.Scoreboard.Players:PerformLayout();
	
end

GM.BronzeMat = Material( "icon16/medal_bronze_1.png" );
GM.SilverMat = Material( "icon16/medal_silver_1.png" );
GM.GoldMat = Material( "icon16/medal_gold_1.png" );
GM.AdminMat = Material( "icon16/shield.png" );
GM.SuperAdminMat = Material( "icon16/shield_add.png" );

GM.ScoreboardBadges = { };
GM.ScoreboardBadges[BADGE_BETATEST] = { Material( "icon16/controller.png" ), "Beta Tester" };
GM.ScoreboardBadges[BADGE_BETASCR] = { Material( "icon16/picture_edit.png" ), "Screenshot Contest Winner" };
GM.ScoreboardBadges[BADGE_BIRTHDAY] = { Material( "icon16/cake.png" ), "Disseminate's Birthday" };

function GM:ScoreboardAdd( ply, y, n )
	
	local entry = vgui.Create( "DPanel", CCP.Scoreboard.Players );
	entry:SetSize( 500, 48 );
	function entry:Paint( w, h )
		
		if( !ply or !ply:IsValid() ) then
			
			self:Remove();
			return;
			
		end
		
		if( n ) then
			
			draw.RoundedBox( 0, 0, 0, w, h, Color( 20, 20, 20, 130 ) );
			
		end
		
		surface.SetTextColor( 200, 200, 200, 255 );
		surface.SetFont( "CombineControl.LabelSmall" );
		surface.SetTextPos( 58, 10 );
		surface.DrawText( ply:VisibleRPName() );
		
		local x, _ = surface.GetTextSize( ply:Ping() );
		
		surface.SetTextPos( w - 30 - x, 10 );
		surface.DrawText( ply:Ping() );
		
		if( !ply:HideAdmin() ) then
			
			local titlec = ply:ScoreboardTitleC();
			
			surface.SetTextColor( titlec.x, titlec.y, titlec.z, 255 );
			surface.SetFont( "CombineControl.LabelTiny" );
			surface.SetTextPos( 58, 28 );
			surface.DrawText( ply:ScoreboardTitle() );
			
		end
		
		local badgepos = w - 39;
		
		if( ply:IsAdmin() and !ply:HideAdmin() ) then
			
			local mat = GAMEMODE.AdminMat;
			
			if( ply:IsSuperAdmin() ) then
				
				mat = GAMEMODE.SuperAdminMat;
				
			end
			
			surface.SetMaterial( mat );
			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.DrawTexturedRect( badgepos, 28, 12, 12 );
			
			badgepos = badgepos - 16;
			
		end
		
		if( ply:DonationAmount() > GAMEMODE.BronzeDonorAmount and !ply:HideAdmin() ) then
			
			local mat = GAMEMODE.BronzeMat;
			
			if( ply:DonationAmount() > GAMEMODE.GoldDonorAmount ) then
				
				mat = GAMEMODE.GoldMat;
				
			elseif( ply:DonationAmount() > GAMEMODE.SilverDonorAmount ) then
				
				mat = GAMEMODE.SilverMat;
				
			end
			
			surface.SetMaterial( mat );
			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.DrawTexturedRect( badgepos, 28, 12, 12 );
			
			badgepos = badgepos - 16;
			
		end
		
		for k, v in pairs( GAMEMODE.ScoreboardBadges ) do
			
			if( ply:HasBadge( k ) ) then
				
				surface.SetMaterial( v[1] );
				surface.SetDrawColor( 255, 255, 255, 255 );
				surface.DrawTexturedRect( badgepos, 28, 12, 12 );
				
				badgepos = badgepos - 16;
				
			end
			
		end
		
	end
	
	entry:SetPos( 0, y );
	
	local icon = vgui.Create( "DModelPanel", entry );
	icon:SetPos( 0, 0 );
	icon:SetModel( ply:GetModel() );
	icon:SetSize( 48, 48 );
	
	local a, b = icon.Entity:GetModelBounds();
	
	icon:SetFOV( 20 );
	icon:SetCamPos( Vector( 60, -20, math.max( a.z, b.z ) - 8 ) );
	icon:SetLookAt( Vector( 0, 0, math.max( a.z, b.z ) - 8 ) );
	
	function icon:LayoutEntity() end
	
	local p = icon.Paint;
	
	function icon:Paint( w, h )
		
		local pnl = CCP.Scoreboard.Players;
		local x2, y2 = pnl:LocalToScreen( 0, 0 );
		local w2, h2 = pnl:GetSize();
		render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );
		
		p( self, w, h );
		
		render.SetScissorRect( 0, 0, 0, 0, false );
		
	end
	
	function icon.Entity:GetPlayerColor()
		
		if( !ply or !ply:IsValid() ) then return Vector( 1, 1, 1 ) end
		
		return ply:GetPlayerColor();
		
	end
	
	icon.Entity:SetSkin( ply:GetSkin() );
	for i = 0, 20 do
		icon.Entity:SetBodygroup( i, ply:GetBodygroup( i ) );
		icon.Entity:SetSubMaterial( i, ply:GetSubMaterial( i ) );
	end
	
	function icon:DoClick()
		
		
		
	end
	
	local but = vgui.Create( "DButton", entry );
	but:SetText( "" );
	but:SetPos( 0, 0 );
	but:SetSize( 400, 48 );
	function but:DoClick()
		
		GAMEMODE:CCCreatePlayerViewer( ply );
		
	end
	function but:Paint()
		
		
		
	end
	but:PerformLayout();
	
	local but = vgui.Create( "DButton", entry );
	but:SetText( "" );
	but:SetPos( 400, 0 );
	but:SetSize( 100, 48 );
	function but:DoClick()
		
		GAMEMODE:CCCreatePlayerData( ply );
		
	end
	function but:Paint()
		
		
		
	end
	but:PerformLayout();
	
	CCP.Scoreboard.Players:AddItem( entry );
	
end

local function CreateBadge( parent, mat, text, y )
	
	local icon = vgui.Create( "DImage", parent );
	icon:SetMaterial( mat );
	icon:SetPos( 10, y );
	icon:SetSize( 14, 14 );
	
	local badge = vgui.Create( "DLabel", parent );
	badge:SetText( text );
	badge:SetPos( 10 + 18, y );
	badge:SetSize( 170, 14 );
	badge:SetFont( "CombineControl.LabelSmall" );
	badge:PerformLayout();
	
	return y + 20;
	
end

function GM:CCCreatePlayerData( ply )
	
	if( !ply or !ply:IsValid() ) then return end
	
	CCP.PlayerData = vgui.Create( "DFrame" );
	CCP.PlayerData:SetSize( 200, 200 );
	CCP.PlayerData:Center();
	CCP.PlayerData:SetTitle( "Badges" );
	CCP.PlayerData.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerData:MakePopup();
	CCP.PlayerData.PerformLayout = CCFramePerformLayout;
	CCP.PlayerData:PerformLayout();
	
	local y = 34;
	
	if( ply:IsSuperAdmin() and !ply:HideAdmin() ) then
		
		y = CreateBadge( CCP.PlayerData, self.SuperAdminMat, "Owner", y );
		
	elseif( ply:IsAdmin() and !ply:HideAdmin() ) then
		
		y = CreateBadge( CCP.PlayerData, self.AdminMat, "Admin", y );
		
	end
	
	if( !ply:HideAdmin() ) then
		
		if( ply:DonationAmount() > GAMEMODE.GoldDonorAmount ) then
			
			y = CreateBadge( CCP.PlayerData, self.GoldMat, "Gold Donor", y );
			
		elseif( ply:DonationAmount() > GAMEMODE.SilverDonorAmount ) then
			
			y = CreateBadge( CCP.PlayerData, self.SilverMat, "Silver Donor", y );
			
		elseif( ply:DonationAmount() > GAMEMODE.BronzeDonorAmount ) then
			
			y = CreateBadge( CCP.PlayerData, self.BronzeMat, "Bronze Donor", y );
			
		end
		
	end
	
	
	for k, v in pairs( self.ScoreboardBadges ) do
		
		if( ply:HasBadge( k ) ) then
			
			y = CreateBadge( CCP.PlayerData, v[1], v[2], y );
			
		end
		
	end
	
end

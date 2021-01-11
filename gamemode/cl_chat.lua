GM.ChatboxOpen = GM.ChatboxOpen or false;
GM.ChatboxFilter = GM.ChatboxFilter or CB_ALL;

GM.ChatWidth = 600;
GM.ChatButtonWidth = 138;
GM.ChatButtonHeight = 20;

GM.ChatLines = GM.ChatLines or { };

function GM:AddChat( color, font, text, filter, pre, ply )
	
	pre = pre or "";
	
	local str, n = GAMEMODE:FormatLine( text, font, GAMEMODE.ChatWidth - 20 - 16 );
	
	table.insert( self.ChatLines, { color, font, text, filter, CurTime(), ply, str } );
	MsgC( color, pre .. text .. "\n" );
	
	if( #self.ChatLines > math.floor( cookie.GetNumber( "cc_maxchatlines", 100 ) ) ) then
		
		for i = 1, #self.ChatLines - math.floor( cookie.GetNumber( "cc_maxchatlines", 100 ) ) do
			
			table.remove( self.ChatLines, 1 );
			
		end
		
	end
	
	if( !system.HasFocus() and table.HasValue( filter, self.ChatboxFilter ) ) then
		
		system.FlashWindow();
		
	end
	
end

function nAddChat( len )
	
	local col = net.ReadVector();
	local str = net.ReadString();
	
	GAMEMODE:AddChat( Color( col.x, col.y, col.z, 255 ), "CombineControl.ChatNormal", str, { CB_ALL, CB_OOC } );
	
end
net.Receive( "nAddChat", nAddChat );

function GM:DrawChat()
	
	if( !self.ChatboxOpen ) then
		
		local y = ScrH() - 200 - 40 - 34;
		
		local tab = { };
		
		for _, v in pairs( self.ChatLines ) do
			
			if( table.HasValue( v[4], self.ChatboxFilter ) and CurTime() - v[5] < 10 ) then
				
				table.insert( tab, v );
				
			end
			
		end
		
		local ty = 0;
		
		for i = #tab, math.max( #tab - 8, 1 ), -1 do
			
			local color = tab[i][1];
			local font = tab[i][2];
			local text = tab[i][3];
			local filter = tab[i][4];
			local start = tab[i][5];
			
			local amul = 0;
			
			if( CurTime() - start < 9 ) then
				
				amul = 1;
				
			else
				
				amul = 1 - ( CurTime() - start - 9 );
				
			end
			
			local str, n = self:FormatLine( text, font, self.ChatWidth - 20 );
			local h = self.FontHeight[font];
			
			local expl = string.Explode( "\n", str );
			
			local cy = 0;
			
			for i = #expl, 1, -1 do
				
				local v = expl[i];
				
				local ch = self.FontHeight[font];
				
				if( y - ch < 0 ) then break; end
				
				draw.DrawTextShadow( string.sub( v, 1, 196 ), font, 30, y - ch, Color( color.r, color.g, color.b, color.a * amul ), Color( 0, 0, 0, 255 * amul ), 0 );
				
				y = y - ch;
				ty = ty + ch;
				
			end
			
		end
		
	end
	
end

function GM:CreateChatbox()
	
	self.ChatboxOpen = true;
	
	CCP.Chatbox = vgui.Create( "CCChat" );
	CCP.Chatbox:SetSize( self.ChatWidth, cookie.GetNumber( "cc_chatheight", 300 ) );
	CCP.Chatbox:SetPos( 20, ScrH() - 200 - 34 - cookie.GetNumber( "cc_chatheight", 300 ) );
	CCP.Chatbox:MakePopup();
	
	CCP.Chatbox.Entry = vgui.Create( "DTextEntry", CCP.Chatbox );
	CCP.Chatbox.Entry:SetFont( "CombineControl.ChatNormal" );
	CCP.Chatbox.Entry:SetPos( 10, cookie.GetNumber( "cc_chatheight", 300 ) - 30 );
	CCP.Chatbox.Entry:SetSize( self.ChatWidth - 20, 20 );
	CCP.Chatbox.Entry:PerformLayout();
	function CCP.Chatbox.Entry:OnEnter()
		
		if( string.len( self:GetValue() ) > 0 ) then
			
			if( string.len( self:GetValue() ) > 500 ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "The maximum chat length is 500 characters. You typed " .. string.len( self:GetValue() ) .. ".", { CB_ALL, CB_OOC } );
				GAMEMODE.NextChatText = self:GetValue();
				
			else
				
				net.Start( "nSay" );
					net.WriteString( self:GetValue() );
				net.SendToServer();
				
				GAMEMODE:OnChat( LocalPlayer(), self:GetValue() );
				
			end
			
		else
			
			GAMEMODE.NextChatText = nil;
			
		end
		
		GAMEMODE.ChatboxOpen = false;
		
		self:GetParent():Remove();
		
		CCP.Chatbox = nil;
		
	end
	function CCP.Chatbox.Entry:OnTextChanged()
		
		local cc = GAMEMODE:StringHasCommand( self:GetValue() );
		
		if( string.len( self:GetValue() ) > 0 ) then
			
			if( cc and ( ( cc[1] == "/r" and LocalPlayer():HasItem( "radio" ) ) or ( cc[1] == "/cr" and LocalPlayer():HasItem( "crdevice" ) ) ) ) then
				
				net.Start( "nSetTyping" );
					net.WriteUInt( 2, 2 );
				net.SendToServer();
				
			else
				
				net.Start( "nSetTyping" );
					net.WriteUInt( 1, 2 );
				net.SendToServer();
				
			end
			
		else
			
			net.Start( "nSetTyping" );
				net.WriteUInt( 0, 2 );
			net.SendToServer();
			
		end
		
		if( cc ) then
			
			self:SetTextColor( cc[2] );
			
		else
			
			self:SetTextColor( Color( 200, 200, 200, 255 ) );
			
		end
		
	end
	if( self.NextChatText ) then
		
		CCP.Chatbox.Entry:SetValue( self.NextChatText );
		self.NextChatText = nil;
		
	end
	CCP.Chatbox.Entry:RequestFocus();
	CCP.Chatbox.Entry:SetCaretPos( string.len( CCP.Chatbox.Entry:GetValue() ) );
	
	CCP.Chatbox.AllButton = vgui.Create( "DButton", CCP.Chatbox );
	CCP.Chatbox.AllButton:SetFont( "CombineControl.LabelSmall" );
	CCP.Chatbox.AllButton:SetText( "All" );
	CCP.Chatbox.AllButton:SetPos( 10, 10 );
	CCP.Chatbox.AllButton:SetSize( 100, 20 );
	function CCP.Chatbox.AllButton:DoClick()
		
		CCP.Chatbox.AllButton:SetDisabled( true );
		CCP.Chatbox.ICButton:SetDisabled( false );
		CCP.Chatbox.OOCButton:SetDisabled( false );
		GAMEMODE.ChatboxFilter = CB_ALL;
		
	end
	
	CCP.Chatbox.ICButton = vgui.Create( "DButton", CCP.Chatbox );
	CCP.Chatbox.ICButton:SetFont( "CombineControl.LabelSmall" );
	CCP.Chatbox.ICButton:SetText( "IC" );
	CCP.Chatbox.ICButton:SetPos( 120, 10 );
	CCP.Chatbox.ICButton:SetSize( 100, 20 );
	function CCP.Chatbox.ICButton:DoClick()
		
		CCP.Chatbox.AllButton:SetDisabled( false );
		CCP.Chatbox.ICButton:SetDisabled( true );
		CCP.Chatbox.OOCButton:SetDisabled( false );
		GAMEMODE.ChatboxFilter = CB_IC;
		
	end
	
	CCP.Chatbox.OOCButton = vgui.Create( "DButton", CCP.Chatbox );
	CCP.Chatbox.OOCButton:SetFont( "CombineControl.LabelSmall" );
	CCP.Chatbox.OOCButton:SetText( "OOC" );
	CCP.Chatbox.OOCButton:SetPos( 230, 10 );
	CCP.Chatbox.OOCButton:SetSize( 100, 20 );
	function CCP.Chatbox.OOCButton:DoClick()
		
		CCP.Chatbox.AllButton:SetDisabled( false );
		CCP.Chatbox.ICButton:SetDisabled( false );
		CCP.Chatbox.OOCButton:SetDisabled( true );
		GAMEMODE.ChatboxFilter = CB_OOC;
		
	end
	
	if( self.ChatboxFilter == CB_ALL ) then
		
		CCP.Chatbox.AllButton:SetDisabled( true );
		
	end
	
	if( self.ChatboxFilter == CB_IC ) then
		
		CCP.Chatbox.ICButton:SetDisabled( true );
		
	end
	
	if( self.ChatboxFilter == CB_OOC ) then
		
		CCP.Chatbox.OOCButton:SetDisabled( true );
		
	end
	
	CCP.Chatbox.CloseButton = vgui.Create( "DButton", CCP.Chatbox );
	CCP.Chatbox.CloseButton:SetFont( "marlett" );
	CCP.Chatbox.CloseButton:SetText( "r" );
	CCP.Chatbox.CloseButton:SetPos( self.ChatWidth - 20 - 10, 10 );
	CCP.Chatbox.CloseButton:SetSize( 20, 20 );
	function CCP.Chatbox.CloseButton:DoClick()
		
		GAMEMODE.ChatboxOpen = false;
		
		self:GetParent():Remove();
		
		CCP.Chatbox = nil;
		
	end
	
end

function GM:StartChat()
	
	return true;
	
end

function GM:ChatText( index, name, text, type )
	
	if( self.NotifyWhenPlayersJoin ) then
		
		if( type == "joinleave" ) then
			if( !string.find( text, "left the game" ) ) then
				GAMEMODE:AddChat( Color( 150, 150, 150, 255 ), "CombineControl.ChatNormal", text, { CB_ALL, CB_OOC } );
			end
		end
		
	end
	
	return true;
	
end

if( !chat.OldAddText ) then

	chat.OldAddText = chat.AddText;

	function chat.AddText( ... )
		
		local args = { ... };
		
		local col;
		local str = "";
		
		for k, v in pairs( args ) do
			
			if( type( v ) == "table" and !col ) then
				
				col = v;
				
			elseif( type( v ) == "string" ) then
				
				str = str .. v;
				
			elseif( type( v ) == "Player" ) then
				
				str = str .. v:Nick();
				
			end
			
		end
		
		GAMEMODE:AddChat( col, "CombineControl.ChatNormal", str, { CB_ALL, CB_OOC } );
		
	end
	
end
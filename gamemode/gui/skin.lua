local meta = FindMetaTable( "Panel" );

local matHover = Material( "vgui/spawnmenu/hover" );

function meta:DrawSelections()

	if ( !self.m_bSelectable ) then return end
	if ( !self.m_bSelected ) then return end
	
	surface.SetDrawColor( 255, 255, 255, 255 );
	surface.SetMaterial( matHover );
	self:DrawTexturedRect();

end

function GM:ForceDermaSkin()
	
	return "CombineControl";
	
end

function CCFramePerformLayout( self )
	
	if( self.btnClose and self.btnClose:IsValid() ) then
		
		self.btnClose:SetPos( self:GetWide() - 24, 0 );
		self.btnClose:SetSize( 24, 24 );
		self.btnClose:SetFont( "marlett" );
		self.btnClose:SetText( "r" );
		self.btnClose:PerformLayout();
		
	end
	
	if( self.btnMaxim and self.btnMaxim:IsValid() ) then
		
		self.btnMaxim:Remove();
		
	end
	
	if( self.btnMinim and self.btnMinim:IsValid() ) then
		
		self.btnMinim:Remove();
		
	end
	
	if( self.lblTitle and self.lblTitle:IsValid() ) then
		
		self.lblTitle:SetPos( 6, 0 )
		self.lblTitle:SetSize( self:GetWide() - 25, 24 )
		
	end
	
end

function CCSliderPerformLayout( self )
	
	if( self.Label and self.Label:IsValid() ) then
		
		self.Label:SetFont( "CombineControl.LabelSmall" );
		
	end
	
	if( self.TextArea and self.TextArea:IsValid() ) then
		
		self.TextArea:SetFont( "CombineControl.LabelSmall" );
		
	end
	
end

SKIN = { }

SKIN.fontFrame		= "CombineControl.Window"
SKIN.fontTab		= "CombineControl.Window"

SKIN.GwenTexture	= Material( "gwenskin/GModDefault.png" );

SKIN.control_color 				= Color( 255, 255, 255, 255 )
SKIN.control_color_highlight	= Color( 150, 150, 150, 255 )
SKIN.control_color_active 		= Color( 255, 10, 10, 255 )
SKIN.control_color_bright 		= Color( 90, 90, 90, 255 )
SKIN.control_color_dark 		= Color( 40, 40, 40, 255 )

SKIN.Colours = {}

SKIN.Colours.Window = {}
SKIN.Colours.Window.TitleActive			= Color( 200, 200, 200, 255 );
SKIN.Colours.Window.TitleInactive		= Color( 200, 200, 200, 255 );

SKIN.Colours.Button = {}
SKIN.Colours.Button.Normal				= Color( 200, 200, 200, 255 );
SKIN.Colours.Button.Hover				= Color( 255, 255, 255, 255 );
SKIN.Colours.Button.Down				= Color( 255, 0, 0, 255 );
SKIN.Colours.Button.Disabled			= Color( 150, 150, 150, 255 );

SKIN.Colours.Label = { }
SKIN.Colours.Label.Default		= Color( 200, 200, 200, 255 );
SKIN.Colours.Label.Bright		= Color( 255, 255, 255, 255 );
SKIN.Colours.Label.Dark			= Color( 150, 150, 150, 255 );
SKIN.Colours.Label.Highlight	= Color( 255, 0, 0, 255 );

SKIN.Colours.Tab = {}
SKIN.Colours.Tab.Active = {}
SKIN.Colours.Tab.Active.Normal			= GWEN.TextureColor( 4 + 8 * 4, 508 );
SKIN.Colours.Tab.Active.Hover			= GWEN.TextureColor( 4 + 8 * 5, 508 );
SKIN.Colours.Tab.Active.Down			= GWEN.TextureColor( 4 + 8 * 4, 500 );
SKIN.Colours.Tab.Active.Disabled		= GWEN.TextureColor( 4 + 8 * 5, 500 );

SKIN.Colours.Tab.Inactive = {}
SKIN.Colours.Tab.Inactive.Normal		= GWEN.TextureColor( 4 + 8 * 6, 508 );
SKIN.Colours.Tab.Inactive.Hover			= GWEN.TextureColor( 4 + 8 * 7, 508 );
SKIN.Colours.Tab.Inactive.Down			= GWEN.TextureColor( 4 + 8 * 6, 500 );
SKIN.Colours.Tab.Inactive.Disabled		= GWEN.TextureColor( 4 + 8 * 7, 500 );

SKIN.Colours.Tree = {}
SKIN.Colours.Tree.Lines					= Color( 160, 160, 160, 255 );		---- !!!
SKIN.Colours.Tree.Normal				= Color( 160, 160, 160, 255 );
SKIN.Colours.Tree.Hover					= Color( 255, 255, 255, 255 );
SKIN.Colours.Tree.Selected				= Color( 200, 200, 200, 255 );

SKIN.Colours.Properties = {}
SKIN.Colours.Properties.Line_Normal			= GWEN.TextureColor( 4 + 8 * 12, 508 );
SKIN.Colours.Properties.Line_Selected		= GWEN.TextureColor( 4 + 8 * 13, 508 );
SKIN.Colours.Properties.Line_Hover			= GWEN.TextureColor( 4 + 8 * 12, 500 );
SKIN.Colours.Properties.Title				= GWEN.TextureColor( 4 + 8 * 13, 500 );
SKIN.Colours.Properties.Column_Normal		= GWEN.TextureColor( 4 + 8 * 14, 508 );
SKIN.Colours.Properties.Column_Selected		= GWEN.TextureColor( 4 + 8 * 15, 508 );
SKIN.Colours.Properties.Column_Hover		= GWEN.TextureColor( 4 + 8 * 14, 500 );
SKIN.Colours.Properties.Border				= GWEN.TextureColor( 4 + 8 * 15, 500 );
SKIN.Colours.Properties.Label_Normal		= GWEN.TextureColor( 4 + 8 * 16, 508 );
SKIN.Colours.Properties.Label_Selected		= GWEN.TextureColor( 4 + 8 * 17, 508 );
SKIN.Colours.Properties.Label_Hover			= GWEN.TextureColor( 4 + 8 * 16, 500 );

SKIN.Colours.Category = {}
SKIN.Colours.Category.Header				= GWEN.TextureColor( 4 + 8 * 18, 500 );
SKIN.Colours.Category.Header_Closed			= GWEN.TextureColor( 4 + 8 * 19, 500 );
SKIN.Colours.Category.Line = {}
SKIN.Colours.Category.Line.Text				= GWEN.TextureColor( 4 + 8 * 20, 508 );
SKIN.Colours.Category.Line.Text_Hover		= GWEN.TextureColor( 4 + 8 * 21, 508 );
SKIN.Colours.Category.Line.Text_Selected	= GWEN.TextureColor( 4 + 8 * 20, 500 );
SKIN.Colours.Category.Line.Button			= GWEN.TextureColor( 4 + 8 * 21, 500 );
SKIN.Colours.Category.Line.Button_Hover		= GWEN.TextureColor( 4 + 8 * 22, 508 );
SKIN.Colours.Category.Line.Button_Selected	= GWEN.TextureColor( 4 + 8 * 23, 508 );
SKIN.Colours.Category.LineAlt = {}
SKIN.Colours.Category.LineAlt.Text				= GWEN.TextureColor( 4 + 8 * 22, 500 );
SKIN.Colours.Category.LineAlt.Text_Hover		= GWEN.TextureColor( 4 + 8 * 23, 500 );
SKIN.Colours.Category.LineAlt.Text_Selected		= GWEN.TextureColor( 4 + 8 * 24, 508 );
SKIN.Colours.Category.LineAlt.Button			= GWEN.TextureColor( 4 + 8 * 25, 508 );
SKIN.Colours.Category.LineAlt.Button_Hover		= GWEN.TextureColor( 4 + 8 * 24, 500 );
SKIN.Colours.Category.LineAlt.Button_Selected	= GWEN.TextureColor( 4 + 8 * 25, 500 );

SKIN.colTextEntryText			= Color( 200, 200, 200, 255 )
SKIN.colTextEntryTextHighlight	= Color( 40, 40, 40, 255 )
SKIN.colTextEntryTextCursor		= Color( 200, 200, 200, 255 )

SKIN.Colours.TooltipText	= Color( 200, 200, 200, 255 );

SKIN.PrintName 		= "CombineControl"
SKIN.Author 		= "disseminate"
SKIN.DermaVersion	= 1

function SKIN:PaintFrame( panel, w, h )
	
	draw.RoundedBox( 0, 0, 0, w, h, Color( 30, 30, 30, 230 ) );
	draw.RoundedBox( 0, 0, 0, w, 24, Color( 20, 20, 20, 255 ) );
	surface.DrawOutlinedRect( 0, 0, w, h );
	
end

function SKIN:PaintButton( panel, w, h )
	
	if ( !panel.m_bBackground ) then return end
	
	surface.SetDrawColor( 40, 40, 40, 255 );
	surface.DrawRect( 0, 0, w, h );
	
	if ( panel:GetDisabled() ) then
		surface.SetDrawColor( 30, 30, 30, 255 );
		surface.DrawRect( 1, 1, w - 2, h - 2 );
		return;
	end	
	
	surface.SetDrawColor( 60, 60, 60, 255 );
	surface.DrawRect( 1, 1, w - 2, h - 2 );

end

function SKIN:PaintWindowCloseButton( panel, w, h )

	
	
end

function SKIN:PaintTextEntry( panel, w, h )
	
	local w, h = panel:GetSize();
	
	if( panel:GetDrawBackground() ) then
		
		surface.SetDrawColor( 30, 30, 30, 255 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 40, 40, 40, 255 );
		surface.DrawRect( 1, 1, w - 2, h - 2 );
		
	end
	
	panel:DrawTextEntryText( panel:GetTextColor(), panel:GetHighlightColor(), panel:GetCursorColor() );
	
end

function SKIN:PaintButtonDown( panel, w, h )
	
	if( !panel.LaidOut ) then
		
		panel.LaidOut = true;
		panel:SetText( "u" );
		panel:SetFont( "marlett" );
		
	end
	
	self:PaintButton( panel, w, h );

end

function SKIN:PaintButtonUp( panel, w, h )
	
	if( !panel.LaidOut ) then
		
		panel.LaidOut = true;
		panel:SetText( "t" );
		panel:SetFont( "marlett" );
		
	end
	
	self:PaintButton( panel, w, h );

end

function SKIN:PaintVScrollBar( panel, w, h )

	--self.tex.Scroller.TrackV( 0, 0, w, h );	

end

function SKIN:PaintScrollBarGrip( panel, w, h )

	self:PaintButton( panel, w, h );

end

function SKIN:PaintListView( panel, w, h )

	surface.SetDrawColor( 30, 30, 30, 255 );
	surface.DrawRect( 0, 0, w, h );
	
	surface.SetDrawColor( 20, 20, 20, 100 );
	surface.DrawOutlinedRect( 0, 0, w, h );

end

function SKIN:PaintListViewLine( panel, w, h )
	
	if ( panel:IsSelected() ) then

		surface.SetDrawColor( 60, 60, 60, 255 );
		surface.DrawRect( 0, 0, w, h );
	 
	elseif ( panel.Hovered ) then

		surface.SetDrawColor( 50, 50, 50, 255 );
		surface.DrawRect( 0, 0, w, h );
		
	elseif ( panel.m_bAlt ) then

		surface.SetDrawColor( 40, 40, 40, 255 );
		surface.DrawRect( 0, 0, w, h );
	    
	end

end

function SKIN:PaintComboDownArrow( panel, w, h )
	
	draw.DrawText( "u", "marlett", 0, 0, Color( 200, 200, 200, 255 ) );

end

function SKIN:PaintComboBox( panel, w, h )
	
	surface.SetDrawColor( 30, 30, 30, 255 );
	surface.DrawRect( 0, 0, w, h );
	
	if( panel.Depressed or panel:IsMenuOpen() ) then
		
		surface.SetDrawColor( 60, 60, 60, 255 );
		surface.DrawRect( 1, 1, w - 2, h - 2 );
		
	elseif( panel:GetDisabled() ) then

		surface.SetDrawColor( 30, 30, 30, 255 );
		surface.DrawRect( 1, 1, w - 2, h - 2 );
	    
	else
		
		surface.SetDrawColor( 40, 40, 40, 255 );
		surface.DrawRect( 1, 1, w - 2, h - 2 );
		
	end
	
end

function SKIN:PaintMenu( panel, w, h )
	
	local odd = true;
	
	for i = 0, h, 22 do
		
		if( odd ) then
			
			surface.SetDrawColor( 40, 40, 40, 255 );
			surface.DrawRect( 0, i, w, 22 );
			
		else
			
			surface.SetDrawColor( 50, 50, 50, 255 );
			surface.DrawRect( 0, i, w, 22 );
			
		end
		
		odd = !odd;
		
	end
	
end

function SKIN:PaintMenuOption( panel, w, h )
	
	if( !panel.LaidOut ) then
		
		panel.LaidOut = true;
		panel:SetFont( "CombineControl.LabelSmall" );
		panel:SetTextColor( Color( 200, 200, 200, 255 ) );
		
	end
	
	if( panel.m_bBackground and ( panel.Hovered or panel.Highlight ) ) then
		
		surface.SetDrawColor( 70, 70, 70, 255 );
		surface.DrawRect( 0, 0, w, h );
		
	end
	
	self.MenuOptionOdd = !self.MenuOptionOdd;
	
	if( panel:GetChecked() ) then
		
		self.tex.Menu_Check( 5, h / 2 - 7, 15, 15 );
		
	end
	
end

SKIN.BulletMat = Material( "icon16/bullet_white.png" );

function SKIN:PaintCCTreeNode( panel, w, h )
	
	if( panel.GetDrawIcon and panel:GetDrawIcon() ) then
		
		local vCol = panel:GetIconColor();
		
		if( vCol ) then
			
			surface.SetDrawColor( vCol.x, vCol.y, vCol.z, 255 );
			surface.DrawRect( panel.Expander.x + panel.Expander:GetWide() + 4, (panel:GetLineHeight() - 16) * 0.5, 16, 16 );
			
		else
			
			surface.SetMaterial( self.BulletMat );
			
			local iconCol = panel:GetBulletColor();
			
			if( iconCol ) then
				
				surface.SetDrawColor( iconCol.x, iconCol.y, iconCol.z, 255 );
				
			else
				
				surface.SetDrawColor( 255, 255, 255, 255 );
				
			end
			
			surface.DrawTexturedRect( panel.Expander.x + panel.Expander:GetWide() + 4, (panel:GetLineHeight() - 16) * 0.5, 16, 16 );
			
		end
		
	end
	
end

function SKIN:PaintCCTreeNodeButton( panel, w, h )

	if ( !panel.m_bSelected ) then return end
	
	local w, _ = panel:GetTextSize() 
	
	surface.SetDrawColor( 100, 40, 40, 200 );
	surface.DrawRect( 38, 0, w + 6, h );

end

derma.DefineSkin( "CombineControl", "", SKIN );

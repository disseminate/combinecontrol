PANEL = { };

AccessorFunc( PANEL, "m_colText", 				"TextColor" );
AccessorFunc( PANEL, "m_colTextStyle", 			"TextStyleColor" )
AccessorFunc( PANEL, "m_FontName", 				"Font" )

PANEL.SetColor = PANEL.SetTextColor;

function PANEL:GetColor()

	return self.m_colTextStyle

end

function PANEL:SetText( t )
	
	self.FakeText = t;
	
	surface.SetFont( self.m_FontName );
	local h = GAMEMODE.FontHeight[self.m_FontName];
	
	if( !self.ChildLabels ) then
		
		self.ChildLabels = { };
		
	end
	
	for _, v in pairs( self.ChildLabels ) do
		
		v:Remove();
		
	end
	
	self.ChildLabels = { };
	
	local lines = string.Explode( "\n", GAMEMODE:FormatLine( self.FakeText or "", self.m_FontName, self:GetWide() ) );
	local s = 1;
	
	local y = 0;
	
	for k, v in pairs( lines ) do
		
		local label = vgui.Create( "DLabel", self );
		label:SetText( v );
		label:SetSize( self:GetWide(), h );
		label:SetPos( 0, y );
		label:SetFont( self.m_FontName );
		label:SetAutoStretchVertical( true );
		label:SetWrap( true );
		label:PerformLayout();
		table.insert( self.ChildLabels, label );
		
		y = y + h;
		
	end
	
end

function PANEL:Paint( w, h )
	
	
	
end

function PANEL:PerformLayout()
	
	self:SizeToContentsY();
	
end

function PANEL:SizeToContentsY()
	
	local y = 0;
	
	for k, v in pairs( self.ChildLabels ) do
		
		v:SetPos( 0, y );
		y = y + v:GetTall();
		
	end
	
	self:SetTall( y );
	
end

derma.DefineControl( "CCLabel", "", PANEL, "DPanel" )

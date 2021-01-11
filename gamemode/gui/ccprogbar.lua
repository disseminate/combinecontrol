PANEL = {}

AccessorFunc( PANEL, "m_Progress", "Progress" );
AccessorFunc( PANEL, "m_ProgressText", "ProgressText" );

function PANEL:Init()
	
	self:SetProgress( 0 );
	self:SetProgressText( "" );
	
end

function PANEL:Paint( w, h )
	
	surface.SetDrawColor( 40, 40, 40, 150 );
	surface.DrawRect( 0, 0, w, h );
	
	surface.SetDrawColor( 30, 30, 30, 100 );
	surface.DrawOutlinedRect( 0, 0, w, h );
	
	if( self:GetProgress() > 0 ) then
		
		surface.SetDrawColor( 150, 20, 20, 255 );
		surface.DrawRect( 1, 1, ( w - 2 ) * math.min( self:GetProgress(), 1 ), h - 2 );
		
	end
	
	surface.SetTextColor( 200, 200, 200, 255 );
	surface.SetFont( "CombineControl.LabelSmall" );
	
	local x, y = surface.GetTextSize( self:GetProgressText() );
	
	surface.SetTextPos( w / 2 - x / 2, h / 2 - y / 2 );
	
	surface.DrawText( self:GetProgressText() );
	
	return true

end

derma.DefineControl( "CCProgressBar", "", PANEL, "DPanel" )
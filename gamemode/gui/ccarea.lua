PANEL = {}

function PANEL:Init()
	
	
	
end

function PANEL:Paint( w, h )

	surface.SetDrawColor( 0, 0, 0, 70 );
	surface.DrawRect( 0, 0, w, h );
	
	surface.SetDrawColor( 0, 0, 0, 100 );
	surface.DrawOutlinedRect( 0, 0, w, h );
	
	return true

end

derma.DefineControl( "CCArea", "", PANEL, "DPanel" )
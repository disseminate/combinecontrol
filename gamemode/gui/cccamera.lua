PANEL = {}

AccessorFunc( PANEL, "m_OriginX", "OriginX", FORCE_NUMBER );
AccessorFunc( PANEL, "m_OriginY", "OriginY", FORCE_NUMBER );
AccessorFunc( PANEL, "m_OriginZ", "OriginZ", FORCE_NUMBER );

AccessorFunc( PANEL, "m_AngX", "AngX", FORCE_NUMBER );
AccessorFunc( PANEL, "m_AngY", "AngY", FORCE_NUMBER );
AccessorFunc( PANEL, "m_AngZ", "AngZ", FORCE_NUMBER );

AccessorFunc( PANEL, "m_FOV", "FOV", FORCE_NUMBER );

function PANEL:Init()
	
	
	
end

function PANEL:Paint( w, h )
	
	local oldW, oldH = ScrW(), ScrH();
	local x, y = self:GetParent():GetPos();
	local x2, y2 = self:GetPos();
	
	x = x + x2;
	y = y + y2;
	
	render.SetViewPort( x, y, w, h );
	cam.Start2D();
		
		local tab = { };
		tab.origin = Vector( self:GetOriginX(), self:GetOriginY(), self:GetOriginZ() );
		tab.angles = Angle( self:GetAngX(), self:GetAngY(), self:GetAngZ() );
		tab.aspectratio = w / h;
		tab.x = x;
		tab.y = y;
		tab.w = w;
		tab.h = h;
		tab.dopostprocess = false;
		tab.drawhud = false;
		tab.drawmonitors = true;
		tab.drawviewmodel = false;
		tab.fov = self:GetFOV();
		tab.ortho = false;
		
		render.RenderView( tab );
		
	cam.End2D();
	render.SetViewPort( 0, 0, oldW, oldH );
	
	return true

end

derma.DefineControl( "CCCamera", "", PANEL, "DPanel" )
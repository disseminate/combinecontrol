PANEL = { };

function PANEL:Init()
	
	self.ContentScroll = vgui.Create( "DScrollPanel", self );
	self.ContentScroll:SetPos( 10, 40 );
	self.ContentScroll:SetSize( GAMEMODE.ChatWidth - 20, cookie.GetNumber( "cc_chatheight", 300 ) - 80 );
	function self.ContentScroll:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, 70 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 0, 0, 0, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	self.Content = vgui.Create( "EditablePanel" );
	self.Content:SetPos( 0, 0 );
	self.Content:SetSize( GAMEMODE.ChatWidth - 20, 20 );
	self.Content.Paint = function( content, pw, ph )
		
		local y = 0;
		
		for k, v in pairs( GAMEMODE.ChatLines ) do
			
			local color = v[1];
			local font = v[2];
			local text = v[3];
			local filter = v[4];
			local start = v[5];
			local ply = v[6];
			local formatted = v[7];
			
			if( table.HasValue( filter, GAMEMODE.ChatboxFilter ) ) then
				
				local h = GAMEMODE.FontHeight[font];
				
				local expl = string.Explode( "\n", formatted );
				
				for _, v in pairs( expl ) do
					
					local ch = GAMEMODE.FontHeight[font];
					local mx, my = self.ContentScroll:GetCanvas():GetPos();
					
					if( my + y > -20 ) then
						
						draw.DrawTextShadow( string.sub( v, 1, 196 ), font, 0, y, color, Color( 0, 0, 0, 255 ), 0 );
						
					end
					
					y = y + ch;
					
				end
				
			end
			
		end
		
		if( ph != math.max( y, 20 ) ) then
			
			content:SetTall( math.max( y, 20 ) );
			self.ContentScroll:PerformLayout();
			
			if( self.ContentScroll.VBar ) then
				
				self.ContentScroll.VBar:SetScroll( math.huge );
				
			end
			
		end
		
	end
	
	self.ContentScroll:AddItem( self.Content );
	
end

function PANEL:Paint( w, h )

	draw.RoundedBox( 0, 0, 0, w, h, Color( 30, 30, 30, 200 ) );
	
	return true

end

derma.DefineControl( "CCChat", "", PANEL, "EditablePanel" );
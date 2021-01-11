function GM:OnReloaded()
	
	if( CLIENT ) then
		
		if( !self.NextReloadSound ) then self.NextReloadSound = 0 end
		if( CurTime() > self.NextReloadSound ) then
			
			surface.PlaySound( "buttons/combine_button1.wav" );
			self.NextReloadSound = CurTime() + 1;
			
		end
		
	end
	
	self.BaseClass:OnReloaded();
	
	if( CLIENT ) then
		
		derma.RefreshSkins();
		
	end
	
end

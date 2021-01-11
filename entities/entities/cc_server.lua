ENT.Type = "point";
ENT.Base = "base_point";

function ENT:Think()
	
	for _, v in pairs( player.GetAll() ) do
		
		if( self.CP and !v:HasAnyCombineFlag() ) then continue; end
		
		local d = v:GetPos():Distance( self:GetPos() );
		
		if( d < self.Radius ) then
			
			if( !v.LastServerOffer ) then v.LastServerOffer = CurTime() end
			
			if( CurTime() >= v.LastServerOffer + 1 ) then
				
				net.Start( "nServerOffer" );
					net.WriteUInt( self.Location, 5 );
					net.WriteUInt( self.Port or 1, 5 );
				net.Send( v );
				
			end
			
		end
		
	end
	
end
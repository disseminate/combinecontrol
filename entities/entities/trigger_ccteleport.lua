ENT.Type = "brush";
ENT.Base = "base_brush";

function ENT:Touch( e )
	
	if( e:GetParent() and e:GetParent():IsValid() ) then return end
	if( e:IsPlayer() and e:GetVehicle() and e:GetVehicle():IsValid() ) then return end
	
	if( self.Landmark and self.Landmark2 ) then
		
		local close = ents.FindByName( self.Landmark )[1];
		local far = ents.FindByName( self.Landmark2 )[1];
		
		if( close and close:IsValid() and far and far:IsValid() ) then
			
			local delta = far:GetPos() - close:GetPos();
			e:SetPos( e:GetPos() + delta );
			
			for _, v in pairs( constraint.GetAllConstrainedEntities( e ) ) do
				
				v:SetPos( v:GetPos() + delta );
				
			end
			
		end
		
	end
	
end

function ENT:KeyValue( key, value )
	
	if( key == "landmark" ) then
		
		self.Landmark = value;
		
	end
	
	if( key == "landmark2" ) then
		
		self.Landmark2 = value;
		
	end
	
end

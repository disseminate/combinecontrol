ITEM.ID				= "bigradio";
ITEM.Name			= "Radio";
ITEM.Description	= "A large radio.";
ITEM.Model			= "models/props_lab/citizenradio.mdl";
ITEM.Weight 		= 10;
ITEM.FOV 			= 42;
ITEM.CamPos 		= Vector( 50, 0.66, 11.39 );
ITEM.LookAt 		= Vector( 0, 0, 7.63 );

ITEM.BulkPrice		= 400;
ITEM.License		= LICENSE_BLACK;

ITEM.Usable			= true;
ITEM.UseText		= "Place";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( SERVER ) then
		
		local trace = { };
		trace.start = ply:GetShootPos();
		trace.endpos = trace.start + ply:GetAimVector() * 50;
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );
		
		local e = ents.Create( "cc_radio" );
		e:SetPos( tr.HitPos + tr.HitNormal * 10 );
		e:SetAngles( Angle() );
		e:Spawn();
		e:Activate();
		e:SetDeployer( ply:CharID() );
		
		e:SetPropSteamID( ply:SteamID() );
		
	end
	
end
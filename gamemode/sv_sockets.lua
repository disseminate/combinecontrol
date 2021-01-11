local meta = FindMetaTable( "Player" );

function meta:GoToServer( location, port )
	
	self:UpdateCharacterField( "Location", location );
	self:UpdateCharacterField( "EntryPort", port );
	
	net.Start( "nConnect" );
		
		if( location == LOCATION_CITY ) then
			
			net.WriteString( IP_GENERAL .. ":" .. PORT_CITY );
			
		elseif( location == LOCATION_CANAL ) then
			
			net.WriteString( IP_GENERAL .. ":" .. PORT_CANAL );
			
		elseif( location == LOCATION_OUTLANDS ) then
			
			net.WriteString( IP_GENERAL .. ":" .. PORT_OUTLANDS );
			
		elseif( location == LOCATION_COAST ) then
			
			net.WriteString( IP_GENERAL .. ":" .. PORT_COAST );
			
		end
		
	net.Send( self );
	
end

function GM:CreateLocationPoint( pos, loc, rad, port, cp )
	
	local c = ents.Create( "cc_server" );
	c:SetPos( pos );
	c:Spawn();
	c:Activate();
	c.Location = loc;
	c.Port = port;
	c.Radius = rad or 256;
	c.CP = cp;
	
end

function nServerOfferAccept( len, ply )
	
	local loc = net.ReadUInt( 5 );
	local port = net.ReadUInt( 5 );
	local good = false;
	
	for _, v in pairs( ents.FindByClass( "cc_server" ) ) do
		
		if( v.Location == loc and v:GetPos():Distance( ply:GetPos() ) <= 256 ) then
			
			good = true;
			break;
			
		end
		
	end
	
	if( !good ) then return end
	
	ply:GoToServer( loc, port );
	
end
net.Receive( "nServerOfferAccept", nServerOfferAccept );
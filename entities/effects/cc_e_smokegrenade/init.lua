function EFFECT:Init( data )
	
	local o = data:GetOrigin();
	
	if( GAMEMODE.Emitter2D ) then
		
		for i = 0, 5, 0.02 do
			
			timer.Simple( i, function()
				
				local d = math.Rand( 0, 360 );
				local x = math.cos( d );
				local y = math.sin( d );
				local v = Vector( math.random( 0, 500 ) * x, math.random( 0, 500 ) * y, math.random( 0, 600 ) );
				
				local p = GAMEMODE.Emitter2D:Add( "particle/particle_smokegrenade", o );
				p:SetRoll( math.Rand( 0, 360 ) );
				p:SetRollDelta( math.Rand( -0.5, 0.5 ) );
				p:SetDieTime( 20 );
				p:SetStartAlpha( 255 );
				p:SetEndAlpha( 0 );
				p:SetStartSize( math.random( 50, 10 ) );
				p:SetEndSize( math.random( 100, 200 ) );
				p:SetColor( 255, 255, 255 );
				p:SetVelocity( v );
				p:SetAirResistance( 100 );
				p:SetGravity( Vector( 0, 0, 0 ) );
				p:SetCollide( true );
				p:SetBounce( 0.2 );
				
			end );
			
		end
		
	end
	
end

function EFFECT:Think()
	
	return false;
	
end

function EFFECT:Render()
	
	
	
end

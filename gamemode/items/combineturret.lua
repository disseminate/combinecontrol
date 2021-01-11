ITEM.ID				= "combineturret";
ITEM.Name			= "Combine Turret";
ITEM.Description	= "The Combine Sentry Gun is a fully autonomous tripod-based pulse weapon used to guard vital areas.";
ITEM.Model			= "models/combine_turrets/floor_turret.mdl";
ITEM.Weight 		= 10;
ITEM.FOV 			= 50;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0.03, 0.13, 20.75 );

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
		
		local trace = { };
		trace.start = tr.HitPos - tr.Normal * 4;
		trace.endpos = trace.start - Vector( 0, 0, 72 );
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );
		
		local ent = ents.Create( "npc_turret_floor" );
		ent:SetPos( tr.HitPos );
		ent:SetAngles( ply:GetAngles() );
		--ent:SetKeyValue( "spawnflags", SF_FLOOR_TURRET_CITIZEN );
		ent:Spawn();
		ent:Activate();
		
	end
	
end
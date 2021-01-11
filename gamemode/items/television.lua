ITEM.ID				= "television";
ITEM.Name			= "Television";
ITEM.Description	= "A basic color TV.";
ITEM.Model			= "models/props_c17/tv_monitor01.mdl";
ITEM.Weight 		= 15;
ITEM.FOV 			= 20;
ITEM.CamPos 		= Vector( 50, 50, 37.78 );
ITEM.LookAt 		= Vector( 4, 0, 0 );

ITEM.BulkPrice		= 300;
ITEM.License		= LICENSE_ELECTRONICS;

ITEM.Usable			= true;
ITEM.UseText		= "Place";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( SERVER ) then
		
		local trace = { };
		trace.start = ply:GetShootPos();
		trace.endpos = trace.start + ply:GetAimVector() * 60;
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );
		
		GAMEMODE:CreateTV( tr.HitPos + tr.Normal * -10, ( -tr.Normal ):Angle(), false, ply:CharID() );
		
	end
	
end

ITEM.ProcessEntity = function( self, ent )
	
	local s = ents.Create( "prop_physics" );
	s:SetPos( ent:GetPos() );
	s:SetAngles( ent:GetAngles() );
	s:SetModel( "models/props_c17/tv_monitor01_screen.mdl" );
	s:SetParent( ent );
	s:SetSolid( SOLID_NONE );
	s:SetMoveType( MOVETYPE_NONE );
	s:Spawn();
	s:Activate();
	
	ent:DeleteOnRemove( s );
	
end
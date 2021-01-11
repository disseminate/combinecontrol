AddCSLuaFile();

ENT.Base = "cc_grenade_frag";
ENT.Type = "anim";

ENT.PrintName		= "";
ENT.Author			= "";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= false;
ENT.AdminSpawnable		= false;

function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:Explode( tr )
	
	if( tr.Fraction != 1.0 ) then
		
		self:SetPos( tr.HitPos + tr.Normal * 0.6 );
		
	end
	
	local ed = EffectData();
		ed:SetOrigin( self:GetPos() + Vector( 0, 0, 1 ) );
	util.Effect( "cc_e_smokegrenade", ed );
	
	self:EmitSound( "ambient/gas/steam2.wav" );
	self:Fire( "Kill", "", 5 );
	
end

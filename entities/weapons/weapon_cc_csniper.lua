AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Combine Sniper";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 12;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_irifle.mdl";
SWEP.WorldModel 	= "models/weapons/w_irifle.mdl";

SWEP.Firearm				= true;

SWEP.Primary.ClipSize 		= 1;
SWEP.Primary.DefaultClip 	= 1;
SWEP.Primary.Ammo			= "cc_ar2";
SWEP.Primary.InfiniteAmmo	= true;
SWEP.Primary.Automatic		= true;
SWEP.Primary.Sound			= { "NPC_Sniper.FireBullet", "NPC_Sniper.SonicBoom" };
SWEP.Primary.Damage			= 100;
SWEP.Primary.Force			= 15;
SWEP.Primary.Accuracy		= 0.01;
SWEP.Primary.Delay			= 1;
SWEP.Primary.ViewPunch		= Angle( -20, 0, 0 );
SWEP.Primary.ReloadSound	= "NPC_Sniper.Reload";
SWEP.Primary.TracerName		= "AR2Tracer";

SWEP.HoldType = "ar2";
SWEP.HoldTypeHolster = "passive";

SWEP.Holsterable = true;

SWEP.HolsterPos = Vector( 13.11, -4.69, -25.91 );
SWEP.HolsterAng = Vector( 6.19, 80.14, 0 );

SWEP.AimPos = Vector( -5.87, 1.42, -13.96 );
SWEP.AimAng = Vector( 0, 0, 0 );

SWEP.Itemize = true;
SWEP.ItemDescription = "The Overwatch Accelerated Pulse Rifle. Using deadly pulse rounds, this modified AR2 rifle is designed to accelerate ammunition for long-range purposes.";
SWEP.ItemWeight = 7;
SWEP.ItemFOV = 43;
SWEP.ItemCamPos = Vector( -1.12, 50, -0.82 );
SWEP.ItemLookAt = Vector( 5.09, 0, 0 );

SWEP.Scoped = true;

if( CLIENT ) then

	SWEP.LaserMat = Material( "effects/bluelaser1" );
	
	local tab = { };
	tab[ "$basetexture" ] = "sprites/light_glow03";
	tab[ "$additive" ] = 1;
	tab[ "$translucent" ] = 1;
	tab[ "$vertexcolor" ] = 1;
	SWEP.SpriteMat = CreateMaterial( "csniper_sprite", "UnlitGeneric", tab );
	
end

function SWEP:PreDrawViewModel( vm, ply, wep )
	
	if( !self.Owner:Holstered() and self.IronMode < IRON_AIM and self.IronMode >= IRON_IDLE and self:GetNextPrimaryFire() <= CurTime() and self:Clip1() > 0 ) then
		
		if( self.Owner:InVehicle() ) then return end
		if( self.Owner:GetNoDraw() ) then return end
		if( hook.Call( "ShouldDrawLocalPlayer", GAMEMODE, self.Owner ) ) then return end
		
		render.SetMaterial( self.LaserMat );
		render.DrawBeam( vm:GetAttachment( 1 ).Pos, self.Owner:GetEyeTrace().HitPos, 1, 0, 1, Color( 0, 100, 255, 255 ) );
		render.SetMaterial( self.SpriteMat );
		render.DrawSprite( self.Owner:GetEyeTrace().HitPos, 4, 4, Color( 50, 190, 255, 255 ) );
		
	end
	
	if( self.Scoped ) then
		
		if( self.IronMode == IRON_AIM ) then
			
			vm:SetMaterial( "engine/occlusionproxy" );
			
		else
			
			vm:SetMaterial( "" );
			
		end
		
	else
		
		vm:SetMaterial( "" );
		
	end
	
end

function SWEP:PostDrawOpaqueRenderables()
	
	if( self.Owner == LocalPlayer() and LocalPlayer():GetViewEntity() == LocalPlayer() and !hook.Call( "ShouldDrawLocalPlayer", GAMEMODE, self.Owner ) ) then return end
	
	if( self.Owner:InVehicle() ) then return end
	if( self.Owner:GetNoDraw() ) then return end
	
	if( !self.Owner:Holstered() and self:GetNextPrimaryFire() <= CurTime() and self:Clip1() > 0 ) then
		
		render.SetMaterial( self.LaserMat );
		render.DrawBeam( self:GetAttachment( 1 ).Pos, self.Owner:GetEyeTrace().HitPos, 1, 0, 1, Color( 0, 100, 255, 255 ) );
		render.SetMaterial( self.SpriteMat );
		render.DrawSprite( self.Owner:GetEyeTrace().HitPos, 4, 4, Color( 50, 190, 255, 255 ) );
		
	end
	
end

function SWEP:AddViewKick()
	
	self.Owner:ViewPunch( Angle( math.Rand( -18, -25 ), math.Rand( -2, 2 ), 0 ) );
	
end

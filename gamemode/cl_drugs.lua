local meta = FindMetaTable( "Player" );

local matWater = Material( "effects/water_warp01" );
local matDistort = Material( "effects/water_warp01" );

function meta:HasDrug( d )
	
	return GAMEMODE.DrugType == d;
	
end

function meta:DrugSpeedMod()
	
	local mul = 1;
	
	if( GAMEMODE.DrugType == DRUG_ANTLION ) then
		
		mul = mul * 1.5;
		
	end
	
	return mul;
	
end

function meta:DrugPerceptionMod()
	
	local mul = 0;
	
	if( GAMEMODE.DrugType == DRUG_BREEN ) then 
		
		mul = 50;
		
	end
	
	return mul;
	
end

function GM:DrawDrugs()
	
	if( self.DrugType ) then
		
		if( self.DrugType == DRUG_BREEN ) then
			
			local d = CurTime() - self.DrugStart;
			
			if( d <= 60 ) then
				
				local mul = 1;
				
				if( d < 4 ) then
					
					mul = d / 4;
					
				else
					
					mul = 1 - ( ( d - 4 ) / 56 );
					
				end
				
				draw.DrawBackgroundBlur( mul );
				surface.SetDrawColor( Color( 255, 255, 255, 20 * mul ) );
				surface.DrawRect( 0, 0, ScrW(), ScrH() );
				
			else
				
				self:ResetDrugFX();
				
			end
			
		end
		
		if( self.DrugType == DRUG_MEDKIT ) then
			
			local d = CurTime() - self.DrugStart;
			
			if( d <= 60 ) then
				
				local mul = 1;
				
				if( d < 4 ) then
					
					mul = d / 4;
					
				else
					
					mul = 1 - ( ( d - 4 ) / 56 );
					
				end
				
				DrawSharpen( 5 + math.sin( CurTime() * 10 ) * mul * 5, math.sin( CurTime() * 2 ) * mul );
				
			else
				
				self:ResetDrugFX();
				
			end
			
		end
		
		if( self.DrugType == DRUG_VODKA ) then
			
			local d = CurTime() - self.DrugStart;
			
			if( d <= 60 ) then
				
				local mul = 1;
				
				if( d < 4 ) then
					
					mul = d / 4;
					
				else
					
					mul = 1 - ( ( d - 4 ) / 56 );
					
				end
				
				render.SetBlend( mul );
				render.UpdateScreenEffectTexture();
				matWater:SetFloat( "$envmap", 0 );
				matWater:SetFloat( "$envmaptint", 0 );
				matWater:SetFloat( "$refractamount", math.sin( CurTime() * 3 ) * 0.5 * mul );
				matWater:SetInt( "$ignorez", 1 );
				render.SetMaterial( matWater );
				render.DrawScreenQuad();
				DrawSharpen( 5, math.sin( CurTime() * 2 ) * mul );
				
			else
				
				self:ResetDrugFX();
				
			end
			
		end
		
		if( self.DrugType == DRUG_EXTRACT ) then
			
			local d = CurTime() - self.DrugStart;
			
			if( d <= 60 ) then
				
				local mul = 1;
				
				if( d < 4 ) then
					
					mul = d / 4;
					
				else
					
					mul = 1 - ( ( d - 4 ) / 56 );
					
				end
				
				DrawSharpen( 5 + mul * 5, math.sin( CurTime() * 2 ) * mul );
				
			else
				
				self:ResetDrugFX();
				
			end
			
		end
		
	end
	
end

function GM:RenderScreenspaceDrugs()
	
	if( self.DrugType ) then
		
		if( self.DrugType == DRUG_MEDKIT ) then
			
			local d = CurTime() - self.DrugStart;
			
			if( d <= 60 ) then
				
				local mul = 1;
				
				if( d < 4 ) then
					
					mul = d / 4;
					
				else
					
					mul = 1 - ( ( d - 4 ) / 56 );
					
				end
				
				local tab = { };
				
				tab[ "$pp_colour_addr" ] 		= 0;
				tab[ "$pp_colour_addg" ] 		= 0;
				tab[ "$pp_colour_addb" ] 		= 0;
				tab[ "$pp_colour_brightness" ] 	= 0;
				tab[ "$pp_colour_contrast" ] 	= 1;
				tab[ "$pp_colour_colour" ] 		= 1 + 3 * mul;
				tab[ "$pp_colour_mulr" ] 		= 255 * mul;
				tab[ "$pp_colour_mulg" ] 		= 255 * mul;
				tab[ "$pp_colour_mulb" ] 		= 255 * mul;
				
				DrawColorModify( tab );
				
			else
				
				self:ResetDrugFX();
				
			end
			
		end
		
		if( self.DrugType == DRUG_ANTLION ) then
			
			local d = CurTime() - self.DrugStart;
			
			if( d <= 60 ) then
				
				local mul = 1;
				
				if( d < 4 ) then
					
					mul = d / 4;
					
				else
					
					mul = 1 - ( ( d - 4 ) / 56 );
					
				end
				
				local tab = { };
				
				tab[ "$pp_colour_addr" ] 		= 0;
				tab[ "$pp_colour_addg" ] 		= 0;
				tab[ "$pp_colour_addb" ] 		= 0;
				tab[ "$pp_colour_brightness" ] 	= 0;
				tab[ "$pp_colour_contrast" ] 	= 1 + 1 * mul * ( 1 - ( math.sin( CurTime() * 2 ) ^ 6 ) );
				tab[ "$pp_colour_colour" ] 		= 1;
				tab[ "$pp_colour_mulr" ] 		= 500 * mul * ( 1 - ( math.sin( CurTime() * 2 ) ^ 6 ) );
				tab[ "$pp_colour_mulg" ] 		= 0;
				tab[ "$pp_colour_mulb" ] 		= 0;
				
				DrawColorModify( tab );
				
				if( !render.SupportsPixelShaders_2_0() ) then return end
				DrawToyTown( 4, ScrH() * 0.5 );
				
			else
				
				self:ResetDrugFX();
				
			end
			
		end
		
		if( self.DrugType == DRUG_EXTRACT ) then
			
			local d = CurTime() - self.DrugStart;
			
			if( d <= 60 ) then
				
				local mul = 1;
				
				if( d < 4 ) then
					
					mul = d / 4;
					
				else
					
					mul = 1 - ( ( d - 4 ) / 56 );
					
				end
				
				local tab = { };
				
				tab[ "$pp_colour_addr" ] 		= 7 / 255 * mul;
				tab[ "$pp_colour_addg" ] 		= 7 / 255 * mul;
				tab[ "$pp_colour_addb" ] 		= 7 / 255 * mul;
				tab[ "$pp_colour_brightness" ] 	= -0.27 * mul;
				tab[ "$pp_colour_contrast" ] 	= 1 - 0.13 * mul * ( 1 - ( math.sin( CurTime() * 2 ) ^ 6 ) );
				tab[ "$pp_colour_colour" ] 		= 1 - 0.6 * mul;
				tab[ "$pp_colour_mulr" ] 		= 15 * mul * ( 1 - ( math.sin( CurTime() * 2 ) ^ 6 ) );
				tab[ "$pp_colour_mulg" ] 		= 182 * mul * ( 1 - ( math.sin( CurTime() * 2 ) ^ 6 ) );
				tab[ "$pp_colour_mulb" ] 		= 18 * mul * ( 1 - ( math.sin( CurTime() * 2 ) ^ 6 ) );
				
				DrawColorModify( tab );
				
			else
				
				self:ResetDrugFX();
				
			end
			
		end
		
	end
	
end

function GM:DrugPostDrawOpaqueRenderables()
	
	if( self.DrugType ) then
		
		if( self.DrugType == DRUG_ANTLION ) then
			
			local d = CurTime() - self.DrugStart;
			
			if( d <= 60 ) then
				
				local mul = 1;
				
				if( d < 4 ) then
					
					mul = d / 4;
					
				else
					
					mul = 1 - ( ( d - 4 ) / 56 );
					
				end
				
			else
				
				self:ResetDrugFX();
				
			end
			
		end
		
	end
	
end

function GM:DrugThink()
	
	if( self.DrugType ) then
		
		if( self.DrugType == DRUG_MEDKIT ) then
			
			local d = CurTime() - self.DrugStart;
			
			if( d <= 60 ) then
				
				local mul = 1;
				
				if( d < 4 ) then
					
					mul = d / 4;
					
				elseif( d > 40 ) then
					
					mul = 1 - ( ( d - 40 ) / 20 );
					
				end
				
				if( self.DrugAmbience ) then
					
					self.DrugAmbience:ChangeVolume( math.abs( math.sin( CurTime() * 10 ) * mul ), 0 );
					
				end
				
			else
				
				self:ResetDrugFX();
				
			end
			
		elseif( self.DrugType == DRUG_VODKA ) then
			
			local d = CurTime() - self.DrugStart;
			
			if( d <= 60 ) then
				
				local mul = 1;
				
				if( d < 4 ) then
					
					mul = d / 4;
					
				else
					
					mul = 1 - ( ( d - 4 ) / 56 );
					
				end
				
				if( self.DrugAmbience ) then
					
					self.DrugAmbience:ChangeVolume( math.abs( math.sin( CurTime() * 3 ) * 0.5 * mul ), 0 );
					
				end
				
			else
				
				self:ResetDrugFX();
				
			end
			
		elseif( self.DrugType == DRUG_ANTLION ) then
			
			local d = CurTime() - self.DrugStart;
			
			if( d <= 60 ) then
				
				local mul = 1;
				
				if( d < 4 ) then
					
					mul = d / 4;
					
				else
					
					mul = 1 - ( ( d - 4 ) / 56 );
					
				end
				
				if( self.DrugAmbience ) then
					
					self.DrugAmbience:ChangeVolume( mul * ( 1 - ( math.sin( CurTime() * 2 ) ^ 6 ) ), 0 );
					
				end
				
			else
				
				self:ResetDrugFX();
				
			end
			
		elseif( self.DrugType == DRUG_EXTRACT ) then
			
			local d = CurTime() - self.DrugStart;
			
			if( d <= 60 ) then
				
				local mul = 1;
				
				if( d < 4 ) then
					
					mul = d / 4;
					
				else
					
					mul = 1 - ( ( d - 4 ) / 56 );
					
				end
				
				if( self.DrugAmbience ) then
					
					self.DrugAmbience:ChangeVolume( mul * ( 1 - ( math.sin( CurTime() * 2 ) ^ 6 ) ), 0 );
					
				end
				
			else
				
				self:ResetDrugFX();
				
			end
			
		end
		
	end
	
end

function GM:ResetDrugFX()
	
	self.DrugType = nil;
	self.DrugStart = nil;
	
	if( self.DrugAmbience ) then
		
		self.DrugAmbience:Stop();
		
	end
	
	self.DrugAmbience = nil;
	
end

function GM:DrugEffectBreen()
	
	self:ResetDrugFX();
	
	self.DrugType = DRUG_BREEN;
	self.DrugStart = CurTime();
	
	surface.PlaySound( Sound( "physics/nearmiss/whoosh_large1.wav" ) );
	
end

function GM:DrugEffectMedkit()
	
	self:ResetDrugFX();
	
	self.DrugType = DRUG_MEDKIT;
	self.DrugStart = CurTime();
	
	surface.PlaySound( Sound( "ambient/atmosphere/hole_hit2.wav" ) );
	
	self.DrugAmbience = CreateSound( LocalPlayer(), "ambient/atmosphere/noise2.wav" );
	self.DrugAmbience:SetSoundLevel( 0 );
	self.DrugAmbience:Play();
	
end

function GM:DrugEffectVodka()
	
	self:ResetDrugFX();
	
	self.DrugType = DRUG_VODKA;
	self.DrugStart = CurTime();
	
	surface.PlaySound( Sound( "ambient/atmosphere/city_skypass1.wav" ) );
	
	self.DrugAmbience = CreateSound( LocalPlayer(), "ambient/water/underwater.wav" );
	self.DrugAmbience:SetSoundLevel( 0 );
	self.DrugAmbience:Play();
	
end

function GM:DrugEffectAntlion()
	
	self:ResetDrugFX();
	
	self.DrugType = DRUG_ANTLION;
	self.DrugStart = CurTime();
	
	self.DrugAmbience = CreateSound( LocalPlayer(), "ambient/atmosphere/elev_shaft1.wav" );
	self.DrugAmbience:SetSoundLevel( 0 );
	self.DrugAmbience:Play();
	
end

function GM:DrugEffectExtract()
	
	self:ResetDrugFX();
	
	self.DrugType = DRUG_EXTRACT;
	self.DrugStart = CurTime();
	
	self.DrugAmbience = CreateSound( LocalPlayer(), "ambient/atmosphere/elev_shaft1.wav" );
	self.DrugAmbience:SetSoundLevel( 0 );
	self.DrugAmbience:Play();
	
end
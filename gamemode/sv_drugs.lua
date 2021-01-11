local meta = FindMetaTable( "Player" );

function meta:ClearDrug()
	
	self.DrugEffects = { };
	
end

function meta:DoDrug( d )
	
	if( !self.DrugEffects ) then self:ClearDrug() end
	
	self.DrugEffects[d] = CurTime();
	
end

function meta:HasDrug( d )
	
	if( !self.DrugEffects ) then self:ClearDrug() end
	
	if( self.DrugEffects[d] ) then
		
		return CurTime() - self.DrugEffects[d] < 60;
		
	end
	
	return false;
	
end

function meta:DrugSpeedMod()
	
	local mul = 1;
	
	if( self:HasDrug( DRUG_ANTLION ) ) then
		
		mul = mul * 1.5;
		
	end
	
	return mul;
	
end

function meta:DrugDamageMod()
	
	local mul = 1;
	
	if( self:HasDrug( DRUG_ANTLION ) ) then
		
		mul = mul * 0.4;
		
	end
	
	if( self:HasDrug( DRUG_EXTRACT ) ) then
		
		mul = mul * 0.25;
		
	end
	
	if( self:HasDrug( DRUG_MEDKIT ) ) then
		
		mul = mul * 0.7;
		
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
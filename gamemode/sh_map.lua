local meta = FindMetaTable( "Player" );

GM.GlobalVariables = {
	{ "OOCDelay", 			"Float", 	0 },
	{ "Rations", 			"Float", 	30 },
	{ "Posters", 			"Float", 	50 },
	{ "Flashlight",			"Float",	1 },
	{ "AllowCPApps",		"Float",	0 },
	{ "JudgementWaiver",	"Float",	0 },
	{ "BreenStartTime",		"Float",	-1 },
	{ "BreenEndTime",		"Float",	-1 }
};

for k, v in pairs( GM.GlobalVariables ) do
	
	GM["Set" .. v[1]] = function( self, val )
		
		if( CLIENT ) then return end
		
		_G["SetGlobal" .. v[2]]( v[1], val );
		
	end
	
	GM[v[1]] = function( self )
		
		local v = _G["GetGlobal" .. v[2]]( v[1], v[3] );
		
		if( v == false ) then
			
			return false;
			
		end
		
		return v;
		
	end
	
end

function meta:SyncAllGlobalData()
	
	
	
end

GM.NextCombineRefill = CurTime() + 3600;

function GM:RefillThink()
	
	if( CLIENT ) then return end
	
	if( CurTime() >= self.NextCombineRefill ) then
		
		self.NextCombineRefill = CurTime() + 3600;
		
		self:SetRations( 30 );
		self:SetPosters( 50 );
		
		net.Start( "nCombineRefill" );
		net.Send( player.GetCombine() );
		
	end
	
end

function nCombineRefill( len )
	
	if( SERVER ) then return end
	
	GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "A new shipment of Combine supplies has arrived.", { CB_ALL, CB_IC } );
	
end
net.Receive( "nCombineRefill", nCombineRefill );

function GM:GetMaps()
	
	local maps = file.Find( "maps/*.bsp", "GAME", "namedesc" );
	
	local tab = { };
	
	for _, v in pairs( maps ) do
		
		local mapname, _ = string.gsub( v, ".bsp", "" );
		
		local files = file.Find( self.FolderName .. "/gamemode/maps/" .. mapname .. ".lua", "LUA", "namedesc" );
		
		if( #files > 0 ) then
			
			table.insert( tab, mapname );
			
		end
		
	end
	
	return tab;
	
end

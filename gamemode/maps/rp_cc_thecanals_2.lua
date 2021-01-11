function GM:GetHL2CamPos()
	
	return { Vector( 4202, 1315, 13787 ), Angle( 5, -32, 0 ) };
	
end

function GM:MapInitPostEntity()
	
	--[[self:CreateLocationPoint( Vector( 3795, 6714, 13761 ), LOCATION_CITY, 100, TRANSITPORT_CITY_GATE );
	self:CreateLocationPoint( Vector( 3815, 3972, 13745 ), LOCATION_CITY, 60, TRANSITPORT_CITY_SEWER );
	self:CreateLocationPoint( Vector( 9229, -1050, 4160 ), LOCATION_CITY, 200, TRANSITPORT_CITY_COMBINE );
	self:CreateLocationPoint( Vector( -10229, 12763, 9520 ), LOCATION_OUTLANDS, 256, TRANSITPORT_CAVES_ENTRY );--]]
	
end

GM.EnableAreaportals = true;
--[[
GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "This maintenance shaft leads back into the city.";
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "This maintenance shaft leads into the city's sewers.";
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "You can summon the helicopter to take you back to the City 18 Nexus here.";
GM.ConnectMessages[TRANSITPORT_CAVES_ENTRY] = "You come across a what looks like the entrance to a mine.";
GM.ConnectMessages[TRANSITPORT_COAST_ENTRY] = "Through here is the coast.";

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector( 3719, 6659, 13697 ),
	Vector( 3718, 6620, 13697 ),
	Vector( 3666, 6621, 13697 ),
	Vector( 3666, 6663, 13697 ),
	Vector( 3611, 6663, 13697 ),
	Vector( 3611, 6614, 13697 ),
	Vector( 3555, 6614, 13713 ),
	Vector( 3556, 6659, 13713 ),

};
GM.EntryPortSpawns[TRANSITPORT_CAVES_ENTRY] = {
	Vector( -10280, 12403, 9457 ),
	Vector( -10222, 12407, 9478 ),
	Vector( -10172, 12410, 9480 ),
	Vector( -10189, 12338, 9465 ),
	Vector( -10239, 12323, 9457 ),
	Vector( -10299, 12346, 9457 ),
};
GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector( 3819, 4125, 13745 ),
	Vector( 3821, 4070, 13745 ),
};
GM.EntryPortSpawns[TRANSITPORT_COAST_ENTRY] = {
	Vector( -9019, -12642, 3101 ),
	Vector( -9019, -12565, 3087 ),
	Vector( -9016, -12474, 3078 ),
	Vector( -9013, -12406, 3074 ),
	Vector( -9013, -12174, 3073 ),
	Vector( -9006, -12085, 3075 ),
	Vector( -8995, -11998, 3088 ),
	Vector( -8997, -11928, 3102 ),
};--]]

GM.CombineSpawnpoints = {
	Vector( 10160, 2002, 3841 ),
	Vector( 10218, 2002, 3841 ),
	Vector( 10282, 2002, 3841 ),
	Vector( 10277, 1938, 3841 ),
	Vector( 10224, 1938, 3841 ),
	Vector( 10169, 1938, 3841 ),
	Vector( 10169, 1869, 3841 ),
	Vector( 10227, 1869, 3841 ),
	Vector( 10288, 1869, 3841 ),
	Vector( 10288, 1814, 3841 ),
	Vector( 10231, 1813, 3841 ),
	Vector( 10168, 1813, 3841 ),
};

GM.CurrentLocation = LOCATION_CANAL;

GM.DoorData = {
	{ Vector( 10308, 1920, 3888 ), DOOR_COMBINEOPEN, "" },
};
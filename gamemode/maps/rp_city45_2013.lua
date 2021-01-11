function GM:GetHL2CamPos()
	
	return { Vector( 458, 3100, 635 ), Angle( -11, -82, 0 ) };
	
end

function GM:GetCACamPos()
	
	return Vector( 1990, 586, 2945 );
	
end

function GM:GetCombineCratePos()
	
	return { Vector( 1606, 918, 756 ), Angle( 0, -90, 0 ) };
	
end

function GM:GetCombineRationPos()
	
	return { Vector( 1605, 935, 800 ), Angle( 0, 270, 0 ) };
	
end

GM.EnableAreaportals = true;

GM.IntroCamData = { };
GM.IntroCamData[1] = { { Vector( 619, 2398, 832 ), Vector( 679, 2194, 832 ) }, { Angle( -26, 17, 0 ), Angle( -24, 12, 0 ) } };
GM.IntroCamData[2] = { { Vector( 2258, 1869, 728 ), Vector( 2476, 1896, 727 ) }, { Angle( -5, 107, 0 ), Angle( 1, 73, 0 ) } };
GM.IntroCamData[3] = { { Vector( 830, 1571, 627 ), Vector( 1029, 1798, 627 ) }, { Angle( -22, -35, 0 ), Angle( -43, -46, 0 ) } };
GM.IntroCamData[4] = { { Vector( 7116, 892, 292 ), Vector( 7297, 894, 276 ) }, { Angle( 7, 1, 0 ), Angle( -4, 1, 0 ) } };
GM.IntroCamData[5] = { { Vector( 6136, 199, 547 ), Vector( 6158, -25, 552 ) }, { Angle( -4, -157, 0 ), Angle( -3, -172, 0 ) } };
GM.IntroCamData[6] = { { Vector( 1041, 2727, 982 ), Vector( 453, 2728, 953 ) }, { Angle( 11, -110, 0 ), Angle( 26, -87, 0 ) } };

GM.CurrentLocation = LOCATION_CITY;

function GM:MapInitPostEntity()
	
	local cam = ents.FindByName( "nexus_broadcast_camera" )[1];
	cam:SetSaveValue( "FOV", "20" );
	cam:SetPos( cam:GetPos() + Vector( 0, 0, 4 ) );
	cam:Fire( "SetOn" );
	
	for _, v in pairs( ents.FindByName( "nexus_elevator_button1" ) ) do
		
		v:Fire( "Lock" );
		
	end
	
	for _, v in pairs( ents.FindByName( "nexus_elevator_button3" ) ) do
		
		v:Fire( "Lock" );
		
	end
	
	for _, v in pairs( ents.FindByName( "nexus_elevator" ) ) do
		
		v:Fire( "Open" );
		
	end
	
	local ent = ents.FindByName( "nexus_monitor" );
	for _, v in pairs( ent ) do
		
		v:Fire( "Disable" );
		v:Fire( "SetCamera", "nexus_broadcast_camera" );
		
	end
	
	--self:CreateLocationPoint( Vector( 12074, 866, 284 ), LOCATION_CANAL, 200, TRANSITPORT_CITY_GATE );
	--self:CreateLocationPoint( Vector( 871, 2551, 340 ), LOCATION_CANAL, 128, TRANSITPORT_CITY_SEWER );
	--self:CreateLocationPoint( Vector( 2012, 1583, 1236 ), LOCATION_CANAL, 200, TRANSITPORT_CITY_COMBINE );
	
end
--[[
GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "Behind this door is unguarded - it seems like the Combine haven't noticed yet. There's an entranceway to a small concrete maintenance area.";
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "The sewage pipe looks like you can climb through it. Down a ways, you see a light - it looks like it leads into a concrete maintenance area.";
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "A helicopter is here, ready to take you to patrol Sector 12.";

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector( 11679, 649, 263 ),
	Vector( 11619, 646, 252 ),
	Vector( 11620, 729, 251 ),
	Vector( 11673, 729, 251 ),
	Vector( 11674, 803, 249 ),
	Vector( 11611, 803, 251 ),
};
GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector( 1040, 2490, 292 ),
	Vector( 1061, 2545, 276 ),
	Vector( 1109, 2486, 292 ),
	Vector( 1128, 2545, 276 ),
	Vector( 1166, 2489, 292 ),
	Vector( 1200, 2544, 276 ),
};
GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = {
	Vector( 1747, 1634, 1172 ),
	Vector( 1740, 1564, 1172 ),
	Vector( 1741, 1494, 1172 ),
	Vector( 1685, 1457, 1172 ),
	Vector( 1680, 1561, 1172 ),
};
--]]
GM.EntNamesToRemove = {
	"nexus_ind_button1",
	"nexus_ind_button3",
	"checkpoint.closed.sprite",
	"checkpoint.open.sprite",
	"nexus_ind_button2",
	"nexus_ind_button4",
	"jw_button",
	"nexus_JW_button2",
	"exogen_button_off",
	"nexus_exoen_button1",
	"exogen.disabled.sprite",
	"exogen_button",
	"exogen.enabled.sprite",
	"nexus_exogen_button2",
	"ration_offline_text",
	"ration_online_text",
	"rationdispatch",
	"ration_online_btn",
	"rtn.online.sprite",
	"ration_online_btnmodel",
	"ration_offline_btn",
	"rtn.offline.sprite",
	"pistolspawnbuttonmodel",
	"pistolspawner",
	"pistolspawn.dispensesound",
	"pistolspawn1case",
	"smgspawnbuttonmodel",
	"smgspawn.dispensesound",
	"smgspawner",
	"smgspawn1case",
	"shotgunspawnbuttonmodel",
	"shotgunspawn.dispensesound",
	"shotgunspawner",
	"shotgunspawn1case",
	"ar2spawnbuttonmodel",
	"ar2spawn.dispensesound",
	"ar2spawner",
	"ar2spawn1case",
	"jurbosprite",
	"jurbomodel",
	"UCHUNLOCK_text",
	"UCHLOCK_text",
	"jurbolock",
	"jurbounlock",
};

GM.EntPositionsToRemove = {
	Vector( "1862 933.5 2946.26" ),
	Vector( "1818 846 2949" ),
	Vector( "2264.4 3224.52 975.4" )
}

function GM:OnJWOn()
	
	for _, v in pairs( ents.FindByName( "jw_redpanel" ) ) do
		
		v:Fire( "Enable" );
		
	end
	
	ents.FindByName( "pivotsprite" )[1]:Fire( "Color", "255 0 0" );
	ents.FindByName( "JW.Spire.1" )[1]:Fire( "Start" );
	ents.FindByName( "JW.Spire.2" )[1]:Fire( "Open", "", 15 );
	ents.FindByName( "JW.Spire.3" )[1]:Fire( "Open", "", 19 );
	
end

function GM:OnJWOff()
	
	for _, v in pairs( ents.FindByName( "jw_redpanel" ) ) do
		
		v:Fire( "Disable" );
		
	end
	
	ents.FindByName( "pivotsprite" )[1]:Fire( "Color", "33 68 231" );
	ents.FindByName( "JW.Spire.1" )[1]:Fire( "Stop" );
	ents.FindByName( "JW.Spire.2" )[1]:Fire( "Close", "", 15 );
	ents.FindByName( "JW.Spire.3" )[1]:Fire( "Close", "", 19 );
	
end

GM.Microphones = {
	{ Vector( "449.41 530.04 591.72" ), MICROPHONE_SMALL },
	{ Vector( "-2016.73 54.04 725.03" ), MICROPHONE_SMALL },
	{ Vector( "1391.99 1359.11 938" ), MICROPHONE_BIG },
	{ Vector( "-1830.26 121.87 595" ), MICROPHONE_SMALL },
	{ Vector( "221.74 736.17 589" ), MICROPHONE_SMALL },
	{ Vector( "1680.72 2867.96 585" ), MICROPHONE_SMALL },
	{ Vector( "2250.82 3144.73 724" ), MICROPHONE_SMALL },
};

GM.Stoves = {
	{ Vector( 2508, 2738, 639.334 ), Angle( 0, 0, 0 ), "A12" },
	{ Vector( 3076, 2756, 639.334 ), Angle( 0, 270, 0 ), "A11" },
	{ Vector( 2508, 2738, 796.334 ), Angle( 0, 0, 0 ), "A22" },
	{ Vector( 3076, 2756, 796.334 ), Angle( 0, 270, 0 ), "A21" },
	{ Vector( 3076, 2756, 953.334 ), Angle( 0, 270, 0 ), "A31" },
	{ Vector( 2508, 2738, 953.334 ), Angle( 0, 0, 0 ), "A32" },
	{ Vector( 2167, 2738, 953.334 ), Angle( 0, 180, 0 ), "A33" },
	{ Vector( 1598, 2756, 953.334 ), Angle( 0, 270, 0 ), "A34" },
	{ Vector( 1598, 2756, 796.334 ), Angle( 0, 270, 0 ), "A24" },
	{ Vector( 2166, 2738, 796.334 ), Angle( 0, 180, 0 ), "A23" },
	{ Vector( 1598, 2756, 639.334 ), Angle( 0, 270, 0 ), "A14" },
	{ Vector( 2166, 2738, 639.334 ), Angle( 0, 180, 0 ), "A13" },
	{ Vector( 1798, 2874, 523 ), Angle( 0, 270, 0 ), "SHOP1", nil, "models/props_wasteland/kitchen_stove001a.mdl" },
	{ Vector( 850, 372, 524 ), Angle( 0, 180, 0 ), "CAFE", nil, "models/props_wasteland/kitchen_stove001a.mdl" },
};

GM.CombineSpawnpoints = {
	Vector( 1967, 902, 740 ),
	Vector( 1968, 847, 740 ),
	Vector( 1969, 796, 740 ),
	Vector( 1970, 723, 740 ),
	Vector( 1920, 724, 740 ),
	Vector( 1915, 797, 740 ),
	Vector( 1911, 843, 740 ),
	Vector( 1907, 897, 740 ),
	Vector( 1844, 895, 740 ),
	Vector( 1846, 840, 740 ),
	Vector( 1850, 799, 740 ),
	Vector( 1856, 727, 740 ),
	Vector( 1795, 725, 740 ),
	Vector( 1795, 785, 740 ),
	Vector( 1787, 851, 740 )
};

GM.DoorData = {
	{ Vector( 1527.0400390625, 1241.2299804688, 647 ), DOOR_COMBINEOPEN, "Nexus" },
	{ Vector( 962.24200439453, 3797, 553.00402832031 ), DOOR_BUYABLE, "DiORDNA", 20 },
	{ Vector( 5596, 661, 542 ), DOOR_BUYABLE, "Warehouse", 30, "WAREHOUSE1" },
	{ Vector( 5668, 661, 542 ), DOOR_BUYABLE, "Warehouse", 30, "WAREHOUSE1" },
	{ Vector( 8629, -435, 677 ), DOOR_BUYABLE, "Room", 5 },
	{ Vector( 8608.5, -1681, 570.5 ), DOOR_BUYABLE, "Generator Room", 20 },
	{ Vector( 8944, -2741.5, 618.5 ), DOOR_UNBUYABLE, "Apartment Block B" },
	{ Vector( 9191, -2414, 549 ), DOOR_BUYABLE, "Shop", 15 },
	{ Vector( 803.5, 928.5, 553 ), DOOR_BUYABLE, "Cafe Baltic", 20, "CAFE" },
	{ Vector( 419.5, 964.5, 553 ), DOOR_BUYABLE, "FOTO Shop", 20, "FOTO" },
	{ Vector( -2064, 3006.0100097656, 587 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 186.5, 1036.5, 553 ), DOOR_BUYABLE, "Souvenir Shop", 35, "SOUVENIR" },
	{ Vector( 505, 3185, 553 ), DOOR_COMBINELOCK, "Ration Distribution Center" },
	{ Vector( 505, 3279, 553 ), DOOR_COMBINELOCK, "Ration Distribution Center" },
	{ Vector( 8869, -2965, 741 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-1-1", 5 },
	{ Vector( 9029, -2965, 741 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-1-2", 5 },
	{ Vector( 9029, -2965, 869 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-2-2", 5 },
	{ Vector( 8869, -2965, 869 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-2-1", 5 },
	{ Vector( 9029, -2965, 997 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-3-2", 5 },
	{ Vector( 8869, -2965, 997 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-3-1", 5 },
	{ Vector( 9043, -3125, 741 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-1-3", 5 },
	{ Vector( 9043, -3125, 869 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-2-3", 5 },
	{ Vector( 9043, -3125, 997 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-3-3", 5 },
	{ Vector( 2609, 2824, 674.33099365234 ), DOOR_UNBUYABLE, "", 0, "A12" },
	{ Vector( 3025, 2845, 674.28100585938 ), DOOR_UNBUYABLE, "", 0, "A11" },
	{ Vector( 2837, 2898, 673 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-1", 10, "A11" },
	{ Vector( 2717, 2898, 673 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-2", 10, "A12" },
	{ Vector( 2609, 2824, 831.33099365234 ), DOOR_UNBUYABLE, "", 0, "A22" },
	{ Vector( 2717, 2898, 830 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-2", 10, "A22" },
	{ Vector( 3025, 2845, 831.28100585938 ), DOOR_UNBUYABLE, "", 0, "A21" },
	{ Vector( 2837, 2898, 830 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-1", 7, "A21" },
	{ Vector( 3025, 2845, 988.28100585938 ), DOOR_UNBUYABLE, "", 0, "A31" },
	{ Vector( 2837, 2898, 987 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-1", 5, "A31" },
	{ Vector( 2609, 2824, 988.33099365234 ), DOOR_UNBUYABLE, "", 0, "A32" },
	{ Vector( 2717, 2898, 987 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-2", 10, "A32" },
	{ Vector( 2385, 2902, 673 ), DOOR_UNBUYABLE, "Apartment Block A" },
	{ Vector( 664, 491, 553 ), DOOR_UNBUYABLE, "Kitchen", 0, "CAFE" },
	{ Vector( 339, 495, 553 ), DOOR_UNBUYABLE, "Storage", 0, "FOTO" },
	{ Vector( 844, 563, 553 ), DOOR_UNBUYABLE, "", 0, "CAFE" },
	{ Vector( 110.01999664307, 3564, 547 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 110.01999664307, 3316, 547 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 108.01000213623, 3724, 546 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 2291, 2902, 673 ), DOOR_UNBUYABLE, "Apartment Block A" },
	{ Vector( 1911, 2898, 987 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-3", 10, "A33" },
	{ Vector( 2109, 2870, 988.33099365234 ), DOOR_UNBUYABLE, "", 0, "A33" },
	{ Vector( 1791, 2898, 987 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-4", 5, "A34" },
	{ Vector( 1691, 2799, 988.28100585938 ), DOOR_UNBUYABLE, "", 0, "A34" },
	{ Vector( 1791, 2898, 830 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-4", 9, "A24" },
	{ Vector( 1691, 2799, 831.28100585938 ), DOOR_UNBUYABLE, "", 0, "A24" },
	{ Vector( 1911, 2898, 830 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-3", 10, "A23" },
	{ Vector( 2109, 2870, 831.33099365234 ), DOOR_UNBUYABLE, "", 0, "A23" },
	{ Vector( 1911, 2898, 673 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-3", 10, "A13" },
	{ Vector( 1791, 2898, 673 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-4", 10, "A14" },
	{ Vector( 1691, 2799, 674.28100585938 ), DOOR_UNBUYABLE, "", 0, "A14" },
	{ Vector( 2109, 2870, 674.33099365234 ), DOOR_UNBUYABLE, "", 0, "A13" },
	{ Vector( 52, 543, 552 ), DOOR_UNBUYABLE, "", 0, "SOUVENIR" },
	{ Vector( 8363, -1070, 415 ), DOOR_BUYABLE, "Bar", 20 },
	{ Vector( 11709, 1067, 318.28100585938 ), DOOR_BUYABLE, "Cargo Shack", 5 },
	{ Vector( 10706, 1707, 718.28100585938 ), DOOR_BUYABLE, "Warehouse", 15, "WAREHOUSE2" },
	{ Vector( 10180, 1560, 848.28100585938 ), DOOR_UNBUYABLE, "", 0, "WAREHOUSE2" },
	{ Vector( 11161, 1515, 718 ), DOOR_BUYABLE, "Waste Processing", 20, "WASTE" },
	{ Vector( 11582, 1922, 718 ), DOOR_BUYABLE, "Waste Processing", 20, "WASTE" },
	{ Vector( 12254, 1389, 718 ), DOOR_BUYABLE, "Building", 20, "BUILDING" },
	{ Vector( 11783, 1775, 718 ), DOOR_BUYABLE, "Building", 20, "BUILDING" },
	{ Vector( 11264, 195.94999694824, 718.28100585938 ), DOOR_BUYABLE, "Warehouse", 15, "WAREHOUSE3" },
	{ Vector( 11678, -45.049800872803, 718.28100585938 ), DOOR_BUYABLE, "Loft Warehouse", 20, "LOFT" },
	{ Vector( 11148, 695, 424.28100585938 ), DOOR_BUYABLE, "Canal Shack", 5 },
	{ Vector( 10410.400390625, 14.719200134277, -28.718999862671 ), DOOR_BUYABLE, "Hidden Building", 20, "HIDDEN" },
	{ Vector( 10410.400390625, 107.71900177002, -28.718999862671 ), DOOR_BUYABLE, "Hidden Building", 20, "HIDDEN" },
	{ Vector( 10917, 65, 718.28100585938 ), DOOR_BUYABLE, "Warehouse", 25, "WAREHOUSE4" },
	{ Vector( 4665, 2525, 249 ), DOOR_BUYABLE, "Submerged Room", 5, "SUBMERGED" },
	{ Vector( 4759, 2525, 249 ), DOOR_BUYABLE, "Submerged Room", 5, "SUBMERGED" },
	{ Vector( 2094, 3101.9899902344, 980 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 1998.9899902344, 3276, 980 ), DOOR_COMBINEOPEN, "" },
	{ Vector( -128, 3120.9799804688, 684 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 877, -1757, -87 ), DOOR_COMBINELOCK, "Training Course" },
	{ Vector( 133, -1597, -87 ), DOOR_UNBUYABLE, "Showers" },
	{ Vector( 877, -1175, 49 ), DOOR_UNBUYABLE, "Observation" },
	{ Vector( 1340, 723.01000976563, 1219 ), DOOR_COMBINEOPEN, "Roof" },
	{ Vector( 1849, 1537.0100097656, 787 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 2100, 823.10900878906, 648.85998535156 ), DOOR_COMBINELOCK, "Room 101" },
	{ Vector( 2179, 1079.1099853516, 649 ), DOOR_UNBUYABLE, "Cell 6" },
	{ Vector( 2179, 1215.1099853516, 649 ), DOOR_UNBUYABLE, "Cell 5" },
	{ Vector( 2179, 1343, 649 ), DOOR_UNBUYABLE, "Cell 4" },
	{ Vector( 2179, 1471, 649 ), DOOR_UNBUYABLE, "Cell 3" },
	{ Vector( 2179, 1582, 649 ), DOOR_UNBUYABLE, "Cell 2" },
	{ Vector( 1897, 1592, 648.57897949219 ), DOOR_UNBUYABLE, "Cell 1" },
	{ Vector( 97, 322, 47 ), DOOR_COMBINEOPEN, "Debriefing Room B" },
	{ Vector( 581, 322, 49 ), DOOR_UNBUYABLE, "Firing Range" },
	{ Vector( 675, 322, 49 ), DOOR_UNBUYABLE, "Firing Range" },
	{ Vector( 883, 258, 49 ), DOOR_UNBUYABLE, "Armory" },
	{ Vector( 1708.0100097656, 654.5, 935.5 ), DOOR_COMBINEOPEN, "Control" },
	{ Vector( 1855, 727, 1081 ), DOOR_UNBUYABLE, "Debriefing Room A" },
	{ Vector( 1949, 727, 1081 ), DOOR_UNBUYABLE, "Debriefing Room A" },
	{ Vector( 1850.0100097656, 1310, 643 ), DOOR_COMBINEOPEN, "Prison" },
	{ Vector( 1640, 787.11999511719, 643 ), DOOR_COMBINEOPEN, "Airlock" },
	{ Vector( 2000, 687.11999511719, 659 ), DOOR_COMBINEOPEN, "Prison" },
	{ Vector( 1640, 967.01000976563, 643 ), DOOR_COMBINEOPEN, "Airlock" },
	{ Vector( 1417, -280, 49 ), DOOR_UNBUYABLE, "Medical" },
	{ Vector( 1417, -186, 49 ), DOOR_UNBUYABLE, "Medical" },
	{ Vector( 1336, -938, 49 ), DOOR_UNBUYABLE, "Training" },
	{ Vector( 1242, -938, 49 ), DOOR_UNBUYABLE, "Training" },
	{ Vector( 266, -1086, -87 ), DOOR_UNBUYABLE, "Classroom" },
	{ Vector( 360, -1086, -87 ), DOOR_UNBUYABLE, "Classroom" },
	{ Vector( -83, -1546, -81 ), DOOR_COMBINEOPEN, "Arena" },
	{ Vector( 1603.0899658203, 1554.0899658203, 787 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 1459.9100341797, 1410.9100341797, 659 ), DOOR_COMBINEOPEN, "Nexus" },
	{ Vector( 1370.0899658203, 1321.0899658203, 659 ), DOOR_COMBINEOPEN, "Nexus" },
	{ Vector( 218, 3615.0200195313, 546 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 1368.5, -782, 51 ), DOOR_COMBINEOPEN, "Offices" },
	{ Vector( 1368.5, -826, 51 ), DOOR_COMBINEOPEN, "Offices" },
	{ Vector( -2108, 391, 681 ), DOOR_UNBUYABLE, "", 0, "SHOP3" },
	{ Vector( -2108, 160, 681 ), DOOR_UNBUYABLE, "", 0, "SHOP3" },
	{ Vector( -1150, -1004, 545 ), DOOR_BUYABLE, "Dive Bar", 20 },
	{ Vector( -1935, -1145, 553 ), DOOR_BUYABLE, "Warehouse", 30 },
	{ Vector( -2003, 19, 553 ), DOOR_BUYABLE, "Medical Center", 40, "MEDIC" },
	{ Vector( -1909, 19, 553 ), DOOR_BUYABLE, "Medical Center", 40, "MEDIC" },
	{ Vector( 2012, 1048, 642.5 ), DOOR_COMBINEOPEN, "Disposal" },
	{ Vector( -56.009998321533, -1002, 569 ), DOOR_COMBINEOPEN, "Vehicle Maintenance Facility C8" },
	{ Vector( -56.009998321533, -1066, 569 ), DOOR_COMBINEOPEN, "Vehicle Maintenance Facility C8" },
	{ Vector( -1796, 187, 681 ), DOOR_BUYABLE, "Large Shop", 20, "SHOP3" },
	{ Vector( -1796, 281, 681 ), DOOR_BUYABLE, "Large Shop", 20, "SHOP3" },
	{ Vector( -2080, 313, 553 ), DOOR_UNBUYABLE, "Patient Area", 0, "MEDIC" },
	{ Vector( -2145, 252, 553 ), DOOR_UNBUYABLE, "", 0, "MEDIC" },
	{ Vector( -2289, 252, 553 ), DOOR_UNBUYABLE, "ER", 0, "MEDIC" },
	{ Vector( -2383, 252, 553 ), DOOR_UNBUYABLE, "ER", 0, "MEDIC" },
	{ Vector( -2080, 441, 553 ), DOOR_UNBUYABLE, "Front Desk", 0, "MEDIC" },
	{ Vector( 1685.5, 2638, 554.5 ), DOOR_BUYABLE, "Shop", 20, "SHOP1" },
	{ Vector( 2064.5, 2638, 554.5 ), DOOR_BUYABLE, "Shop", 20, "SHOP2" },
};


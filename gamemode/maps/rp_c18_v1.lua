function GM:GetHL2CamPos()
	
	return { Vector( -1188, 41, 1435 ), Angle( 5, -37, 0 ) };
	
end

function GM:GetCACamPos()
	
	return Vector( 2132, -1424, 1730 );
	
end

function GM:GetCombineCratePos()
	
	return { Vector( 1297, 1111, 529 ), Angle() };
	
end

function GM:GetCombineRationPos()
	
	return { Vector( 1405, 1261, 566 ), Angle( 0, -90, 0 ) };
	
end

GM.IntroCamData = { };
GM.IntroCamData[1] = { { Vector( 1195, -2404, 926 ), Vector( 1193, -2599, 934 ) }, { Angle( -3, -48, 0 ), Angle( -0, -36, 0 ) } };
GM.IntroCamData[2] = { { Vector( -525, -816, 893 ), Vector( -219, -607, 897 ) }, { Angle( 1, 130, 0 ), Angle( 5, 143, 0 ) } };
GM.IntroCamData[3] = { { Vector( 1872, -741, 594 ), Vector( 2105, -743, 590 ) }, { Angle( 4, 51, 0 ), Angle( 3, 96, 0 ) } };
GM.IntroCamData[4] = { { Vector( -1058, 3942, 1003 ), Vector( -1031, 4367, 994 ) }, { Angle( 1, 103, 0 ), Angle( 3, 42, 0 ) } };
GM.IntroCamData[5] = { { Vector( -1215, 373, 1597 ), Vector( -1088, -579, 1537 ) }, { Angle( 4, -57, 0 ), Angle( 4, 1, 0 ) } };
GM.IntroCamData[6] = { { Vector( 3798, -176, 864 ), Vector( 3899, 141, 947 ) }, { Angle( -36, 118, 0 ), Angle( -45, 149, 0 ) } };

GM.CurrentLocation = LOCATION_CITY;

function GM:OnJWOn()
	
	for _, v in pairs( ents.FindByName( "jw_redpanels" ) ) do
		
		v:Fire( "Enable" );
		
	end
	
end

function GM:OnJWOff()
	
	for _, v in pairs( ents.FindByName( "jw_redpanels" ) ) do
		
		v:Fire( "Disable" );
		
	end
	
end

GM.EntNamesToRemove = {
	"n1_tele_dest",
	"n1_tele",
	"jw_button",
	"nexus_JW_button2",
	"nexus_JW",
	"nexus_JW2",
	"jw_end",
	"jw_start",
	"jw_timer",
	"fatnogard_flame",
};

GM.EntPositionsToRemove = {
	Vector( 706.5, 3339.99, 1133.31 ),
}

GM.Microphones = {
	{ Vector( 1452, -2252, 1411 ), MICROPHONE_BIG },
	{ Vector( 3581, -2474, 1029 ), MICROPHONE_BIG },
	{ Vector( -575, -424, 975 ), MICROPHONE_BIG },
	{ Vector( -1492, -262, 715 ), MICROPHONE_SMALL },
	{ Vector( -1607, 46, 720 ), MICROPHONE_SMALL },
	{ Vector( 2476, 658, 1453 ), MICROPHONE_BIG },
	{ Vector( 2375, 878, 990 ), MICROPHONE_SMALL },
	{ Vector( 2612, 1250, 989 ), MICROPHONE_BIG },
	{ Vector( 64, 2780, 1251 ), MICROPHONE_SMALL },
	{ Vector( -1359, 3055, 773 ), MICROPHONE_SMALL },
	{ Vector( -916, 5352, 1498 ), MICROPHONE_BIG },
	{ Vector( -2564, 1200, 845 ), MICROPHONE_BIG },
};

GM.Stoves = {
	{ Vector( -1466, -94, 1357.38 ), Angle( 0, 180, 0 ), "A51" },
	{ Vector( -1539, 350, 1356.33 ), Angle( 0, 270, 0 ), "A52" },
	{ Vector( -1466, -93, 1229.38 ), Angle( 0, 180, 0 ), "A41" },
	{ Vector( -1539, 351, 1228.33 ), Angle( 0, 270, 0 ), "A42" },
	{ Vector( -152, 2734, 1108.33 ), Angle( 0, 180, 0 ), "B12" },
	{ Vector( -614, 2738, 1108.33 ), Angle( 0, 0, 0 ), "B11" },
	{ Vector( -1466, -94, 1101.38 ), Angle( 0, 180, 0 ), "A31" },
	{ Vector( -1539, 350, 1100.33 ), Angle( 0, 270, 0 ), "A32" },
	{ Vector( -1466, -94.3028, 974.38 ), Angle( 0, 180, 0 ), "A21" },
	{ Vector( -1539, 349.697, 973.334 ), Angle( 0, 270, 0 ), "A22" },
	{ Vector( -1466, -94, 845.38 ), Angle( 0, 180, 0 ), "A11" },
	{ Vector( -1539, 350, 844.334 ), Angle( 0, 270, 0 ), "A12" },
	{ Vector( 726, 3343, 1116 ), Angle( 0, 0, 0 ), "FAT" },
};

GM.CombineSpawnpoints = {
	Vector( 1332, 870, 513 ),
	Vector( 1414, 908, 513 ),
	Vector( 1480, 980, 513 ),
	Vector( 1533, 1047, 513 ),
	Vector( 1470, 1041, 513 ),
	Vector( 1414, 981, 513 ),
	Vector( 1334, 929, 513 ),
	Vector( 1350, 991, 513 ),
	Vector( 1398, 1054, 513 ),
	Vector( 1498, 1130, 513 ),
	Vector( 1432, 1117, 513 ),
	Vector( 1370, 1132, 513 ),
};

GM.DoorData = {
	{ Vector( 3031.9099121094, -2735, 814.71899414063 ), 			0, "Trainstation" },
	{ Vector( 3031.9099121094, -2641, 814.71899414063 ), 			0, "Trainstation" },
	{ Vector( 2154.0900878906, -2640.7199707031, 814.28100585938 ), 0, "Trainstation" },
	{ Vector( 2154.0900878906, -2734.7199707031, 814.28100585938 ), 0, "Trainstation" },
	
	{ Vector( 988, -3991, 718.28100585938 ), 1, "Store", 50, "REST" },
	{ Vector( 824, -3524, 728 ), 1, "Store", 50, "REST" },
	{ Vector( 743, -3725, 718.28100585938 ), 0, "Back", 0, "REST" },
	
	{ Vector( 471, -3836, 746.28100585938 ), 1, "Warehouse", 50 },
	
	{ Vector( -560.04498291016, -1476.0100097656, 726 ), 1, "FOTO Shop", 40, "FOTO" },
	{ Vector( -791, -1145, 726.28100585938 ), 0, "Backroom", 0, "FOTO" },
	
	{ Vector( 686.28100585938, -1220.0899658203, 766.28100585938 ), 1, "CHANGE Shop", 60, "CHANGE" },
	{ Vector( 594.28100585938, -1220.0899658203, 766.28100585938 ), 1, "CHANGE Shop", 60, "CHANGE" },
	{ Vector( 988.27398681641, -1495.9499511719, 766 ), 0, "Backroom", 0, "CHANGE" },
	
	{ Vector( 1156.0899658203, 207.28100585938, 782.28100585938 ), 1, "Warehouse", 50, "WARE1" },
	{ Vector( 1156.0899658203, 115.28099822998, 782.28100585938 ), 1, "Warehouse", 50, "WARE1" },
	
	{ Vector( -1441.4100341797, -142.71899414063, 750.28100585938 ), 0, "45th Apartments" },
	{ Vector( -1441.4100341797, -49.718799591064, 750.28100585938 ), 0, "45th Apartments" },
	{ Vector( -1802, 380.54098510742, 1262 ), 0, "45th Apartments" },
	
	{ Vector( -1724, -455, 878.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-1", 20, "A11" },
	{ Vector( -1610, -143, 878.28100585938 ), 0, "Toilet", 0, "A11" },
	{ Vector( -1723, 33, 878.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-2", 20, "A12" },
	{ Vector( -1610, 289.29998779297, 878.28100585938 ), 0, "Toilet", 0, "A12" },
	{ Vector( -1724, -455.3030090332, 1007.2800292969 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-1", 20, "A21" },
	{ Vector( -1610, -143, 1007.2800292969 ), 0, "Toilet", 0, "A21" },
	{ Vector( -1723, 32.697200775146, 1007.2800292969 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-2", 20, "A22" },
	{ Vector( -1610, 289.2919921875, 1007.2800292969 ), 0, "Toilet", 0, "A22" },
	{ Vector( -1724, -455, 1134.2800292969 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-1", 20, "A31" },
	{ Vector( -1610, -142.69700622559, 1134.2800292969 ), 0, "Toilet", 0, "A31" },
	{ Vector( -1723, 33.000099182129, 1134.2800292969 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-2", 20, "A32" },
	{ Vector( -1610, 289.29998779297, 1134.2800292969 ), 0, "Toilet", 0, "A32" },
	{ Vector( -1724, -454, 1262.2800292969 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-4-1", 20, "A41" },
	{ Vector( -1610, -141.69700622559, 1262.2800292969 ), 0, "Toilet", 0, "A41" },
	{ Vector( -1723, 34.000099182129, 1262.2800292969 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-4-2", 20, "A42" },
	{ Vector( -1610, 289.24700927734, 1262.2800292969 ), 0, "Toilet", 0, "A42" },
	{ Vector( -1724, -455, 1390.2800292969 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-5-1", 20, "A51" },
	{ Vector( -1610, -142.69700622559, 1390.2800292969 ), 0, "Toilet", 0, "A51" },
	{ Vector( -1723, 33.000099182129, 1390.2800292969 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-5-2", 20, "A52" },
	{ Vector( -1610, 289.29998779297, 1390.2800292969 ), 0, "Toilet", 0, "A52" },
	
	{ Vector( -2048, 922, 848 ), 2, "Ration Terminal" },
	
	{ Vector( -66.090797424316, 130.26800537109, 782 ), 1, "Large Store", 100, "LARGE" },
	{ Vector( -66, 222, 782 ), 1, "Large Store", 100, "LARGE" },
	{ Vector( -85.992599487305, 510.09100341797, 1286 ), 1, "Large Store", 100, "LARGE" },
	{ Vector( -536.09100341797, 343.71899414063, 902.28100585938 ), 0, "Room", 0, "LARGE" },
	{ Vector( -536.09100341797, 437.71899414063, 902.28100585938 ), 0, "Room", 0, "LARGE" },
	{ Vector( -448, 292, 774.28100585938 ), 0, "Back Area", 0, "LARGE" },
	{ Vector( -564, 364, 774.28100585938 ), 0, "Men's", 0, "LARGE" },
	{ Vector( -564, 440, 774.28100585938 ), 0, "Women's", 0, "LARGE" },
	
	{ Vector( 367, 1923, 1334.2800292969 ), 1, "Warehouse", 40, "WARE2" },
	{ Vector( 33, 1732, 1334.2800292969 ), 0, "", 0, "WARE2" },
	
	{ Vector( 105, 2895, 1278.2800292969 ), 1, "Apartments", 100 },
	{ Vector( -409, 2644, 1142.2800292969 ), 1, "Apartment B-1-1", 30, "B11" },
	{ Vector( -351, 2644, 1142.2800292969 ), 1, "Apartment B-1-2", 30, "B12" },
	
	{ Vector( 867, 1860, 1438.2800292969 ), 1, "Apartment C-1-1", 20 },
	{ Vector( 937, 1869, 1438.2800292969 ), 1, "Apartment C-1-2", 20 },
	{ Vector( 1111, 1904, 1438.2800292969 ), 1, "Apartment C-1-3", 20 },
	
	{ Vector( 1246.0899658203, 3040.7199707031, 1198 ), 1, "Fat Nargodian", 100, "FAT" },
	{ Vector( 1246.0899658203, 3134.7199707031, 1198.2800292969 ), 1, "Fat Nargodian", 100, "FAT" },
	{ Vector( 1064, 3599, 1150.2800292969 ), 0, "Toilet", 0, "FAT" },
	{ Vector( 836, 3592, 1150.2800292969 ), 0, "Kitchen", 0, "FAT" },
	{ Vector( 765, 3624, 1150.2800292969 ), 0, "Office", 0, "FAT" },
	
	{ Vector( -864, 3585, 1270.2800292969 ), 1, "Room", 30 },
	
	{ Vector( -1663.9100341797, 6144.7202148438, 910.28100585938 ), 1, "Warehouse", 150, "WARE3" },
	{ Vector( -1663.9100341797, 6238.7202148438, 910.28100585938 ), 1, "Warehouse", 150, "WARE3" },
	
	{ Vector( -760, 3617, 930 ), 1, "Apartment D-1-1", 10 },
	
	{ Vector( -223, 3460, 934.28100585938 ), 1, "Souvenir Shop", 15, "SOUV" },
	{ Vector( 9, 3952, 922.28100585938 ), 0, "Toilet", 0, "SOUV" },
	
	{ Vector( -999, 2953, 790.28100585938 ), 1, "Bar", 70, "BAR" },
	{ Vector( -1617, 3133, 790.28100585938 ), 0, "Toilet", 0, "BAR" },
	{ Vector( -1817, 3177, 790.28100585938 ), 0, "Storage", 0, "BAR" },
	
	{ Vector( 807, -1884, 1238.2800292969 ), 1, "Warehouse", 60, "WARE4" },
	{ Vector( 1103, -1592, 1238 ), 0, "", 0, "WARE4" },
	
	{ Vector( 2144, -508, 568 ), 2, "Nexus" },
	{ Vector( 2144, 108, 568 ), 2, "Nexus" },
	{ Vector( 2164.0100097656, 348.01000976563, 568 ), 2, "Prison" },
	{ Vector( 1796, 401, 566.28100585938 ), 0, "Control Room" },
	{ Vector( 1813, 900, 422.28100585938 ), 3, "Cell A1" },
	{ Vector( 1941, 900, 422 ), 3, "Cell A2" },
	{ Vector( 2069, 900, 422.28100585938 ), 3, "Cell A3" },
	{ Vector( 2407, 840, 422.28100585938 ), 3, "Cell B1" },
	{ Vector( 2625, 679, 422.28100585938 ), 3, "Room 101" },
	{ Vector( 2545, 537, 422.28100585938 ), 3, "Room 102" },
	{ Vector( 2780.0100097656, 608.03002929688, 424 ), 2, "Control Room" },
	{ Vector( 2444.0900878906, 255.28100585938, 566.28100585938 ), 0, "Training Area" },
	{ Vector( 2444.0900878906, 161.28100585938, 566.28100585938 ), 0, "Training Area" },
	{ Vector( 3335, 622, 422.28100585938 ), 3, "Simulation" },
	{ Vector( 3340, 820, 422.28100585938 ), 3, "Room 1" },
	{ Vector( 3129, 908, 422 ), 3, "Room 2" },
	{ Vector( 1596, 1137, 566 ), 0, "Locker Room" },
	{ Vector( 2204, 1116.0200195313, 984 ), 2, "Airlock" },
	{ Vector( 2378, 1114.0200195313, 984 ), 2, "Airlock" },
	{ Vector( 2223.9699707031, 476, 984 ), 2, "Control Room" },
	{ Vector( 2390, 411, 1110.2800292969 ), 0, "Observation" },
	{ Vector( 2375, 60, 1108 ), 0, "Briefing" },
	{ Vector( 2281, 60, 1108 ), 0, "Briefing" },
	{ Vector( 1908, 1432, 1368 ), 2, "Nexus" },
	{ Vector( 1976.0100097656, 419.98001098633, 1496 ), 2, "Hangar" },
	{ Vector( 2168.0100097656, 419.98001098633, 1496 ), 2, "Control Room" },
	{ Vector( 1468, -507.98999023438, 1688 ), 2, "Bridge" },
	{ Vector( 2300, -291.98001098633, 2248 ), 2, "Rooftop" },
	{ Vector( 2106.9799804688, -388, 2248 ), 2, "Observation" },
	{ Vector( 3163.9099121094, 642.28100585938, 982.28100585938 ), 0, "Nexus" },
	{ Vector( 3163.9099121094, 734.31500244141, 982.28100585938 ), 0, "Nexus" },
	
	{ Vector( 4392, 735, 1030.2800292969 ), 3, "Hospital" },
	{ Vector( 4391, 641, 1030.2800292969 ), 3, "Hospital" },
	{ Vector( 4753, 1080, 1030.2800292969 ), 3, "Ward" },
	{ Vector( 5239, 1084, 1030.2800292969 ), 3, "Administration" },
	
};

GM.MapChairs = {
	{ Vector( 1045, -3583, 678 ), Angle( 0, -89, 0 ) },
	{ Vector( 1045, -3627, 678 ), Angle( 0, -89, 0 ) },
	{ Vector( 1045, -3123, 677 ), Angle( 0, -89, 0 ) },
	{ Vector( 1045, -3082, 678 ), Angle( 0, -89, 0 ) },
	{ Vector( 1045, -3014, 678 ), Angle( 0, -89, 0 ) },
	{ Vector( 1045, -2977, 678 ), Angle( 0, -89, 0 ) },
	{ Vector( 2862, -2900, 773 ), Angle( 0, 2, 0 ) },
	{ Vector( 2901, -2899, 773 ), Angle( 0, 1, 0 ) },
	{ Vector( 2305, -2905, 773 ), Angle( 0, 1, 0 ) },
	{ Vector( 2270, -2906, 773 ), Angle( 0, -0, 0 ) },
	{ Vector( -1530, 139, 709 ), Angle( 0, 91, 0 ) },
	{ Vector( -1530, 104, 709 ), Angle( 0, 91, 0 ) },
	{ Vector( 3414, -2707, 772 ), Angle( 0, -179, 0 ) },
	{ Vector( 3085, 584, 949 ), Angle( 0, 1, 0 ) },
	{ Vector( 3451, -2707, 773 ), Angle( 0, -179, 0 ) },
	{ Vector( 3051, 584, 949 ), Angle( 0, 1, 0 ) },
	{ Vector( 3506, -2707, 772 ), Angle( 0, -179, 0 ) },
	{ Vector( 2955, 586, 949 ), Angle( 0, 1, 0 ) },
	{ Vector( 3540, -2707, 773 ), Angle( 0, 180, 0 ) },
	{ Vector( 2922, 585, 949 ), Angle( 0, 1, 0 ) },
	{ Vector( 2821, 844, 948 ), Angle( 0, 93, 0 ) },
	{ Vector( 3598, -2707, 772 ), Angle( 0, -179, 0 ) },
	{ Vector( 3633, -2707, 772 ), Angle( 0, -179, 0 ) },
	{ Vector( 2817, 885, 948 ), Angle( 0, 91, 0 ) },
	{ Vector( 2824, 1012, 948 ), Angle( 0, 91, 0 ) },
	{ Vector( 2822, 974, 948 ), Angle( 0, 91, 0 ) },
	{ Vector( 3683, -2708, 772 ), Angle( 0, -179, 0 ) },
	{ Vector( 2821, 1102, 949 ), Angle( 0, 91, 0 ) },
	{ Vector( 3720, -2708, 773 ), Angle( 0, -179, 0 ) },
	{ Vector( 2821, 1139, 949 ), Angle( 0, 91, 0 ) },
	{ Vector( 3719, -2670, 772 ), Angle( 0, 2, 0 ) },
	{ Vector( 3682, -2671, 772 ), Angle( 0, 1, 0 ) },
	{ Vector( 3633, -2669, 773 ), Angle( 0, -0, 0 ) },
	{ Vector( 3598, -2670, 772 ), Angle( 0, 1, 0 ) },
	{ Vector( 3540, -2669, 772 ), Angle( 0, 2, 0 ) },
	{ Vector( 3504, -2670, 773 ), Angle( 0, 2, 0 ) },
	{ Vector( -1418, 1398, 806 ), Angle( 0, -168, 0 ) },
	{ Vector( 3452, -2669, 772 ), Angle( 0, 1, 0 ) },
	{ Vector( -1379, 1406, 806 ), Angle( 0, -167, 0 ) },
	{ Vector( 3413, -2670, 772 ), Angle( 0, 2, 0 ) },
	{ Vector( -1425, 1164, 806 ), Angle( 0, -11, 0 ) },
	{ Vector( -1386, 1156, 805 ), Angle( 0, -11, 0 ) },
	{ Vector( 302, 2645, 1238 ), Angle( 0, 1, 0 ) },
	{ Vector( 265, 2645, 1238 ), Angle( 0, 1, 0 ) },
	{ Vector( 1316, 2435, 1158 ), Angle( 0, -65, 0 ) },
	{ Vector( 1300, 2471, 1158 ), Angle( 0, -65, 0 ) },
	{ Vector( 1133, 3293, 1109 ), Angle( 0, -179, 0 ) },
	{ Vector( 1167, 3294, 1109 ), Angle( 0, -179, 0 ) },
	{ Vector( 1201, 3292, 1109 ), Angle( 0, -179, 0 ) },
	{ Vector( 1164, 3202, 1109 ), Angle( 0, 1, 0 ) },
	{ Vector( 1130, 3201, 1109 ), Angle( 0, 1, 0 ) },
	{ Vector( 1200, 3203, 1109 ), Angle( 0, 1, 0 ) },
	{ Vector( 1134, 3450, 1109 ), Angle( 0, -179, 0 ) },
	{ Vector( 1170, 3451, 1109 ), Angle( 0, -179, 0 ) },
	{ Vector( 1204, 3451, 1109 ), Angle( 0, -178, 0 ) },
	{ Vector( 1168, 3356, 1109 ), Angle( 0, -0, 0 ) },
	{ Vector( 1135, 3356, 1109 ), Angle( 0, 1, 0 ) },
	{ Vector( 1201, 3356, 1109 ), Angle( 0, 1, 0 ) },
	{ Vector( -2340, 3421, 638 ), Angle( 0, -13, 0 ) },
	{ Vector( -2340, 4226, 637 ), Angle( 0, -170, 0 ) },
	{ Vector( -2372, 3429, 637 ), Angle( 0, -13, 0 ) },
	{ Vector( -2788, 3420, 638 ), Angle( 0, -19, 0 ) },
	{ Vector( -2818, 3432, 638 ), Angle( 0, -22, 0 ) },
	{ Vector( -2308, 4231, 638 ), Angle( 0, -170, 0 ) },
	{ Vector( -2150, 4871, 645 ), Angle( 0, 19, 0 ) },
	{ Vector( -2186, 4861, 645 ), Angle( 0, 16, 0 ) },
	{ Vector( -2262, 4855, 645 ), Angle( 0, 1, 0 ) },
	{ Vector( -2293, 4856, 645 ), Angle( 0, -4, 0 ) },
}
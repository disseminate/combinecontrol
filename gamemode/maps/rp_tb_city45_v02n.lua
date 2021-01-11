function GM:GetHL2CamPos()
	
	return { Vector( -1139, 3002, 365 ), Angle( -2, -24, 0 ) };
	
end

function GM:GetCACamPos()
	
	return Vector( 1112, 1361, 2629 );
	
end

function GM:GetCombineCratePos()
	
	return { Vector( 1456, 1636, 598 ), Angle( 0, 180, 0 ) };
	
end

function GM:GetCombineRationPos()
	
	return { Vector( 1462, 1466, 632 ), Angle( 0, 180, 0 ) };
	
end

GM.IntroCamData = { };
GM.IntroCamData[1] = { { Vector( -684, 3434, 458 ), Vector( -699, 3141, 485 ) }, { Angle( -9, -53, 0 ), Angle( -7, -33, 0 ) } };
GM.IntroCamData[2] = { { Vector( 1811, 2638, 423 ), Vector( 1550, 2607, 397 ) }, { Angle( 15, 131, 0 ), Angle( 19, 119, 0 ) } };
GM.IntroCamData[3] = { { Vector( 205, 2344, 247 ), Vector( 202, 2215, 603 ) }, { Angle( -32, -28, 0 ), Angle( 27, -18, 0 ) } };
GM.IntroCamData[4] = { { Vector( 5219, 1701, 76 ), Vector( 5332, 1098, 96 ) }, { Angle( -2, -74, 0 ), Angle( -3, -96, 0 ) } };
GM.IntroCamData[5] = { { Vector( 8375, -2599, -114 ), Vector( 8594, -2620, -120 ) }, { Angle( 2, 32, 0 ), Angle( 3, 42, 0 ) } };
GM.IntroCamData[6] = { { Vector( -1859, 3232, 309 ), Vector( -1987, 3142, 314 ) }, { Angle( -5, -77, 0 ), Angle( -4, -67, 0 ) } };

GM.EntNamesToRemove = {
	"nexus_ind_button*",
	"ind_checkpointdoor",
	"nexus_broadcast_magicbutton",
	"nexus_broadcast_buttonlight2",
	"nexus_broadcast_magicbutton2",
	"nexus_broadcast_magicbutton3",
	"nexus_broadcast_buttonlight1",
	"nexus_broadcast_magicbutton4",
	"nexus_broadcast_camlight_green",
	"nexus_broadcast_camlight_red",
	"nexus_ind_checkpoint_open",
	"nexus_ind_checkpoint_closed",
	"nexus_JW",
	"nexus_JW_button1",
	"nexus_JW_button2",
	"nexus_elevator"
};

GM.Stoves = {
	{ Vector( -1335, 47, 197 ), Angle( 0, -90, 0 ), "BAR", true },
	{ Vector( -1285, -464, 197 ), Angle( 0, 180, 0 ), "BAR", true },
	{ Vector( -3141, 804, 333 ), Angle( 0, 0, 0 ), "D11", true },
	{ Vector( -3131, 1254, 333 ), Angle( 0, -90, 0 ), "D12", true },
	{ Vector( -2565, 1254, 333 ), Angle( 0, -90, 0 ), "D13", true },
	{ Vector( 837, 3207, 337 ), Angle( 0, 90, 0 ), "B12", true },
	{ Vector( 1215, 3204, 337 ), Angle( 0, 90, 0 ), "B11", true },
	{ Vector( 1283, 3370, 334 ), Angle( 0, -90, 0 ), "C13", true },
	{ Vector( 1586, 3375, 334 ), Angle( 0, -90, 0 ), "C12", true },
	{ Vector( 1630, 3655, 334 ), Angle( 0, 1, 0 ), "C11", true },
	{ Vector( 1445, 3657, 334 ), Angle( 0, 180, 0 ), "C14", true },
	{ Vector( 1628, 3653, 462 ), Angle( 0, 0, 0 ), "C21", true },
	{ Vector( 1584, 3377, 462 ), Angle( 0, -90, 0 ), "C22", true },
	{ Vector( 1284, 3374, 462 ), Angle( 0, -90, 0 ), "C23", true },
	{ Vector( 1445, 3655, 462 ), Angle( 0, 180, 0 ), "C24", true },
	{ Vector( 1633, 3653, 590 ), Angle( 0, 0, 0 ), "C31", true },
	{ Vector( 1585, 3378, 590 ), Angle( 0, -90, 0 ), "C32", true },
	{ Vector( 1282, 3375, 590 ), Angle( 0, -90, 0 ), "C33", true },
	{ Vector( 1444, 3655, 590 ), Angle( 0, 180, 0 ), "C34", true },
	{ Vector( 7636, 102, 67 ), Angle( 0, 0, 0 ), "BAR2", true },
	{ Vector( 8206, -1477, 201 ), Angle( 0, 180, 0 ), "SHOP2", true },
};

function GM:MapInitPostEntity()
	
	local cam = ents.FindByName( "nexus_broadcast_camera" )[1];
	cam:SetKeyValue( "FOV", "20" );
	cam:SetPos( cam:GetPos() + Vector( 0, 0, 10 ) );
	
end

GM.CombineSpawnpoints = {
	Vector( 1299, 1630, 577 ),
	Vector( 1295, 1563, 577 ),
	Vector( 1296, 1482, 577 ),
	Vector( 1222, 1481, 577 ),
	Vector( 1219, 1561, 577 ),
	Vector( 1156, 1628, 577 ),
	Vector( 1159, 1561, 577 ),
	Vector( 1156, 1484, 577 ),
	Vector( 1089, 1486, 577 ),
	Vector( 1094, 1560, 577 ),
	Vector( 1014, 1479, 577 )
};

GM.Microphones = {
	{ Vector( -1886, 2559, 476 ), MICROPHONE_BIG },
	{ Vector( 375, 2271, 609 ), MICROPHONE_BIG },
}

GM.MapChairs = {
	{ Vector( 52, 2691, 198 ), Angle( 0, -140, 0 ) },
	{ Vector( 82, 2715, 198 ), Angle( 0, -139, 0 ) },
	{ Vector( 117, 2770, 198 ), Angle( 0, -112, 0 ) },
	{ Vector( 131, 2801, 197 ), Angle( 0, -112, 0 ) },
	{ Vector( 131, 2865, 197 ), Angle( 0, -66, 0 ) },
	{ Vector( 117, 2896, 197 ), Angle( 0, -65, 0 ) },
	{ Vector( 79, 2957, 198 ), Angle( 0, -37, 0 ) },
	{ Vector( 52, 2978, 198 ), Angle( 0, -36, 0 ) },
	{ Vector( 1497, 1468, 317 ), Angle( 0, 91, 0 ) }
}

GM.DoorData = {
	{ Vector( 1383, 3520, 367.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-1-4", 5, "C14" },
	{ Vector( 1763, 3520, 367.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-1-1", 5, "C11" },
	{ Vector( 1677, 3368, 367.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-1-2", 5, "C12" },
	{ Vector( 1405, 3368, 367.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-1-3", 10, "C13" },
	{ Vector( 1383, 3520, 495.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-2-4", 5, "C24" },
	{ Vector( 1763, 3520, 495.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-2-1", 5, "C21" },
	{ Vector( 1677, 3368, 495.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-2-2", 5, "C22" },
	{ Vector( 1405, 3368, 495.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-2-3", 10, "C23" },
	{ Vector( 1383, 3520, 623.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-3-4", 5, "C34" },
	{ Vector( 1763, 3520, 623.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-3-1", 5, "C31" },
	{ Vector( 1677, 3368, 623.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-3-2", 5, "C32" },
	{ Vector( 1405, 3368, 623.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-3-3", 10, "C33" },
	{ Vector( -1548, 2338, 280 ), DOOR_UNBUYABLE, "Trainstation" },
	{ Vector( -1548, 2432, 280 ), DOOR_UNBUYABLE, "Trainstation" },
	{ Vector( -1886, -256, 235.5 ), DOOR_BUYABLE, "Bar", 50, "BAR" },
	{ Vector( -2908, 772, 231 ), DOOR_BUYABLE, "CHANGE Shop B", 40, "CHANGEB" },
	{ Vector( -2980, 772, 231 ), DOOR_BUYABLE, "CHANGE Shop B", 40, "CHANGEB" },
	{ Vector( -2724, 772, 231 ), DOOR_BUYABLE, "CHANGE Shop A", 40, "CHANGEA" },
	{ Vector( -2652, 772, 231 ), DOOR_BUYABLE, "CHANGE Shop A", 40, "CHANGEA" },
	{ Vector( -2532, 1028, 359 ), DOOR_UNBUYABLE, "Apartment Block D" },
	{ Vector( -2532, 956, 359 ), DOOR_UNBUYABLE, "Apartment Block D", 30 },
	{ Vector( -2848, 960, 366 ), DOOR_BUYABLE, "Apartment D-1-1", 20, "D11" },
	{ Vector( -2848, 984, 366 ), DOOR_BUYABLE, "Apartment D-1-2", 20, "D12" },
	{ Vector( -2760, 1064, 366 ), DOOR_BUYABLE, "Apartment D-1-3", 20, "D13" },
	{ Vector( -2666, -385, 243.5 ), DOOR_BUYABLE, "Warehouse", 50 },
	{ Vector( 627.5, 2152.1201171875, 335.57998657227 ), DOOR_COMBINEOPEN, "Nexus" },
	{ Vector( 776, 1720.1199951172, 423.57998657227 ), DOOR_COMBINEOPEN, "Airlock" },
	{ Vector( 476, 1476.1199951172, 903.58001708984 ), DOOR_COMBINEOPEN, "Rooftop" },
	{ Vector( 776, 1540.1199951172, 423.57998657227 ), DOOR_COMBINEOPEN, "Airlock" },
	{ Vector( 750.46002197266, 2298.3400878906, 471.57998657227 ), DOOR_COMBINEOPEN, "Observation" },
	{ Vector( 985, 2290.1201171875, 471.57998657227 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 1236, 1576.1099853516, 333.85998535156 ), DOOR_COMBINELOCK, "Room 101" },
	{ Vector( 1316.2299804688, 1832.1099853516, 333.85998535156 ), DOOR_COMBINELOCK, "Room 102" },
	{ Vector( 1316, 1968.1099853516, 333.85998535156 ), DOOR_COMBINELOCK, "Cell 7" },
	{ Vector( 1316.0799560547, 2096.7800292969, 333.57901000977 ), DOOR_COMBINELOCK, "Cell 6" },
	{ Vector( 1316.0799560547, 2224.7800292969, 333.57901000977 ), DOOR_COMBINELOCK, "Cell 5" },
	{ Vector( 1316.0799560547, 2335.7800292969, 333.57901000977 ), DOOR_COMBINELOCK, "Cell 4" },
	{ Vector( 1136, 1440.1199951172, 343.57998657227 ), DOOR_COMBINEOPEN, "Prison" },
	{ Vector( 1224.6700439453, 2347.3400878906, 333.57901000977 ), DOOR_COMBINELOCK, "Cell 3" },
	{ Vector( 1128.6700439453, 2344.3400878906, 333.57901000977 ), DOOR_COMBINELOCK, "Cell 2" },
	{ Vector( 1032.6700439453, 2344.3400878906, 333.57901000977 ), DOOR_COMBINELOCK, "Cell 1" },
	{ Vector( 1339.9899902344, 1553.1300048828, 327.57998657227 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 1291.9899902344, 1510.1099853516, 327.57998657227 ), DOOR_COMBINEOPEN, "" },
	{ Vector( -1258.5100097656, 2767, 283.28100585938 ), DOOR_UNBUYABLE, "Trainstation", 35 },
	{ Vector( -1258.4399414063, 2861.0200195313, 283.70300292969 ), DOOR_UNBUYABLE, "Trainstation" },
	{ Vector( 4860, 1414, 227 ), DOOR_BUYABLE, "Warehouse", 50, "WARE1" },
	{ Vector( 4932, 1414, 227 ), DOOR_BUYABLE, "Warehouse", 50, "WARE1" },
	{ Vector( 7622, -319.5, 105.5 ), DOOR_BUYABLE, "Bar", 40, "BAR2" },
	{ Vector( 7893, 318, 362 ), DOOR_BUYABLE, "Room", 30 },
	{ Vector( 7872.5, -928, 255.5 ), DOOR_BUYABLE, "Generator Room", 20 },
	{ Vector( 8208, -1988.5, 303.5 ), DOOR_UNBUYABLE, "Apartment Block E" },
	{ Vector( 8455, -1661, 234 ), DOOR_BUYABLE, "Store", 30, "SHOP2" },
	{ Vector( 9404, -2631.9899902344, -161 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 9335.990234375, -2856, -161 ), DOOR_COMBINEOPEN, "Subway Checkpoint 6" },
	{ Vector( -3300, 1680.0100097656, -173 ), DOOR_COMBINEOPEN, "" },
	{ Vector( -3368.0100097656, 1456, -173 ), DOOR_COMBINEOPEN, "Subway Checkpoint 7" },
	{ Vector( 10416, 508, 355 ), DOOR_BUYABLE, "Huge Warehouse", 100, "WARE2" },
	{ Vector( 10344, 508, 355 ), DOOR_BUYABLE, "Huge Warehouse", 100, "WARE2" },
	{ Vector( 12, 1681.5, 238 ), DOOR_BUYABLE, "Cafe Baltic", 15 },
	{ Vector( -372, 1717.5, 238 ), DOOR_BUYABLE, "FOTO Shop", 15, "FOTO" },
	{ Vector( -430.5, 1511.5, 205.5 ), DOOR_UNBUYABLE, "", 0, "FOTO" },
	{ Vector( -2364, 3416.0100097656, 271 ), DOOR_COMBINEOPEN, "", 40, "SHOP1" },
	{ Vector( -2800, 3759.0100097656, 272 ), DOOR_COMBINEOPEN, "Trainstation" },
	{ Vector( -605, 1789.5, 238 ), DOOR_BUYABLE, "Souvenir Shop", 50 },
	{ Vector( 8486.650390625, -1346, 234.28100585938 ), DOOR_UNBUYABLE, "", 0, "SHOP2" },
	{ Vector( 8128.7998046875, -1375.8399658203, 234.28100585938 ), DOOR_UNBUYABLE, "Kitchen", 0, "SHOP2" },
	{ Vector( 8068.08984375, -1324.2700195313, 368.28100585938 ), DOOR_UNBUYABLE, "", 0, "SHOP2" },
	{ Vector( 8068.08984375, -1381.7399902344, 368.56100463867 ), DOOR_UNBUYABLE, "", 0, "SHOP2" },
	{ Vector( 11027, 507, 362.28100585938 ), DOOR_UNBUYABLE, "", 0, "WARE2" },
	{ Vector( 10933, 508, 362.28100585938 ), DOOR_UNBUYABLE, "", 0, "WARE2" },
	{ Vector( 10697, 1788, 362.28100585938 ), DOOR_BUYABLE, "Huge Warehouse", 100, "WARE2" },
	{ Vector( 226.24200439453, 4550, 238.03799438477 ), DOOR_BUYABLE, "Shop", 15 },
	{ Vector( 755, 3184, 238 ), DOOR_UNBUYABLE, "Apartment Block A" },
	{ Vector( 630.82000732422, 3697, 366.28100585938 ), DOOR_BUYABLE, "Apartment A-1-1", 25, "A11" },
	{ Vector( 631, 3697, 494.28100585938 ), DOOR_BUYABLE, "Apartment A-2-1", 25, "A21" },
	{ Vector( 631, 3697, 622.28100585938 ), DOOR_BUYABLE, "Apartment A-3-1", 25, "A31" },
	{ Vector( 1096, 3184, 238.28100585938 ), DOOR_UNBUYABLE, "Apartment Block B" },
	{ Vector( 951, 3454, 370.28100585938 ), DOOR_BUYABLE, "Apartment B-1-2", 30, "B12" },
	{ Vector( 1063, 3454, 370.28100585938 ), DOOR_BUYABLE, "Apartment B-1-1", 30, "B11" },
	{ Vector( 1490, 3184, 244.56300354004 ), DOOR_UNBUYABLE, "Apartment Block C" },
	{ Vector( 1396, 3184, 244.28100585938 ), DOOR_UNBUYABLE, "Apartment Block C" },
	{ Vector( 2356.919921875, 3269.9799804688, 238.28100585938 ), DOOR_BUYABLE, "Shop", 40, "SHOP1" },
	{ Vector( 2290.919921875, 3203.9799804688, 238 ), DOOR_BUYABLE, "Shop", 40, "SHOP1" },
	{ Vector( 1038, 1965.0100097656, 328 ), DOOR_COMBINEOPEN, "Incinerator" },
	{ Vector( -670.66198730469, 4129.0400390625, 246.17700195313 ), DOOR_COMBINELOCK, "Control" },
	{ Vector( -670.66198730469, 4287.0400390625, 246.17700195313 ), DOOR_COMBINELOCK, "Security" },
	{ Vector( -341.42300415039, 4176.5498046875, 246.17700195313 ), DOOR_COMBINELOCK, "Holding Cell" },
	{ Vector( -785, 3887, 242.28100585938 ), DOOR_COMBINELOCK, "Ration Distribution Center" },
};

GM.CurrentLocation = LOCATION_CITY;

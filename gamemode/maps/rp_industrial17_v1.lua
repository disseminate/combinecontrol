function GM:GetHL2CamPos()
	
	return { Vector( 356, 3581, 525 ), Angle( 13, 0, 0 ) };
	
end

function GM:GetCACamPos()
	
	return Vector( 2711, 4057, 3507 );
	
end

function GM:GetCombineCratePos()
	
	return { Vector( 2593, 3954, 1937 ), Angle() };
	
end

function GM:GetCombineRationPos()
	
	return { Vector( 2579, 4012, 1989 ), Angle() };
	
end

GM.EnableAreaportals = true;

GM.IntroCamData = { };
GM.IntroCamData[1] = { { Vector( 593, 3621, 566 ), Vector( 909, 3677, 504 ) }, { Angle( 12, 1, 0 ), Angle( 11, -18, 0 ) } };
GM.IntroCamData[2] = { { Vector( 2093, 4197, 425 ), Vector( 2160, 4441, 450 ) }, { Angle( -3, 75, 0 ), Angle( -34, 74, 0 ) } };
GM.IntroCamData[3] = { { Vector( 3795, 4597, 919 ), Vector( 3629, 4101, 931 ) }, { Angle( -4, -102, 0 ), Angle( -1, -86, 0 ) } };
GM.IntroCamData[4] = { { Vector( 5084, 3105, 401 ), Vector( 4814, 2900, 391 ) }, { Angle( 5, -142, 0 ), Angle( 1, 155, 0 ) } };
GM.IntroCamData[5] = { { Vector( 5668, 4026, 348 ), Vector( 5680, 4536, 433 ) }, { Angle( -5, 93, 0 ), Angle( -0, 148, 0 ) } };
GM.IntroCamData[6] = { { Vector( 1261, 3678, 1509 ), Vector( 1459, 3360, 1582 ) }, { Angle( 53, -16, 0 ), Angle( 54, 30, 0 ) } };

GM.CurrentLocation = LOCATION_CITY;

GM.CombineSpawnpoints = {
	Vector( 2667, 3902, 1921 ),
	Vector( 2666, 3990, 1921 ),
	Vector( 2736, 3988, 1921 ),
	Vector( 2735, 3905, 1921 ),
	Vector( 2798, 3907, 1921 ),
	Vector( 2798, 3985, 1921 ),
	Vector( 2878, 3983, 1921 ),
	Vector( 2876, 3907, 1921 )
};

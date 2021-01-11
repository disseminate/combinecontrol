-- URLs for web integration

GM.MOTDURL = "";
GM.SteamGroupURL = "";
GM.WebsiteURL = "";
GM.UpdatesURL = "";
GM.BooksURL = "";

-- Security

GM.PrivateMode = false;

GM.PrivateSteamIDs = {
	"STEAM_0:0:17359435", -- disseminate
};

GM.TestingClosedMessage = "This server is closed for testing!";

GM.AdminsCanSpawnSENTs = false;

-- Character Creation

GM.QuizEnabled = true;
GM.QuizQuestions = {
	-- Label, { options }, correct option
	{ "1. The farmer went _____ the market.", { "to", "too", "two" }, "to" },
	{ "2. What is 6 * 8?", { "50", "48", "40" }, "48" },
	{ "3. ______ apples are very ripe.", { "They're", "There", "Their" }, "Their" },
	{ "4. ______ is the name of the rebel scientist in Half-Life 2.", { "Kleiner", "Alyx", "Barney" }, "Kleiner" },
	{ "5. ______ of people like candy.", { "Allot", "A lot", "Alot" }, "A lot" }
}

GM.IntroCinematicEnabled = true;
GM.IntroCamText = { };
GM.IntroCamText[1] = "Welcome to the server. This is a Half-Life 2-themed serious roleplay server.\n\nIf you were looking for something else, you can disconnect at any time.";
GM.IntroCamText[2] = "Citizens here live under control of the Combine. Create a character to start off - you're a citizen.\n\nStart a business, sell drugs, put up propaganda for the Combine, furnish an apartment, etc.";
GM.IntroCamText[3] = "The Combine forces are located in the Nexus. Breaking the law will get you punished.\n\nThey can and will beat you randomly, arrest you - or worse.\n\nYou can join them in the F3 menu after your character has existed for a day.";
GM.IntroCamText[4] = "City 18 isn't without its underground - you might find contraband, covert rebels, even black market dealers.\n\nBe sure to look around, but be quiet or the CCA may catch you.";
GM.IntroCamText[5] = "Please note this is an administrated server and admins reserve the right to take disciplinary action for whatever they see fit.\n\nCommon bannable things are punching everything, trying to farm stats, and improper names (you need a first and last name).\n\nJust be smart about what you do in-character vs. out-of-character.";
GM.IntroCamText[6] = "Good luck in City 18.\n\nPick a first and last name at the character creation prompt, and have fun!";

GM.IntroCinematicMusic = "music/hl2_song26_trainstation1.mp3";



GM.MinNameLength = 4;
GM.MaxNameLength = 40;

GM.MaxDescLength = 2000;

GM.MaxCharacters = 10;

GM.CitizenModels = {
	"models/player/group01/male_01.mdl",
	"models/player/group01/male_02.mdl",
	"models/player/group01/male_03.mdl",
	"models/player/group01/male_04.mdl",
	"models/player/group01/male_05.mdl",
	"models/player/group01/male_06.mdl",
	"models/player/group01/male_07.mdl",
	"models/player/group01/male_08.mdl",
	"models/player/group01/male_09.mdl",
	"models/player/group01/female_01.mdl",
	"models/player/group01/female_02.mdl",
	"models/player/group01/female_03.mdl",
	"models/player/group01/female_04.mdl",
	"models/player/group01/female_05.mdl",
	"models/player/group01/female_06.mdl"
};

GM.RebelModels = {
	"models/player/group03/male_01.mdl",
	"models/player/group03/male_02.mdl",
	"models/player/group03/male_03.mdl",
	"models/player/group03/male_04.mdl",
	"models/player/group03/male_05.mdl",
	"models/player/group03/male_06.mdl",
	"models/player/group03/male_07.mdl",
	"models/player/group03/male_08.mdl",
	"models/player/group03/male_09.mdl",
	"models/player/group03/female_01.mdl",
	"models/player/group03/female_02.mdl",
	"models/player/group03/female_03.mdl",
	"models/player/group03/female_04.mdl",
	"models/player/group03/female_05.mdl",
	"models/player/group03/female_06.mdl",
	"models/player/group03m/male_01.mdl",
	"models/player/group03m/male_02.mdl",
	"models/player/group03m/male_03.mdl",
	"models/player/group03m/male_04.mdl",
	"models/player/group03m/male_05.mdl",
	"models/player/group03m/male_06.mdl",
	"models/player/group03m/male_07.mdl",
	"models/player/group03m/male_08.mdl",
	"models/player/group03m/male_09.mdl",
	"models/player/group03m/female_01.mdl",
	"models/player/group03m/female_02.mdl",
	"models/player/group03m/female_03.mdl",
	"models/player/group03m/female_04.mdl",
	"models/player/group03m/female_05.mdl",
	"models/player/group03m/female_06.mdl"
};

-- General Gameplay

GM.UseHunger = false;

GM.FistsHaveEffectOnPlayers = false;
GM.DoorRammingEnabled = true;

GM.MaxLoan = 1000;

GM.StatsAvailable = 40;

GM.UntieOnDeath = false;

GM.OffDutyCombineCanBuyDoors = false;

GM.NotifyWhenPlayersJoin = true;

-- AFK Autokicker

GM.AFKKickerEnabled = true;
GM.AFKPercentage = 0.90;
GM.AFKTime = 600;

-- Cross-Server Transfers

IP_GENERAL = "1.2.3.4";
PORT_CITY = 27015;
PORT_CANAL = 27016;
PORT_OUTLANDS = 27017;
PORT_COAST = 27018;

TRANSITPORT_CITY_GATE = 2;
TRANSITPORT_CITY_SEWER = 3;
TRANSITPORT_CITY_COMBINE = 4;
TRANSITPORT_CAVES_ENTRY = 5;
TRANSITPORT_COAST_ENTRY = 6;

-- Donations

GM.BronzeDonorAmount = 0;
GM.SilverDonorAmount = 15;
GM.GoldDonorAmount = 30;

-- Resources

GM.WorkshopMaps = { };
GM.WorkshopMaps["md_venetianredux_b2fix"]		= 106094354;
GM.WorkshopMaps["rp_c18_v1"] 					= 132931674;
GM.WorkshopMaps["rp_c18_v2"] 					= 132937160;
GM.WorkshopMaps["rp_city8"] 					= 132913036;
GM.WorkshopMaps["rp_city8_2"] 					= 132940295;
GM.WorkshopMaps["rp_city8_canals"] 				= 132911524;
GM.WorkshopMaps["rp_city8_district1"] 			= 132919876;
GM.WorkshopMaps["rp_city8_district9"] 			= 132916875;
GM.WorkshopMaps["rp_city11_night_v1b"] 			= 127632645;
GM.WorkshopMaps["rp_city17_v1"] 				= 113352748;
GM.WorkshopMaps["rp_city23_night"] 				= 143076340;
GM.WorkshopMaps["rp_city45_2013"] 				= 118759412;
GM.WorkshopMaps["rp_city45_catalyst_x1f_final"]	= 221567663;
GM.WorkshopMaps["rp_coast_03_fix"] 				= 132960387;
GM.WorkshopMaps["rp_coast_04"] 					= 132961866;
GM.WorkshopMaps["rp_coast05"] 					= 132962296;
GM.WorkshopMaps["rp_coast_07_final"] 			= 132962909;
GM.WorkshopMaps["rp_coast_09"] 					= 132963389;
GM.WorkshopMaps["rp_coast_12"] 					= 132964637;
GM.WorkshopMaps["rp_industrial17_v1"] 			= 171962560;
GM.WorkshopMaps["rp_outercanals"] 				= 119420070;
GM.WorkshopMaps["rp_shhnexustraining_v1"] 		= 147818395;
GM.WorkshopMaps["rp_tb_city45_v01"] 			= 132933551;
GM.WorkshopMaps["rp_tb_city45_v02n"] 			= 132934734;
GM.WorkshopMaps["rp_tnb_central18nexus_v2"] 	= 133029448;
GM.WorkshopMaps["rp_venetian_iconoclasm"] 		= 119692505;
GM.WorkshopMaps["rp_cc_caves_01"] 				= 242386747;
GM.WorkshopMaps["rp_cc_thecanals_1"] 			= 263502310;
GM.WorkshopMaps["rp_cc_thecanals_2"] 			= 268370407;

-- Items

GM.Recipes = {
	{ { "bleach", "water" }, 				{ "drug_breenwater" } },
	{ { "drug_breenwater", "smallmedkit" }, { "drug_medkit" } },
	{ { "drug_breenwater", "vodka" }, 		{ "drug_vodka" } },
	{ { "drug_vodka", "cookedantliongib" }, { "drug_antlion" } },
	{ { "drug_antlion", "bugbait" }, 		{ "drug_extract" } },
	{ { "beans" }, 							{ "cookedbeans" },				{ "burntbeans" },		1/6 },
	{ { "antliongib" }, 					{ "cookedantliongib" },			{ "burntantliongib" },	1/4 },
	{ { "headcrabgib" }, 					{ "cookedheadcrabgib" },		{ "burntheadcrabgib" },	1/4 },
	{ { "chinese", "water" }, 				{ "cookedchinese" } },
	{ { "teapot", "teabags", "water" }, 	{ "tea", "tea", "tea", "tea" } },
	{ { "teapot", "coffeebeans", "water" }, { "coffee", "coffee", "coffee", "coffee" } },
};

-- Voices

GM.VoicesEnabled = true;
GM.VoiceDelay = 5;

GM.Voices = { };
GM.Voices[GENDER_MALE] = {
	{ "Hi!", "vo/npc/male01/hi01.wav" },
	{ "Nice!", "vo/npc/male01/nice.wav" },
	{ "I can't remember the last time I had a shower.", "vo/npc/male01/question19.wav" },
};
GM.Voices[GENDER_FEMALE] = {
	{ "Hi.", "vo/npc/female01/hi01.wav" },
	{ "Nice.", "vo/npc/female01/nice01.wav" },
	{ "I can't remember the last time I had a shower!", "vo/npc/male01/question19.wav" },
};
GM.Voices[GENDER_CP] = {
	{ "Affirmative.", "npc/metropolice/vo/affirmative.wav" },
	{ "Search.", "npc/metropolice/vo/search.wav" },
};
GM.Voices[GENDER_VORT] = {
	{ "As you wish.", "vo/npc/vortigaunt/asyouwish.wav" },
};

GM.CombineDeathLineEnabled = false;
GM.CombineDeathLine = "Dispatch: $COMBINENAME's vitals have ceased. Remaining units contain.";

-- Sandbox

GM.PropBlacklist = {
	"models/props_c17/oildrum001_explosive.mdl",
	"models/props_junk/gascan001a.mdl",
	"*models/props_phx/",
	"*models/phx/",
	"*models/maxofs2d/",
	"*models/balloons/",
	"*models/perftest/",
	"*models/shadertest/",
	"*models/hunter/",
	"models/cranes/crane_frame.mdl",
	"models/props_c17/metalladder003.mdl",
	"models/props_canal/canal_bridge01.mdl",
	"models/props_canal/canal_bridge02.mdl",
	"models/props_canal/canal_bridge03a.mdl",
	"models/props_combine/prison01c.mdl",
	"models/props_combine/prison01b.mdl",
	"models/props_combine/prison01.mdl",
	"models/props_c17/furniturechair001a.mdl",
	"models/vehicles/car001b_hatchback.mdl",
	"models/props_junk/propane_tank001a.mdl",
	"models/props_combine/combine_bunker01.mdl",
	"models/props_combine/combine_tptimer.mdl",
	"models/props_combine/breen_tube.mdl",
	"models/combine_room/combine_monitor003a.mdl",
	"models/combine_room/combine_monitor002.mdl"
};

GM.PropWhitelist = {
	"models/props_c17/furniturestove001a.mdl",
}

GM.ToolTrustBasic = {
	"weld",
	"duplicator",
	"nocollide",
	"remover",
	"camera",
	"colour",
	"material",
	"rope",
	"winch",
	"ballsocket"
};

GM.ToolTrustBlacklist = {
	"balloon",
	"dynamite",
	"eyeposer",
	"faceposer",
	"finger",
	"inflator",
	"trails",
	"creator"
};

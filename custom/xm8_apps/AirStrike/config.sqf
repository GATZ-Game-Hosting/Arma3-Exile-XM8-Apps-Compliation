/*
Air Strike XM8 App
By Crito @Vanaheim Gaming Servers
https://discord.gg/WEFzqPa
v2.1 05/23/2023
*/

SJlasers = 							///designator class names used for detection of equiped designator in players hands
			[
				"Laserdesignator",
				"Laserdesignator_02",
				"Laserdesignator_03",
				"Laserdesignator_01_khk_F",
				"Laserdesignator_02_ghex_F",
				"CUP_Laserdesignator",
				"CUP_LRTV",
				"CUP_LRTV_ACR"
			];

SJcoolDnTime = 900;					///time in seconds for player to be able to call another air strike

SJflyTime = 180;					///time in seconds the jet stays on map bombing players targets

SJrespectMin = 1000;				///minimum respect required to use air stike app. keeps players from going negative in respect

SJrepPercnt = 0.01;					///cost in percent of players current rep. set to 0 to not use

SJpopTabMin = 1000;					///minimum tabs required to use air strike app. keeps players from going negative in tabs

SJmoneyPercnt = 0.01;				///cost in tabs of players current tabs. set to 0 to not use
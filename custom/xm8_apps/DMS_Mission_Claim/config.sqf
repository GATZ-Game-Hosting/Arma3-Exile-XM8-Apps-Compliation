/**
This Mission Claim script was created for use with DMS Mission System to claim mission with automated mission marker generation.
This code is the intellectual property of Ketanna and Crito, you may modify it as you see fit, but no monitary gains are permitted
using any portion of this code or its core function.

Mission Claim
By Ketanna & Crito @Vanaheim Gaming Servers
https://discord.gg/WEFzqPa
v1.0 10/02/2022
*/

Use_MissionClaimDistanceCheck = false;		// turns on/off distance checks from mission
MissionClaimDistanceCheck = 2000;			// max distance a player can be from a mission to claim it

Use_MissionCLaimAlt_SpeedCheck  = false;	// turns on/off all alt and speed checks
MissionCLaimAlt_Limit = 500;					// max altitude a player can be to claim a mission
MissionCLaimSpeed_Limit = 200;				// max speed a player can be traveling to claim a mission

pMisssionCount = 2;							//If you use some sort of player marker system showing where each other are on the map than set to 2.
											//Default is 1. Anything higher will cause players to be able to calim more than one mission.

//// used as a gate check when looking for marker types to add to the mission claim list box
/// If missions have markers that are not listed here you will need to add them for the mission claim to work on them///////
claimMrkrArray = [
				
					"ExileMissionHardcoreIcon",
					"ExileMissionDifficultIcon",
					"ExileMissionModerateIcon",
					"ExileMissionEasyIcon",
					"ExileMissionCapturePointIcon",
					"o_naval",
					"o_art",
					"Artillary",
					"mil_box",					
					"mil_objective",
					"o_air"
				];
				
				
//// map markers that do not have text, used to determine whether to remove the word Claimed by from a map marker or just clear the map marker text
/// If your mission markers do not have a text next to them on map and are just a marker you will need to add them here also////				
CancelMrkrArray = [
								
					"o_naval",
					"o_art",
					"Artillary",
					"mil_box",					
					"mil_objective"
				];	

///////////If your not sure about the folloing setting do not change them////////////////////////////////////////////////////
Use_ClearBrokenMakers = true;				// used to clear DMS Win Lose markers that break some times and dont clear
Use_ClearBrokenMakers_Message = true;		// sends pop down message to notify players that broken markers were cleared when opening the mission claim script
DMS_MissionMarkerWinDot_Type = "mil_start";	//broken marker types to clear
DMS_MissionMarkerLoseDot_Type =  "mil_end";	//broken marker types to clear
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
				

				
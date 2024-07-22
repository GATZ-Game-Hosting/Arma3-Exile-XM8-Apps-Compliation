 /*
 * XM8 App VTracker
 * Created by - Crito @Vanaheim Gaming Servers
 * Discord - https://discord.gg/WEFzqPa
 * Date Created - 6/03/2023
 * Version - 1
 * Version Date - 6/03/2023
 */

if (isServer) exitWith {};

private["_code"];

{
    _code = compileFinal (preprocessFileLineNumbers (_x select 1));
    missionNamespace setVariable [(_x select 0), _code];
}
forEach
[
	 ['ExileClient_vTracker_network_vTrackerResponse','custom\xm8_apps\vTracker\code\ExileClient_vTracker_network_vTrackerResponse.sqf'],
 	 ['vTracker_MapCenter','custom\xm8_apps\vTracker\code\vTracker_MapCenter.sqf'],
 	 ['vTracker_OFFButton','custom\xm8_apps\vTracker\code\vTracker_OFFButton.sqf'],
 	 ['vTracker_ONButton','custom\xm8_apps\vTracker\code\vTracker_ONButton.sqf'],
 	 ['vTracker_Zoom','custom\xm8_apps\vTracker\code\vTracker_Zoom.sqf']
];

diag_log format["vTrackerClient PreInit Finished"];
 /*
 * XM8 App Rules
 * Created by - Crito @Vanaheim Gaming Servers
 * Discord - https://discord.gg/WEFzqPa
 * Date Created - 5/19/2023
 * Version - 1
 * Version Date - 5/19/2023
 */

disableSerialization;

private _display = uiNameSpace getVariable ["RscExileXM8", displayNull];

createDialog "baseMarkerGUI";

private _baseMrkrdisplay = uiNamespace getVariable "baseMarkerGUI";

private _goBackctrl = _baseMrkrdisplay displayCtrl 97502;
_goBackctrl ctrlCommit 0;
_goBackctrl ctrlSetEventHandler ["ButtonClick", "closeDialog 0;"];
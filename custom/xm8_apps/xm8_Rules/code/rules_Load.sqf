 /*
 * XM8 App Rules
 * Created by - Crito @Vanaheim Gaming Servers
 * Discord - https://discord.gg/WEFzqPa
 * Date Created - 5/19/2023
 * Version - 1
 * Version Date - 5/19/2023
 */

createDialog "rulesGUI";

private _display = uiNamespace getVariable "rulesGUI";

private _rulesTxt = preprocessFile "custom\xm8_apps\xm8_Rules\message.sqf";

((_display) displayCtrl 96504) ctrlSetStructuredText parseText format["%1",_rulesTxt];

private _ctrl = _display displayCtrl 96504;

private _btnCntrl1 = _display displayCtrl 96507;
ctrlSetText [96507, btn1Txt];
_btnCntrl1 ctrlSetURL btn1Link;

private _btnCntrl2 = _display displayCtrl 96506;
ctrlSetText [96506, btn2Txt];
_btnCntrl2 ctrlSetURL btn2Link;

_ctrl ctrlEnable false;
_ctrl ctrlCommit 0;

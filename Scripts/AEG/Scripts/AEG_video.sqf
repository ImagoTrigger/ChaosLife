/*
    File: AEG_system.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to create the AEG Video Dialog and perform related dialog functions.

    Parameters:
    None.

    Execution:
    Executed by pressing the video button in the AEG System dialog.
*/

// By default switch to the camera at the Elektrozavodsk Power plant via function call.
["P_Elek"] spawn AEG_fnc_video;

// Create the dialog.
_nul = createDialog "AEG_Video";
/*
    File: AEG_fnc_zargabad.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    Create a function that will determine which power plant or transformer bus is being affected by a power related event.

    Parameters:
    _this select 0: Name of the pertinent public variable (string).

    Execution:
    Loaded into memory by AEG_init_zargabad.sqf.  Function called by AEG_events.sqf if a power related event has occurred on zargabad.
*/

// Create a function that will determine which power plant or transformer bus is being affected by a power related event.
AEG_fnc_zargabad = 
{
    // Scope //
    private ["_var", "_feeds", "_effect", "_name", "_stack", "_zones", "_events"];

    // Parameter(s) //
    _var = _this;

    // Assign initial values to all variables that will be returned to ensure they are not null.
    _feeds = false; // Determine whether this nodes feeds power to street lamps.
    _effect = ""; // Determine what sounds effects (or smoke effects) are associated with this node.
    _name = ""; // Determine which object this is.
    _stack = ""; // If this is a power plant, determine which smokestack is associated with it.
    _zones = []; // Create an array of zones that this objects feeds/distributes power to if applicable.

    // Determine which which power plant or transformer bus is being affected by a power related event based on the public variable that has changed.
    switch (_var) do
    {
        // V_Zarg (Virtual Object)
        case "AEG_on_V_Zarg":
        {
            _name = "V_Zarg";
        };
        
        // D_Zarg_C
        case "AEG_on_D_Zarg_C":
        {
                _feeds = true;
                _effect = "XFMR";
                _name = "D_Zarg_C";
                _zones = 
                [
                    [[4283.26,4136.65,0], 300, "C1", "Central Zargabad"],
                    [[3761.67,4124.67,0], 300, "C2", "Central Zargabad"],
                    [[4642.65,3929.49,0], 300, "C3", "Central Zargabad"],
                    [[3984.39,4481.66,0], 300, "C4", "Central Zargabad"]
                ];
        };
        
        // D_Zarg_N
        case "AEG_on_D_Zarg_N":
        {
                _feeds = true;
                _effect = "XFMR";
                _name = "D_Zarg_N";
                _zones = 
                [
                    [[3966.7,5824.61,0], 250, "N1", "Northern Zargabad"],
                    [[3774.78,5110.46,0], 300, "N2", "Northern Zargabad"],
                    [[3258.7,4567.36,0], 250, "N3", "Northern Zargabad"],
                    [[2816.72,4995.08,0], 300, "N4", "Northern Zargabad"],
                    [[1970.77,4619.63,0], 200, "N5", "Northern Zargabad"]
                ];
        };
        
        // D_Zarg_S
        case "AEG_on_D_Zarg_S":
        {
                _feeds = true;
                _effect = "XFMR";
                _name = "D_Zarg_S";
                _zones = 
                [
                    [[4077.85,3451.91,0], 300, "Southern Zargabad", ""],
                    [[3821.15,2760.39,0], 300, "S2", "Southern Zargabad"],
                    [[2917.43,3433.75,0], 350, "S3", "Southern Zargabad"],
                    [[3084.58,2786.55,0], 100, "S4", "Southern Zargabad"],
                    [[3393.49,2021.4,0], 250, "S5", "Southern Zargabad"],
                    [[4039.83,2106.94,0], 200, "S6", "Southern Zargabad"],
                    [[5018.92,1908.1,0], 100, "S7", "Southern Zargabad"],
                    [[3215.37,1122.63,0], 100, "S8", "Southern Zargabad"]
                ];
        };
        
        // D_Zarg_V  D_Zarg_V
        case "AEG_on_D_Zarg_V":
        {
                _feeds = true;
                _effect = "XFMR";
                _name = "D_Zarg_V";
                _zones = 
                [
                    [[4774.23,4477.74,0], 250, "V1", "The Villa"]
                ];
        };
        
        // D_Zarg_B
        case "AEG_on_D_Zarg_B":
        {
                _feeds = true;
                _effect = "XFMR";
                _name = "D_Zarg_B";
                _zones = 
                [
                    [[4940.46,6150.89,0], 150, "B1", "Military Base"]
                ];
        };    
    }; // End switch-do.

    // Return the array _events to AEG_events.sqf (no ";" at end of expression)
    _events = [_feeds, _effect, _name, _stack, _zones];
    _events
};
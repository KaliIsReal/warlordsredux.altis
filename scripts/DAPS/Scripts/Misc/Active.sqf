private _v=_this;
if ((count (crew _v)) < 1) exitWith {false};
if !( isEngineOn _v) exitWith {false}; 
if !(_v call DAPS_fnc_HasCharges) exitWith {false};
if !(_v getVariable "dapsActive") exitWith {false};
if !(_v getVariable "dazzlerActivated") exitWith {false};
if !(isEngineOn _v) exitWith {false};
true
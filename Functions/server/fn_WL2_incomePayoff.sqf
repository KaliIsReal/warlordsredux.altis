#include "..\warlords_constants.inc"

_refreshBalance = {
	private _countFaction0 = playersNumber west;
    _fac0Percentage = (1.6 * _countFaction0 / count allPlayers) + 0.2; // We multiply by 1.6 and add 0.2 to get a range of [0.2..1.8] (20% income to 180% income)
	_multiBlu = 2 - _fac0Percentage;
	missionNamespace setVariable ["blanceMultilplierBlu", _multiBlu, true];
	_multiOpf = _fac0Percentage;
	missionNamespace setVariable ["blanceMultilplierOpf", _multiOpf, true];

	{
		_incomeStandard = _x call BIS_fnc_WL2_income;
		_actualIncome = round (_incomeStandard * (if (_x == west) then [{(missionNamespace getVariable "blanceMultilplierBlu")}, {(missionNamespace getVariable "blanceMultilplierOpf")}]));
		if (_x == west) then [{missionNamespace setVariable ["actualIncomeBlu", _actualIncome, true]}, {missionNamespace setVariable ["actualIncomeOpf", _actualIncome, true]}]
	} forEach BIS_WL_competingSides;
};

while {true} do {
	sleep (WL_SECTOR_PAYOFF_PERIOD - 25); // -25 Seconds here to get to the full period with the additional 5 seconds sleep further down.

	call _refreshBalance;

	sleep 20;

	call _refreshBalance;
	
	sleep WL_TIMEOUT_LONG;

	{
		_side = side group _x;

		private _uid = getPlayerUID _x;
		if (_side == west) then {
			if ((missionNamespace getVariable "actualIncomeBlu") < 50) then {
				_incomeStandard = west call BIS_fnc_WL2_income;
				[_uid, 50] spawn BIS_fnc_WL2_fundsDatabaseWrite;
			} else {
				[_uid, (missionNamespace getVariable "actualIncomeBlu")] spawn BIS_fnc_WL2_fundsDatabaseWrite;
			};
		} else {
			if ((missionNamespace getVariable "actualIncomeOpf") < 50) then {
				_incomeStandard = east call BIS_fnc_WL2_income;
				[_uid, 50] spawn BIS_fnc_WL2_fundsDatabaseWrite;
			} else {
				[_uid, (missionNamespace getVariable "actualIncomeOpf")] spawn BIS_fnc_WL2_fundsDatabaseWrite;
			};
		};
	} forEach BIS_WL_allWarlords; // The allPlayers Loop simply fetches the player's side, uses the side to get the appropriate value from the hashmap and applies it.
};
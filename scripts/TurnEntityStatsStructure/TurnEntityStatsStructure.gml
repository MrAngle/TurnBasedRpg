
/// @param {Struct.TurnEntityStatsStruct} _overrides
/// @returns {Struct.TurnEntityStatsStruct}
function TurnEntityStatsStruct(_overrides = {}) constructor {

	/// @type {Struct.__ActionCostStructAbst}
    __ACTION_COST_STAT = {};
	variable_struct_set(__ACTION_COST_STAT, global.ENUMS.ACTION_TYPE.ATTACK.label, new ActionCostStruct(self, global.ENUMS.ACTION_TYPE.ATTACK))
	variable_struct_set(__ACTION_COST_STAT, global.ENUMS.ACTION_TYPE.STAND.label, new ActionCostStruct(self, global.ENUMS.ACTION_TYPE.STAND))
	variable_struct_set(__ACTION_COST_STAT, global.ENUMS.ACTION_TYPE.STEP.label, new ActionCostStruct(self, global.ENUMS.ACTION_TYPE.STEP))

    // === Domyślne statystyki ===
	__FACTION = FACTION_ENUM.NEUTRAL;
    HP = { BASE: 10, CURRENT_HP: 10, MAX_HP: 10 };
    __ACTION_POINTS = 2;
    __PREVIOUS_ACTION_POINTS = 2;
    PHYSICAL_ATTACK = { BASE: 3, STRENGTH_SCALING: 1 };
    CUSTOM = {
        AGILITY: 5,
        STRENGTH: 5,
        INTELLIGENCE: 5,
        LUCK: 1
    };

	getActionPoints = function() {
		return __ACTION_POINTS;
	}

	getCostOfPreviousAction = function() {
		return __ACTION_POINTS - __PREVIOUS_ACTION_POINTS;
	}

	getCurrentHp = function() {
		return HP.CURRENT_HP;
	}

	// === Setters ===
	setFaction = function(factionEnum) {
		__FACTION = factionEnum;
	};

	setHP = function(base, current, max) {
		HP.BASE = base;
		HP.CURRENT_HP = current;
		HP.MAX_HP = max;
	};

	setCurrentHP = function(value) {
		HP.CURRENT_HP = clamp(value, 0, HP.MAX_HP);
	};

	setActionPoints = function(value) {
		__ACTION_POINTS = max(0, value);
	};

	setPhysicalAttack = function(base, scaling) {
		PHYSICAL_ATTACK.BASE = base;
		PHYSICAL_ATTACK.STRENGTH_SCALING = scaling;
	};

	setCustomStat = function(statName, value) {
		CUSTOM[? statName] = value;
	};

	// setCustomStatsBulk = function(_newStatsStruct) {
	// 	// struct_assign(CUSTOM, _newStatsStruct);
	// };
	//

	/// @param {Struct.ActionContextStruct} _actionContextStruct
	__getActionCostToConsume = function (_actionContextStruct) {
		
		/// @param {Struct.ActionCostStruct}
		var actionCostStruct = variable_struct_get(__ACTION_COST_STAT, _actionContextStruct.getAction().getType().label);
		var actionPointsToConsume = actionCostStruct.calculateActionCost(_actionContextStruct);

		return actionPointsToConsume;
	}

	applyActionPoints = function(_actionContextStruct) {
		var apToApply = __getActionCostToConsume(_actionContextStruct);

		__PREVIOUS_ACTION_POINTS = self.__ACTION_POINTS;
		self.__ACTION_POINTS += apToApply;
		return apToApply;
	}

	/// @param {Real} ap_to_subtract - Wartość AP, którą odejmujemy z każdej jednostki.
	prepareActionPointsForNextTurn = function(ap_to_subtract) {
		__ACTION_POINTS -= ap_to_subtract;
		__PREVIOUS_ACTION_POINTS -= ap_to_subtract;
	}

}
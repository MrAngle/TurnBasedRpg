/// @returns {Struct.__ActionCostStructAbst}
function __ActionCostStructAbst() constructor {
	/// @type {Struct.ActionCostStruct} ATTACK
	ATTACK = ActionCostStruct() // global.ENUMS.ACTION_TYPE.ATTACK.label
	/// @type {Struct.ActionCostStruct}
	STAND = ActionCostStruct()   // global.ENUMS.ACTION_TYPE.STAND.label
	/// @type {Struct.ActionCostStruct}
	STEP = ActionCostStruct()		// global.ENUMS.ACTION_TYPE.STEP.label
	
}



/// @function ActionCostStruct
/// @desc Tworzy strukturę reprezentującą koszt konkretnego typu akcji.
/// @param {Real} _base - Bazowy koszt.
/// @param {Real} _min - Minimalny koszt.
/// @param {Real} _max - Maksymalny koszt.
/// @returns {Struct.ActionCostStruct}
function ActionCostStruct(
		_turnEntityStruct,
        _actionCostTypeEnum, 
        _base = global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.DEFAULT_BASE, 
        _min = global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.MIN, 
        _max = global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.MAX) constructor {
	// Pola prywatne
	__turnEntityStruct = weak_ref_create(_turnEntityStruct);
    __actionCostTypeEnum = _actionCostTypeEnum;
	__base = _base;
	__min = _min;
	__max = _max;
	__effects = [];
	
	/// @param {Struct.ActionContextStruct} actionContext
	calculateActionCost = function(actionContext) {
		return __base;
	}
}

/// @function ActionCostStruct
/// @desc Tworzy strukturę reprezentującą koszt konkretnego typu akcji.
/// @param {Real} _base - Bazowy koszt.
/// @param {Real} _min - Minimalny koszt.
/// @param {Real} _max - Maksymalny koszt.
/// @returns {Struct.ActionCostStruct}
function ActionCostStruct(
        _actionCostTypeEnum, 
        _base = global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.DEFAULT_BASE, 
        _min = global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.MIN, 
        _max = global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.MAX) constructor {
	// Pola prywatne
    __actionCostTypeEnum = _actionCostTypeEnum;
	__base = _base;
	__min = _min;
	__max = _max;
	__effects = [];

	// Dodawanie efektów
	addEffect = function(effect) {
		array_push(__effects, effect);
	};

	// Kalkulacja aktualnego kosztu z uwzględnieniem efektów
	calculateCurrentCost = function(context) {
		var cost = __base;

		for (var i = 0; i < array_length(__effects); i++) {
			var effect = __effects[i];
			if (is_callable(effect.modify)) {
				cost = effect.modify(context, cost);
			}
		}

		return clamp(cost, __min, __max);
	};
}
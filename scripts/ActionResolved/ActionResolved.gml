
/// @returns {Struct.__ActionResolvedStruct}
function ActionResolvedStructBuilder(_context_struct) {
    var ars = new __ActionResolvedStruct(_context_struct);
    ars.__INIT();

    return ars;
}

/// @function ActionResolvedStruct
/// @desc Struktura zawierająca pełną akcję (z kontekstem), gotową do predykcji lub wykonania.
///       Umożliwia obliczenie kosztu, predykcję efektów i wykonanie.
/// @param {Struct.ActionContextStruct} _context_struct - Pełny kontekst akcji.
/// @returns {Struct.__ActionResolvedStruct}
function __ActionResolvedStruct(_context_struct) constructor {
	__context_struct = _context_struct;
    /// @type {Struct.ActionExecutorUnitStruct}
    __actionExecutorUnit = noone; //Set by INIT

    /// INIT
    __INIT = function() {
        __actionExecutorUnit = __defineActionExecutorUnitStruct(self);
    }

    // GETTERS
	__getContext = function() { return __context_struct; };
    __getAction = function() { return __context_struct.getAction() }
    __getInvokerStruct = function() { return __getAction().getInvokerTuEnStruct() }

	execute = function() {
		__actionExecutorUnit.execute();
		__getInvokerStruct().addActionPoints(4);
	}

	// // Oblicz koszt (np. dla UI lub walidacji)
	// calculateCost = function() {
	// 	return calculate_action_cost(self);
	// };

	// // Oblicz efekt przed wykonaniem (np. do podświetleń)
	// predictResult = function() {
	// 	return predict_action_result(self);
	// };

	// // Wykonanie efektu (modyfikuje stan gry)
	// apply = function() {
	// 	return execute_action(self);
	// };

}

/// @param {Struct.__ActionResolvedStruct} _arStruct
/// @returns {Struct.ActionExecutorUnitStruct}
function __defineActionExecutorUnitStruct(_arStruct) {
    var action = _arStruct.__getAction();
	var actionType = action.getType()
	switch (actionType) {
		case ACTION_TYPE_ENUM.ATTACK:
			return new ActionAttackExecutorUnitStruct(
				action.getInvokerTuEnObj(), 
				action.getTargetTuEn());
			break;
	
		case ACTION_TYPE_ENUM.STEP:
			return new ActionStepExecutorUnitStruct(
				action.getInvokerTuEnObj(), 
				action.getTargetTile().getRow(), 
				action.getTargetTile().getCol())
			break;
	
		case ACTION_TYPE_ENUM.STAND:
			return new ActionStandExecutorUnitStruct();
			break;
	
		default:
			LOG_CRITICAL_MESSAGE("⚠️ Nieznany typ akcji: " + string(actionType));
			break;
	}
}
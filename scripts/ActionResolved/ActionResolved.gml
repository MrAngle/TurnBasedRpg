
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
	/// @type {Struct.ActionAttackExecutorUnitWrapper}
	__actionExecutorUnitWrapper = noone; //Set by INIT

    /// INIT
    __INIT = function() {
		__actionExecutorUnitWrapper = new ActionAttackExecutorUnitWrapper(self);
        // __actionExecutorUnit = __defineActionExecutorUnitStruct(self);
    }

    // GETTERS
	__getContext = function() { return __context_struct; };
    __getAction = function() { return __context_struct.getAction() }
    __getInvokerStruct = function() { return __getAction().getInvokerTuEnStruct() }

	execute = function() {
		__actionExecutorUnitWrapper.execute();
		// __actionExecutorUnit.execute();

		global.COMBAT_GLOBALS.MANAGERS.COMBAT_EVENT_SERVICE.emitOnTriggerEvents(__getContext())
		__finalizeAction();
	}

	__finalizeAction = function() {
        var _invoker =  __getInvokerStruct();
		if(helper_is_definied(_invoker)) {
			_invoker.consumeActionPoints(__context_struct);
		} else {
			LOG_INFO_MESSAGE("try to finalize action but invoker is not exists: " + string(_invoker))
		}
		
	}
}

/// @param {Struct.__ActionResolvedStruct} _arStruct
/// @returns {Struct.ActionExecutorUnitStruct}
function __defineActionExecutorUnitStruct(_arStruct) {
    var action = _arStruct.__getAction();
	var actionType = action.getType()
	switch (actionType.id) {
		case global.ENUMS.ACTION_TYPE.ATTACK.id:
			return new ActionAttackExecutorUnitStruct(
				action.getInvokerTuEnObj(), 
				action.getOriginTargetTile());
			break;
	
		case global.ENUMS.ACTION_TYPE.STEP.id:
			return new ActionStepExecutorUnitStruct(
				action.getInvokerTuEnObj(), 
				action.getOriginTargetTile().getRow(), 
				action.getOriginTargetTile().getCol())
			break;
	
		case global.ENUMS.ACTION_TYPE.STAND.id:
			return new ActionStandExecutorUnitStruct();
			break;

		case global.ENUMS.ACTION_TYPE.ON_GAME_TURN.id:
			return new ActionGameTurnExecutorUnitStruct();
			break;
	
		default:
			LOG_CRITICAL_MESSAGE("⚠️ Nieznany typ akcji: " + string(actionType));
			break;
	}
}
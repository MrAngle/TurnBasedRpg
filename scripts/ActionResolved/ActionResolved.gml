

/// @param {Struct.ActionContextStruct} _context_struct
/// @returns {Struct.__ActionResolvedStruct}
function ActionResolvedStructBuilder(_context_struct) {
    var strategy;

    switch (_context_struct.getEvaluationMode()) {
        case ACTION_MODE_ENUM.APPLY:
            strategy = ApplyActionResolvedStrategy();
            break;

        case ACTION_MODE_ENUM.PREDICT:
            strategy = PredictActionResolvedStrategy();
            break;

        default:
            LOG_CRITICAL_MESSAGE("Unknown ACTION_MODE_ENUM: " + string(_context_struct.getEvaluationMode()));
            strategy = ApplyActionResolvedStrategy(); // fallback to safe default
    }

    var ars = new __ActionResolvedStruct(_context_struct, strategy);
    ars.__INIT();

    return ars;
}

/// @function ActionResolvedStruct
/// @desc Struktura zawierająca pełną akcję (z kontekstem), gotową do predykcji lub wykonania.
///       Umożliwia obliczenie kosztu, predykcję efektów i wykonanie.
/// @param {Struct.ActionContextStruct} _context_struct
/// @param {Struct.__ActionResolvedExecutionStrategy} _strategy
/// @returns {Struct.__ActionResolvedStruct}
function __ActionResolvedStruct(_context_struct, _strategy) constructor {
	__context_struct = _context_struct;
	__strategy = _strategy;
	/// @type {Struct.ActionExecutorUnitWrapper}
	__actionExecutorUnitWrapper = noone; //Set by INIT

    /// INIT
    __INIT = function() {
		__actionExecutorUnitWrapper = __strategy.actionExecutorUnitWrapperCreator(self); //new ActionExecutorUnitWrapper(self, ApplyWrapperExecutorStrategy()) ;
    }

    // GETTERS
	__getContext = function() { return __context_struct; };
    __getAction = function() { return __context_struct.getAction() }
    __getInvokerStruct = function() { return __getAction().getInvokerTuEnStruct() }

	execute = function() {
		return __strategy.execute(self);

		// __actionExecutorUnitWrapper.execute();

		// global.COMBAT_GLOBALS.MANAGERS.COMBAT_EVENT_SERVICE.emitOnTriggerEvents(__getContext())
		// return __finalizeAction();
	}

	__finalizeAction = function() {
		return __strategy.__finalize(self);
	}

	// __finalizeAction = function() {
	// 	return __strategy.(self);

        // var _invoker =  __getInvokerStruct();
		// if(helper_is_definied(_invoker) && __context_struct.getAction().getFromIntent() != ACTION_INTENT_ENUM.EVENT) {
		// 	_invoker.consumeActionPoints(__context_struct);
		// } else {
		// 	LOG_INFO_MESSAGE("try to finalize action but invoker is not exists: " + string(_invoker));
		// }
		// return true
	// }
}

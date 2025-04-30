/// @function ActionContextStruct
/// @desc Tworzy kontekst akcji – środowisko do kalkulacji / efektów.
///       Bazuje na strukturze akcji lub jest tworzony niezależnie (np. dla predykcji).
///
/// @param {Struct.__ActionStruct} _action_struct - Referencja do akcji.
/// @param {Enum.ACTION_MODE_ENUM} _evaluation_mode - Tryb ewaluacji (SIMULATION, PREDICTION, EXECUTION).
///
/// @returns {Struct.ActionContextStruct}
function ActionContextStruct(_action_struct, _evaluation_mode = ACTION_MODE_ENUM.APPLY) constructor {
	__action_struct = _action_struct;
	__evaluation_mode = _evaluation_mode;

	__effects = [];
	__target_effects = [];
	__metadata = {};
	__source_intent = noone;

	// Getters
    getAction           		= function() { return __action_struct };

    getActionInvokerStruct    	= function() { return getAction().getInvokerTuEnStruct() };

	/// @returns {Array<Struct.__EventTypesEnum>}
	getEventsTypeEnumsToTrigger = function() { return getAction().getEventTypesToTrigger() };

	hasTargetTurnEntity 		= function() { return getAction().getInvokerTuEnObj() };

	getEvaluationMode   		= function() { return __evaluation_mode; };

	getEffects          		= function() { return __effects; };

	getTargetEffects    		= function() { return __target_effects; };

	getMetadata         		= function() { return __metadata; };

	getSourceIntent     		= function() { return __source_intent; };

	// Setters
	setEffects          		= function(list) { __effects = list; };
	setTargetEffects    		= function(list) { __target_effects = list; };
	setMetadata         		= function(m) { __metadata = m; };
	setSourceIntent     		= function(i) { __source_intent = i; };
}
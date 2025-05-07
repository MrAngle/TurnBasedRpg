

/// @returns {Struct.ExecutionStrategy}
function ApplyWrapperExecutorStrategy() {
    return new ExecutionStrategy(
        "ApplyWrapperExecutorStrategy",
        /// @param {Struct.ActionExecutorUnitStruct} unitStruct
        function(unitStruct) {
            unitStruct.execute();
        }
    )
}

function PredictWrapperExecutorStrategy() {
    return new ExecutionStrategy(
        "PredictWrapperExecutorStrategy",
        /// @param {Struct.ActionExecutorUnitStruct} unitStruct
        function(unitStruct) {
            unitStruct.predict();
        }
    )
};

/// @param {Struct.__ActionResolvedStruct} _actionResolvedStruct
/// @param {Struct.ExecutionStrategy} _executionStrategy - ApplyWrapperExecutorStrategy|PredictWrapperExecutorStrategy
/// @returns {Struct.ActionExecutorUnitWrapper}
function ActionExecutorUnitWrapper(_actionResolvedStruct, _executionStrategy) constructor {
    __actionExecutorUnitStructs = __defineActionExecutorUnitStructArray(_actionResolvedStruct);
    __executionStrategy = _executionStrategy;
    execute = function() {
        if(helper_is_not_definied(__actionExecutorUnitStructs)) {
            LOG_CRITICAL_MESSAGE("actionExecutorUnitStructs is not defined");
            return;
        }

        for (var i = 0; i < array_length(__actionExecutorUnitStructs); i++) {
            var unitStruct = __actionExecutorUnitStructs[i];
            __executionStrategy.run(unitStruct);
        }
    };
}

/// @param {Struct.__ActionResolvedStruct} _arStruct
/// @returns {Array<Struct.ActionExecutorUnitStruct>}
function __defineActionExecutorUnitStructArray(_arStruct) {
    var action = _arStruct.__getAction();
    var tileArray = action.calculateGetTargetTiles();
    var factoryFn = __defineActionExecutorUnitStructFactory(action.getType());

    var result = [];

    for (var i = 0; i < array_length(tileArray); i++) {
        var tile = tileArray[i];
        var unitStruct = factoryFn(action, tile);
        if (unitStruct != undefined) array_push(result, unitStruct);
    }

    return result;
}

function __defineActionExecutorUnitStructFactory(actionType) {
    switch (actionType.id) {
        case global.ENUMS.ACTION_TYPE.ATTACK.id:
            return function(_action, _tile) {
                return new ActionAttackExecutorUnitStruct(
                    _action.getInvokerTuEnObj(),
                    _tile
                );
            };

        case global.ENUMS.ACTION_TYPE.STEP.id:
            return function(_action, _tile) {
                return new ActionStepExecutorUnitStruct(
                    _action,
                    _action.getInvokerTuEnObj(),
                    _tile.getRow(),
                    _tile.getCol()
                );
            };

        case global.ENUMS.ACTION_TYPE.STAND.id:
            return function(_action, _tile) {
                return new ActionStandExecutorUnitStruct();
            };

        case global.ENUMS.ACTION_TYPE.ON_GAME_TURN.id:
            return function(_action, _tile) {
                return new ActionGameTurnExecutorUnitStruct();
            };

        default:
            LOG_CRITICAL_MESSAGE("⚠️ Nieznany typ akcji: " + string(actionType));
            return function(_action, _tile) { return undefined; };
    }
}
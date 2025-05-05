/// @param {string} _strategyName The name of the strategy
/// @param {function(Struct.ActionExecutorUnitStruct)} _runFunc The function to run for each unit struct
function ExecutionStrategy(_strategyName, _runFunc) constructor {
    name = _strategyName;
    run = _runFunc;
}


function ActionResolvedExecutionStrategyBuilder() constructor {
    var _strategyName = "UnnamedStrategy";
    var _wrapperCreator = function(_) { return noone; };
    var _execute = function(_) { return true; };
    var _finalize = function(_) { return true; };

    setName = function(name) {
        _strategyName = name;
        return self;
    };

    setWrapperCreator = function(fn) {
        _wrapperCreator = fn;
        return self;
    };

    setExecute = function(fn) {
        _execute = fn;
        return self;
    };

    setFinalize = function(fn) {
        _finalize = fn;
        return self;
    };

    build = function() {
        return new __ActionResolvedExecutionStrategy(
            _strategyName,
            _wrapperCreator,
            _execute,
            _finalize
        );
    };
}


function __ActionResolvedExecutionStrategy(
    _strategyName,
    _actionExecutorUnitWrapperCreator,
    _execute,
    _finalize
) constructor {
    name = _strategyName;

    /// @function actionExecutorUnitWrapperCreator
    /// @desc Funkcja przyjmująca __ActionResolvedStruct i zwracająca odpowiedniego wrappera.
    actionExecutorUnitWrapperCreator = _actionExecutorUnitWrapperCreator;

    /// @function execute
    /// @desc Główna logika wykonania akcji.
    execute = _execute;

    /// @function __finalize
    /// @desc Końcowa logika po wykonaniu akcji.
    __finalize = _finalize;
}
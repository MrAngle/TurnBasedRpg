
/// @returns {Struct.__ActionResolvedExecutionStrategy}
function PredictActionResolvedStrategy() {
    return new ActionResolvedExecutionStrategyBuilder()
        .setName("PredictStrategy")

        .setWrapperCreator(
            /// @param {Struct.__ActionResolvedStruct} ars
            /// @returns {Struct.ActionExecutorUnitWrapper}
            function(ars) {
                return new ActionExecutorUnitWrapper(ars, PredictWrapperExecutorStrategy());
            }
        )

        .setExecute(
            /// @param {Struct.__ActionResolvedStruct} ars
            /// @returns {Bool}
            function(ars) {
                ars.__actionExecutorUnitWrapper.execute(); // predict
                return true;
            }
        )

        .setFinalize(
            /// @param {Struct.__ActionResolvedStruct} ars
            /// @returns {Bool}
            function(ars) {
                return false;
            }
        )
        .build();
}
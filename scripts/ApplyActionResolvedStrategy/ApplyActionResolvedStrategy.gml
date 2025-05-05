
/// @returns {Struct.__ActionResolvedExecutionStrategy}
function ApplyActionResolvedStrategy() {
    return new ActionResolvedExecutionStrategyBuilder()
		.setName("ApplyStrategy")
		.setWrapperCreator(		
			/// @param {Struct.__ActionResolvedStruct} ars
			/// @returns {Struct.ActionExecutorUnitWrapper}
			function(ars) { 
				return new ActionExecutorUnitWrapper(ars, ApplyWrapperExecutorStrategy());
			}
		)
		.setExecute( 		
			/// @param {Struct.__ActionResolvedStruct} ars 
			/// @returns {Bool}
			function(ars) {
				ars.__actionExecutorUnitWrapper.execute();
				global.COMBAT_GLOBALS.MANAGERS.COMBAT_EVENT_SERVICE.emitOnTriggerEvents(ars.__getContext());
				
                return ars.__finalizeAction();
                // return true;
			}
		)
		.setFinalize(
			/// @param {Struct.__ActionResolvedStruct} ars
			/// @returns {Bool}
			function(ars) {
				var _invoker = ars.__getInvokerStruct();
				if (helper_is_definied(_invoker) && ars.__getAction().getFromIntent() != ACTION_INTENT_ENUM.EVENT) {
					_invoker.consumeActionPoints(ars.__getContext());
				}
				return true;
			}
		)
        .build();
}

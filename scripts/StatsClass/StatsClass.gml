global.STATS_NAME_TYPE = "STAT_TYPE";
global.STATS_NAME_BASE_VALUE_FUNC = "BASE_VALUE_FUNC";
global.STATS_NAME_SCALING_VALUE_FUNC = "SCALING_VALUE_FUNC";
global.STATS_NAME_SOURCE_FUNC = "STAT_SOURCE_FUNC";
global.STATS_NAME_BONUS_VALUE_FUNC = "BONUS_VALUE_FUNC";

// example
//{
//				    STAT_TYPE: global.STATISTICS.MOVEMENT,
//				    BASE_VALUE_FUNC: VALUE_FUNC(1),
//				    SCALING_VALUE_FUNC: VALUE_FUNC(1),
//				    STAT_SOURCE_FUNC: sklEx.EXCTRACTOR_FUNC(AC_EXTRACTOR_ENUM.INVOKER)
//}

function StatsClass(arg_struct_constr) {
    var structInstance = {
        __properties: arg_struct_constr,
		
		__init: function() {
		    if (helper_function_is_undefined_or_noone(variable_struct_get(__properties, global.STATS_NAME_BONUS_VALUE_FUNC))) {
		        variable_struct_set(__properties, global.STATS_NAME_BONUS_VALUE_FUNC, 
		            CALCULATE_STANDARD_BONUS_VALUE_FUNC(
		                variable_struct_get(__properties, global.STATS_NAME_SOURCE_FUNC), 
		                variable_struct_get(__properties, global.STATS_NAME_TYPE)
		            )
		        );
		    }
		},

		getValueFunc: function() {
			closedFunction = {
				closed_properties: __properties,
				toReturn: function() {
		            var baseValueFunc = variable_struct_get(closed_properties, global.STATS_NAME_BASE_VALUE_FUNC);
		            var scalingValueFunc = variable_struct_get(closed_properties, global.STATS_NAME_SCALING_VALUE_FUNC);
		            var bonusValueFunc = variable_struct_get(closed_properties, global.STATS_NAME_BONUS_VALUE_FUNC);
            
					var baseValue = baseValueFunc();
					var scalingValue = scalingValueFunc();
					var bonusValue = bonusValueFunc();
			
		            var returnValue = global.CALCULATE_STATS_VALUE(baseValue, scalingValue, bonusValue);
					return returnValue;
				}
			}
			return closedFunction.toReturn;
		}
    };
	
	structInstance.__init();
    return structInstance;
}
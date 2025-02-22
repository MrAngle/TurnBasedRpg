global.AREA_FILTER_NAME_AREA_FILTER_FUNC = "AREA_FILTER_FUNC"; // function(properties) return array of tiles // required
global.AREA_FILTER_NAME_STATS_CALC_FUNC = "STATS_CALC_FUNC"; // function() return related stats value // required
global.AREA_FILTER_NAME_SOURCE_TILE_FUNC = "SOURCE_TILE_FUNC"; // function() return tile struct // required
global.AREA_FILTER_NAME_CONDITION_FUNC = "CONDITION_FUNC"; // return true or false

// example
//{
//				    AREA_FILTER_FUNC: global.STATISTICS.MOVEMENT,
//				    STATS_CALC_FUNC: VALUE_FUNC(1),
//				    SOURCE_TILE_FUNC: VALUE_FUNC(1),
//				    CONDITION_FUNC: sklEx.EXCTRACTOR_FUNC(AC_EXTRACTOR_ENUM.INVOKER)
//}
				

function AreaFilterClass(arg_struct_constr) 
{
	var localFilterClass = {
		__priv_params_struct: arg_struct_constr,
		
		__priv_area_filter_func: undefined,
		
		//__areaFilterFunc: undefined, 
		//__statsCalcFunc: undefined, // function() return related stats value // required
		//__sourceTileFunc: undefined, // function() return tile struct // required
		//__conditionFunc: undefined,   // return true or false
		
		__init: function() {
			var area_filter_builder = variable_struct_get(__priv_params_struct, global.AREA_FILTER_NAME_AREA_FILTER_FUNC)
			__priv_area_filter_func = area_filter_builder(__priv_params_struct);
			//__statsCalcFunc = variable_struct_get(arg_struct_constr, global.AREA_FILTER_NAME_STATS_CALC_FUNC)
			//__sourceTileFunc = variable_struct_get(arg_struct_constr, global.AREA_FILTER_NAME_SOURCE_TILE_FUNC)
			//__conditionFunc = variable_struct_get(arg_struct_constr, global.AREA_FILTER_NAME_CONDITION_FUNC)
		},
		
		isConditionTrue: function() {
			var localConditionFunc = variable_struct_get(__priv_params_struct, global.AREA_FILTER_NAME_CONDITION_FUNC)
			if(helper_function_is_undefined_or_noone(localConditionFunc)) {
				return true;
			}
			
			return localConditionFunc();
		},
		
		getTilesToInclude: function() {
			if(isConditionTrue()) {
				//var localAreaFilterFunc = 
				//	variable_struct_get(__priv_params_struct, global.AREA_FILTER_NAME_AREA_FILTER_FUNC)
				
				//var returnValue =  localAreaFilterFunc(__priv_params_struct);
				var returnValue = __priv_area_filter_func();
				return returnValue;
			}
			return [];
		}
	}
	
	localFilterClass.__init(arg_struct_constr);
	return localFilterClass;
}

//PREDEFINE conditionFunc

//function CONDITION_ALWAYS_TRUE
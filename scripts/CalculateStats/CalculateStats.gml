// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

//GENERAL VALUE CALCULATION
global.CALCULATE_STATS_VALUE = function(arg_base_value, arg_scale_value, arg_bonus_value) {
	return arg_base_value + (arg_scale_value * arg_bonus_value);
}

function CALCULATE_STANDARD_BONUS_VALUE_FUNC(arg_source_func, arg_stat_type) {
	closedFunction = {
		_source_func: arg_source_func,
		_stat_type: arg_stat_type,
		toReturn: function() {
			var local_source = _source_func();
			if(helper_character_is_character_type_object(local_source)) {
				return local_source.getCalculatedStatsValue(_stat_type);
			}
			return "Not able to calculate";
		}
	}
	return closedFunction.toReturn;
	
	

}

//function CalculateStats(arg_struct_constr) {
//    var structInstance = {
//        __: arg_struct_constr,
		
//		__init: function() {
			
//		},

//        getValue: function(arg_char) {
//            return structInstance.__baseValueFunc() + (structInstance.__scalingValueFunc() * arg_char[structInstance.__statType]);
//        }
//    };
	
//	structInstance.__init();
//    return structInstance;
//}
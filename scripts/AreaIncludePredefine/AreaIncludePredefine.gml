//// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
//// // https://help.yoyogames.com/hc/en-us/articles/360005277377
//function ActionSelectorFilterClass(arg_filter_name, arg_filter_func) 
//{
//	var _ActionSelectorClass = {
//		__actionSelectorName: arg_filter_name,
//		__actionExecutorFunc: arg_filter_func,
		
//		execute: function(_self, __invoker, __result_SelectorTilesHolderClass, __previous_result_SelectorTilesHolderClass) {
//			show_debug_message("execute: " + __actionSelectorName);
//			__actionExecutorFunc(_self, __invoker, __result_SelectorTilesHolderClass, __previous_result_SelectorTilesHolderClass);
//		}
//	}
	
//	return _ActionSelectorClass;
//}
// ActionAreaIncludePredefine
function ActionAreaFilterBuilder_AllTiles(arg_area_filter_struct) {
	var closedFunc = {
		toReturn: function() {
			return global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles()
		}
	}
	return closedFunc.toReturn;
}

function ActionAreaFilterBuilder_AllTilesInDistance(arg_area_filter_struct) {
	var closedFunc = {
		sourceFunc: variable_struct_get(arg_area_filter_struct, global.AREA_FILTER_NAME_SOURCE_TILE_FUNC),
		valueStatsFunc: variable_struct_get(arg_area_filter_struct, global.AREA_FILTER_NAME_STATS_CALC_FUNC),
		toReturn: function() {
			var localSource = sourceFunc();
			var localValueStatsFunc = valueStatsFunc();
			
			var tilesInDistance = mapTile_filter_within_distance(global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile_by_character(localSource), localValueStatsFunc)
			return global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles([tilesInDistance]);
		}
	}
	return closedFunc.toReturn;
}


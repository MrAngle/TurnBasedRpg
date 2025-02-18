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

function ActionSelectorAreaFilter_AllTiles() {
	var closedFunc = {
		toReturn: function() {
			return global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles()
		}
	}
	return closedFunc.toReturn;
}

function ActionSelectorAreaFilter_AllTilesInDistance(arg_SourceFunc) {
	var closedFunc = {
		sourceFunc: arg_SourceFunc,
		toReturn: function() {
			var tilesInDistance = mapTile_filter_within_distance(global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile_by_character(sourceFunc()), 8)
			return global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles([tilesInDistance]);
		}
	}
	return closedFunc.toReturn;
}


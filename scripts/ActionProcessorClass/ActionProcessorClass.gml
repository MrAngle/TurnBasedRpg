// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function ActionProcessorClass(arg_ActionExecutorFunc) 
{
	var _actionProcessor = {
		__actionExecutorFunc: arg_ActionExecutorFunc,
		
		execute: function(_self, __selector_MySelectorActions) {
			__actionExecutorFunc(_self, __selector_MySelectorActions);
		}
	}
	
	return _actionProcessor;
}

//function ACTION_PROCESSOR_TEMPLATE_MOVE_TO_DESTINATION(_self, __selector_MySelectorActions) {
//	var _charTile = __selector_MySelectorActions[|0];
//	var _destinationTile = __selector_MySelectorActions[|1];
	
//	var resultTile0 = _charTile.__result_SelectorTilesHolderClass.__selector_SelectorTileClass[| 0].__selector_myMapTile;
//	var resultTile1 = _destinationTile.__result_SelectorTilesHolderClass.__selector_SelectorTileClass[| 0].__selector_myMapTile;
	
//	global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.move_to(
//		resultTile1._properties_map_element_row_index, 
//		resultTile1._properties_map_element_col_index, 
//		resultTile0.__character);
//}

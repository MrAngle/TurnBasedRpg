// FUNCTION structure: function(_self, __invoker_char, __selector_MySelectorActions)

function Action_Processor_Move() {
	var standard_move = function() {
		closedFunction = {
			toReturn: function(_self, __invoker_char, __selector_MySelectorActions) {
				var _destinationTile = __selector_MySelectorActions[|0];

				var resultTile1 = _destinationTile.__result_SelectorTilesHolderClass.__selector_SelectorTileClass[| 0].__selector_myMapTile;
	
				global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.move_to(
					resultTile1.getRow(), 
					resultTile1.getCol(), 
					__invoker_char);
			}
		}
		return closedFunction.toReturn;
	}
	
	return standard_move();
}

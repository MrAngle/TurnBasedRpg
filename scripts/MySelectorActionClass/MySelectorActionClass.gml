// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

function MySelectorActionClass(_selector_function, _numberOfTilesToSelect, 
// opt
	_SELECTOR_TYPE_ENUM = SELECTOR_TYPE_ENUM.SELECTED,
	_SELECTOR_STORE_STRATEGY = SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX)
{
    var _mySelectorActionClass = {
		__selector_function: _selector_function,
		__numberOfTilesToSelect: _numberOfTilesToSelect,
		__SELECTOR_TYPE: _SELECTOR_TYPE_ENUM,
		__SELECTOR_STORE_STRATEGY: _SELECTOR_STORE_STRATEGY,
		//__next_MySelectorActionClass: _next_MySelectorActionClass, // MySelectorActionClass
		
		__result_selectedTiles: noone, // SelectorTilesHolderClass
		//__previous_MySelectorActionClass: _previous_MySelectorActionClass, // MySelectorActionClass
		
		__action_finished: false,
		
		// constructor
		__init_MySelectorActionClass: function() {
			__result_selectedTiles = 
				SelectorTilesHolderClass(
					__numberOfTilesToSelect, 
					__SELECTOR_TYPE, 
					__SELECTOR_STORE_STRATEGY);
	    },
		
		execute: function(_self) {
			if(__action_finished) {
				return;
			}
			
			__action_finished = __selector_function(_self, __result_selectedTiles);
		}
	};
	
	_mySelectorActionClass.__init_MySelectorActionClass();
	return _mySelectorActionClass;
}


function MySelectorActionManagerClass(_dsListOfMySelectorActionClass)
{
    var _mySelectorActionManagerClass = {
		__selector_MySelectorActions: _dsListOfMySelectorActionClass,
		__selector_action_index: 0,
		__selector_actions_finished: false,
		//__action_next_function: _action_next_function,
		
		// constructor
		__init_MySelectorActionManagerClass: function() {
	    },
		
		execute: function(_self) {
			if(__selector_action_index >= ds_list_size(__selector_MySelectorActions)) {
				__selector_actions_finished = true;
				return;
			}
			var _actionToInvoke = __selector_MySelectorActions[| __selector_action_index];
			
			_actionToInvoke.execute(_self);
			
			if(_actionToInvoke.__action_finished) {
				__selector_action_index = __selector_action_index + 1;
			}
			
			if(__selector_action_index >= ds_list_size(__selector_MySelectorActions)) {
				__selector_actions_finished = true;
			}
		}
	};
	
	_mySelectorActionManagerClass.__init_MySelectorActionManagerClass();
	return _mySelectorActionManagerClass;
}

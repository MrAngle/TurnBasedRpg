// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
//MyActionClass(selectCharacter, 
//	MyActionClass(selectTile, undefined))



function MyActionClass(_current_function, _next_MyActionClass)
{
    var _myActionClass = {
		__current_function: _current_function,
		__next_MyActionClass: _next_MyActionClass, // MyActionClass
		//__previous_MyActionClass: _previous_MyActionClass, // MyActionClass
		
		__action_finished: false,
		
		// constructor
		__init_MyActionClass: function() {
	    },
		
		execute: function(_self) {
			if(__action_finished) {
				return;
			}
			
			var goToNextAction = __current_function(_self);
			if(goToNextAction == true) {
				if(!helper_is_not_definied(__next_MyActionClass)) {
					__current_function = __next_MyActionClass.__current_function;
				} else {
					__action_finished = true;
				}
			}
		}
	};
	
	_myActionClass.__init_MyActionClass();
	return _myActionClass;
}



function MyActionsManagerClass(_first_MyActionClass, _next_MyActionClass)
{
    var _myActionClass = {
		__action_current_function: _action_current_function,
		__action_next_function: _action_next_function,
		
		// constructor
		__init_MyActionClass: function() {
	    }
	};
	
	_myActionClass.__init_MyActionClass();
	return map_SelectorTilesHolderClass;
}

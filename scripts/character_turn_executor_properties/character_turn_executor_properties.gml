// // // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // // https://help.yoyogames.com/hc/en-us/articles/360005277377
// //function character_turn_executor_properties() 
// //{

// //}

// function properties_load_character_turn_executor()
// {
// 	__priv_properties_action_to_perform = noone; // ActionClass
	
	
// 	turn_exe_get_current_action_to_perform = function() {
// 		return __priv_properties_action_to_perform;
// 	}
	
// 	get_turn_exe_action_to_perform = function(arg_character) {
// 		var closedFunction = {
// 			__actionClass: __priv_properties_action_to_perform,
// 			__character: arg_character,
// 			toReturn: function(_self) {
// 				if(!helper_struct_is_undefined_or_empty(__actionClass) ) {
// 					__actionClass.execute(_self);
// 				}
// 			}
// 		}
// 		return closedFunction.toReturn;
// 	}
	
// 	turn_exe_action_start = function() {
// 		__priv_properties_action_to_perform = prepare_turn_get_actions_selected_to_perform()[0]
// 		__priv_properties_action_to_perform.start(self);
		
// 		global.COMBAT_GLOBALS.SELECTOR.ON_CLICK_EVENT_FUNCTION = self.get_turn_exe_action_to_perform(self);
// 	}

	
	
// }
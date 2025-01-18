// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function properties_load_character_turn()
{
	__properties_action_can_perform = true;
	__properties_action_to_perform = noone; // ActionClass
	
	action_perform = function(arg_character) {
		//var closedAction = function(arg_actionClass) {
			var closedFunction = {
				__actionClass: __properties_action_to_perform,
				__character: arg_character,
				toReturn: function(_self) {
					if(!helper_struct_is_undefined_or_empty(__actionClass) ) {
						__actionClass.execute(_self);
						if(!__actionClass.__isActive) {
							__character.__properties_action_can_perform = false;
						}
					}
				}
			}
			return closedFunction.toReturn;
		//}
		//closedAction(arg_self);
	}
	
	action_set = function(arg_ActionClass) {
		__properties_action_to_perform = arg_ActionClass
		__properties_action_to_perform.start(self);
		
		global.COMBAT_GLOBALS.SELECTOR.ON_CLICK_EVENT_FUNCTION = self.action_perform(self);
	}
}
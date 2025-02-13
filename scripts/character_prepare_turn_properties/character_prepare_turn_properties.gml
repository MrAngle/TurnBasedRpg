// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function properties_load_prepare_character_turn()
{
	//__properties_action_can_perform = true;
	//__properties_action_is_prepared_for_turn = false; // ActionClass
	//__properties_action_is_action_done = false; // ActionClass
	

	__priv_properties_actions_selected_to_perform = noone; // array[] ActionClass

	prepare_turn_get_actions_selected_to_perform = function() {
		return __priv_properties_actions_selected_to_perform;
	}

	prepare_trun_actions_selected_to_perform_set = function(arg_ActionClassArray) {
		__priv_properties_actions_selected_to_perform = arg_ActionClassArray;
	}
	
	prepare_turn_is_prepared_for_turn = function() {
		return helper_is_definied(__priv_properties_actions_selected_to_perform) && is_array(__priv_properties_actions_selected_to_perform);
	}
}
// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function helper_character_is_character_type_object(arg_object) {
	if(!helper_is_definied(arg_object)) {
		return false;
	}

	if (instance_exists(arg_object) && 
			arg_object.object_index == abst_combat_character || 
			object_is_ancestor(arg_object.object_index, abst_combat_character)) {
	    return true;
	}
	return false;
}
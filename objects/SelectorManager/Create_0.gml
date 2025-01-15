instance_create_layer(0, 0, global.LAYERS.selectors.id, HexHoverFieldDecoration);
//instance_create_layer(0, 0, global.LAYERS.selectors.id, HexActiveFieldDecoration);

checkCondition = true;
selectorActionManager = undefined;
//selectorActionManager = getMySelectorActionManagerClass();
alarm[0] = global.COMBAT_GLOBALS.ALARM.COMBAT_MANAGER_INIT_DELAY + 1; // TODO Should be managed by other manager

global.COMBAT_GLOBALS.SELECTOR.ON_CLICK_EVENT_FUNCTION = function(_self) {
	//if(helper_function_is_undefined_or_noone()
	selectorActionManager.execute(_self);
}

__selector_state_select_reset = function() {
	properties_selector_active_tile = noone; // MyMapTile
	properties_selector_active_character = noone; // MyMapTile

	properties_selector_selected_tiles = [];
	properties_selector_selected_units = [];
}


__get_map_tile = function(_row_index, _col_index) {
	return global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(_row_index, _col_index);
}

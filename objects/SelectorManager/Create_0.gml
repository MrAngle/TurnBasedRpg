instance_create_layer(0, 0, global.LAYERS.selectors.id, HexHoverFieldDecoration);
instance_create_layer(0, 0, global.LAYERS.selectors.id, HexActiveFieldDecoration);

checkCondition = true;
selectorActionManager = undefined;
//selectorActionManager = getMySelectorActionManagerClass();
alarm[0] = global.ALARM_TIME_COMBAT_MANAGER_INIT + 1;

global.TILE_SELECTOR_EVENT_ON_CLICK = function(_self) {
	selectorActionManager.execute(_self);
}

__selector_state_select_reset = function() {
	properties_selector_active_tile = noone; // MyMapTile
	properties_selector_active_character = noone; // MyMapTile

	properties_selector_selected_tiles = [];
	properties_selector_selected_units = [];
}


__get_map_tile = function(_row_index, _col_index) {
	return global.myCombatMapHolder.get_tile(_row_index, _col_index);
}

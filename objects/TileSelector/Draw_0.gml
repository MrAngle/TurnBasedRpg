//event_inherited();

//var cood = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile_centrum_coodinators(

if(global.COMBAT_GLOBALS.MAP.SELECTED_TILE != noone && typeof(global.COMBAT_GLOBALS.MAP.SELECTED_TILE)  == global.TYPEOF_STRUCT) {

	x = global.COMBAT_GLOBALS.MAP.SELECTED_TILE.__x_position
	y = global.COMBAT_GLOBALS.MAP.SELECTED_TILE.__y_position
	draw_self();
}
if(global.COMBAT_GLOBALS.MAP.HOVERED_TILE != noone && typeof(global.COMBAT_GLOBALS.MAP.HOVERED_TILE)  == global.TYPEOF_STRUCT) {

	x = global.COMBAT_GLOBALS.MAP.HOVERED_TILE.__x_position
	y = global.COMBAT_GLOBALS.MAP.HOVERED_TILE.__y_position
	draw_self();
}
if(global.myActiveHoveredTile != noone && typeof(global.myActiveHoveredTile)  == global.TYPEOF_STRUCT) {

	x = global.myActiveHoveredTile.__x_position
	y = global.myActiveHoveredTile.__y_position
	draw_self();
}
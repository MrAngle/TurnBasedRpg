if(global.mySelectedTile != noone && typeof(global.mySelectedTile)  == global.TYPEOF_STRUCT) {

	x = global.mySelectedTile.__x_position
	y = global.mySelectedTile.__y_position
	draw_self();
}
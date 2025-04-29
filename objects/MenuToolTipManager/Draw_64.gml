if (	
		my_menu_visible == true &&
		!is_undefined(global.COMBAT_GLOBALS.MAP.HOVERED_TILE) && 
		global.COMBAT_GLOBALS.MAP.HOVERED_TILE != noone && 
		typeof(global.COMBAT_GLOBALS.MAP.HOVERED_TILE) == global.TYPEOF_STRUCT
		) {
	if(my_menu_expanded) {
		/// @type {Struct.MyMapTile}
		myToolTipTile = global.COMBAT_GLOBALS.MAP.HOVERED_TILE;
		show_tooltip();
	} else {
		show_wrapped_menu_text();
		//show_wrapped_tooltip_text();
	}
}

function show_tooltip() {
	draw_set_font(my_font); // Zakładam, że stworzyłeś czcionkę o nazwie "fnt_small_font"

    // Rysowanie tła panelu
    draw_set_color(c_black);
    draw_rectangle(panel_x, panel_y, panel_x + panel_width, panel_y + panel_height, false);

    // Wyświetlanie danych o kafelku
    var info = "Tile Info:\n";
    info += "Row: " + string(myToolTipTile.getRow()) + "\n";
    info += "Col: " + string(myToolTipTile.getCol()) + "\n";
    info += "x: " + string(myToolTipTile.getXPosition()) + "\n";
    info += "y " + string(myToolTipTile.getYPosition()) + "\n";
    // info += "Terrain: " + (is_undefined(myToolTipTile.getTerrain()) ? "None" : myToolTipTile.getTerrain().my_obj_name) + "\n";
    // info += "BG: " + (is_undefined(myToolTipTile.getTerrain().properties_bg_instance) ? "None" : "With bg") + "\n";

	if(helper_is_definied(myToolTipTile.getTerrain())) {
		info += "Terrain: " + (is_undefined(myToolTipTile.getTerrain()) ? "None" : myToolTipTile.getTerrain().my_obj_name) + "\n";
		info += "BG: " + (is_undefined(myToolTipTile.getTerrain().properties_bg_instance) ? "None" : "With bg") + "\n";
	}

	if(helper_is_definied(myToolTipTile.getObstacle())) {
		var obs = myToolTipTile.getObstacle();
		info += "Obstacle: " + obs.my_obj_name + "\n";
	}
	
	if(myToolTipTile.has_character()) {
		var tooltipChar = myToolTipTile.getTurnEntityObj();
		var tooltipCharStruct = myToolTipTile.getTurnEntityStruct();
		info += "Character: " + tooltipChar.my_obj_name + "\n";
		info += "Character HP: " + string(tooltipCharStruct.getCurrentHp()) + "\n";
		info += "Character AP: " + string(tooltipCharStruct.getActionPoints()) + "\n";
	} else {
		info += "Character: None\n";
	}


    draw_set_color(c_white);
    draw_text(panel_x + 10, panel_y + 10, info);
}

//function show_wrapped_tooltip_text() {
//	draw_set_font(MyFontGame_size_10); // Zakładam, że stworzyłeś czcionkę o nazwie "fnt_small_font"

//    // Rysowanie tła panelu
//    draw_set_color(c_black);
//    draw_rectangle(panel_x, panel_y, panel_x + panel_width, panel_y + panel_height, false);

//    var info = "Show Tooltip";

//    draw_set_color(c_white);
//    draw_text(panel_x + 10, panel_y + 10, info);
//}
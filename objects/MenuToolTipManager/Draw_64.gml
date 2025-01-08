if (	
		my_tooltip_visible == true &&
		!is_undefined(global.myActiveHoveredTile) && 
		global.myActiveHoveredTile != noone && 
		typeof(global.myActiveHoveredTile) == global.TYPEOF_STRUCT
		) {
	if(my_tooltip_expanded) {
		myToolTipTile = global.myActiveHoveredTile;
		show_tooltip();
	} else {
		show_wrapped_tooltip_text();
	}
}

function show_tooltip() {
	draw_set_font(MyFontGame_size_10); // Zakładam, że stworzyłeś czcionkę o nazwie "fnt_small_font"

    // Rysowanie tła panelu
    draw_set_color(c_black);
    draw_rectangle(panel_x, panel_y, panel_x + panel_width, panel_y + panel_height, false);

    // Wyświetlanie danych o kafelku
    var info = "Tile Info:\n";
    info += "Row: " + string(myToolTipTile.__row_index) + "\n";
    info += "Col: " + string(myToolTipTile.__col_index) + "\n";
    info += "Terrain: " + (is_undefined(myToolTipTile.__terrain) ? "None" : myToolTipTile.__terrain.my_obj_name) + "\n";
	info += "Character: " + (!myToolTipTile.has_character() ? "None" : myToolTipTile.__character.my_obj_name) + "\n";

    draw_set_color(c_white);
    draw_text(panel_x + 10, panel_y + 10, info);
}

function show_wrapped_tooltip_text() {
	draw_set_font(MyFontGame_size_10); // Zakładam, że stworzyłeś czcionkę o nazwie "fnt_small_font"

    // Rysowanie tła panelu
    draw_set_color(c_black);
    draw_rectangle(panel_x, panel_y, panel_x + panel_width, panel_y + panel_height, false);

    var info = "Show Tooltip";

    draw_set_color(c_white);
    draw_text(panel_x + 10, panel_y + 10, info);
}
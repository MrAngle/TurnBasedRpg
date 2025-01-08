if (my_tooltip_visible) {
	my_tooltip_expanded = !my_tooltip_expanded;
    //var mouse_x = device_mouse_x_to_gui(0);
    //var mouse_y = device_mouse_y_to_gui(0);
    panel_height = my_tooltip_expanded ? 130 : 30; // Wysokość zmienia się w zależności od stanu
    panel_width = my_tooltip_expanded ? 200 : 150; // Wysokość zmienia się w zależności od stanu
	panel_y = + 20;
	//panel_y = display_get_gui_height() - panel_height - 20;

	 

    //// Sprawdź, czy mysz kliknęła w obszar tooltipa
    //if (point_in_rectangle(mouse_x, mouse_y, panel_x, panel_y, panel_x + panel_width, panel_y + panel_height)) {
    //    if (mouse_check_button_pressed(mb_left)) {
    //        tooltip_expanded = !tooltip_expanded; // Zmień stan tooltipa
    //    }
    //}
}
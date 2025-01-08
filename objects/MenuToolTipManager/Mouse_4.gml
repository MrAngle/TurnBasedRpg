if (my_tooltip_visible) {
    //var mouse_x = device_mouse_x_to_gui(0);
    //var mouse_y = device_mouse_y_to_gui(0);

    var panel_x = 20;
    var panel_y = display_get_gui_height() - 150;
    var panel_width = 200;
    var panel_height = my_tooltip_expanded ? 130 : 50; // Wysokość zmienia się w zależności od stanu
	

	 my_tooltip_expanded = !my_tooltip_expanded;

    //// Sprawdź, czy mysz kliknęła w obszar tooltipa
    //if (point_in_rectangle(mouse_x, mouse_y, panel_x, panel_y, panel_x + panel_width, panel_y + panel_height)) {
    //    if (mouse_check_button_pressed(mb_left)) {
    //        tooltip_expanded = !tooltip_expanded; // Zmień stan tooltipa
    //    }
    //}
}
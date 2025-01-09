my_menu_expanded = true;
my_menu_visible = true;
my_font = MyFontGame_size_10;

panel_height = my_menu_expanded ? 130 : 50; // Wysokość zmienia się w zależności od stanu
panel_width = my_menu_expanded ? 200 : 150;
panel_x = 20;
panel_y = + 20;

my_margin_between_menus = 20;
my_margin_elements_menus = 20;

wrapped_menu_text = "Show menu";
//panel_y = display_get_gui_height() - panel_height - 20;



show_wrapped_menu_text = function() {
	draw_set_font(my_font); // Zakładam, że stworzyłeś czcionkę o nazwie "fnt_small_font"

    // Rysowanie tła panelu
    draw_set_color(c_black);
    draw_rectangle(panel_x, panel_y, panel_x + panel_width, panel_y + panel_height, false);

    var info = wrapped_menu_text;

    draw_set_color(c_white);
    draw_text(panel_x + 10, panel_y + 10, info);
}

//// Pobranie rozmiaru GUI (ekranu)
//var gui_w = display_get_gui_width();
//var gui_h = display_get_gui_height();

//// Pozycja przycisku w prawym dolnym rogu GUI
//var button_x = gui_w - button_width - 50;
//var button_y = gui_h - button_height - 50;

// Rysowanie prostokąta przycisku
draw_set_color(c_yellow);
draw_rectangle(button_x, button_y, button_x + button_width, button_y + button_height, false);

// Rysowanie tekstu na przycisku
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(button_x + button_width / 2, button_y + button_height / 2, "End Turn");
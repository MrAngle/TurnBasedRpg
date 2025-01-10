draw_self();

//draw_hexagon(x, y, my_draw_border_radius, my_draw_border_color, my_draw_border_thickness);
//draw_index(self)

//function draw_index() {
//	// Wyświetl numer kolumny i wiersza
//	// Wyświetl numer kolumny i wiersza na środku heksagonu
//	var text = string(self.properties_map_element_row_index) + "," + string(self.properties_map_element_col_index);

//	// Oblicz pozycję tekstu na środku heksagonu
//	var text_x = x - (string_width(text) * 0.5); // Centrowanie w poziomie
//	var text_y = y - (string_height(text) * 0.5); // Centrowanie w pionie

//	draw_set_color(c_purple);
//	// Rysuj tekst
//	draw_text(text_x, text_y, text);
//	draw_set_color(c_white);
//}

//// Funkcja rysująca heksagon
//function draw_hexagon(x, y, radius, color, border_thickness) {
//    var points = 6; // Liczba wierzchołków
//    var step = 360 / points; // Kąt między wierzchołkami
//	var angle_offset = -30; // Przesunięcie o -30° (dla "odwrócenia" heksagonu)

//    // Rysowanie obramowania
//    draw_set_color(color);
//    for (var i = 0; i < points; i++) {
//        var x1 = x + lengthdir_x(radius + border_thickness, angle_offset + i * step);
//        var y1 = y + lengthdir_y(radius + border_thickness, angle_offset + i * step);

//        // Połącz ostatni punkt z pierwszym
//        var x2 = x + lengthdir_x(radius + border_thickness, angle_offset + ((i + 1) % points) * step);
//        var y2 = y + lengthdir_y(radius + border_thickness, angle_offset + ((i + 1) % points) * step);

//        draw_line(x1, y1, x2, y2);
//    }
//    draw_set_color(c_white);
//}
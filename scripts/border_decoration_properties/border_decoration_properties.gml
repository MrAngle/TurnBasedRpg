// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function properties_load_border_decoration() 
{
	properties_is_border_decoration = true;
	
	my_draw_border_color = c_white;
	my_draw_border_radius = global.__map_tile_radius;
	my_draw_border_thickness = 3;
	
	function draw_index(_obj_abst_tile) {
		// Wyświetl numer kolumny i wiersza
		// Wyświetl numer kolumny i wiersza na środku heksagonu
		var text = string(_obj_abst_tile.properties_map_element_row_index) + "," + string(_obj_abst_tile.properties_map_element_col_index);

		// Oblicz pozycję tekstu na środku heksagonu
		var text_x = _obj_abst_tile.x - (string_width(text) * 0.5); // Centrowanie w poziomie
		var text_y = _obj_abst_tile.y - (string_height(text) * 0.5); // Centrowanie w pionie

		draw_set_color(c_purple);
		// Rysuj tekst
		draw_text(text_x, text_y, text);
		draw_set_color(c_white);
	}

	// Funkcja rysująca heksagon
	function draw_hexagon(x, y, radius, color, border_thickness) {
	    var points = 6; // Liczba wierzchołków
	    var step = 360 / points; // Kąt między wierzchołkami
		var angle_offset = -30; // Przesunięcie o -30° (dla "odwrócenia" heksagonu)

	    // Rysowanie obramowania
	    //draw_set_color(c_black);
	    for (var i = 0; i < points; i++) {
	        var x1 = x + lengthdir_x(radius + border_thickness, angle_offset + i * step);
	        var y1 = y + lengthdir_y(radius + border_thickness, angle_offset + i * step);

	        // Połącz ostatni punkt z pierwszym
	        var x2 = x + lengthdir_x(radius + border_thickness, angle_offset + ((i + 1) % points) * step);
	        var y2 = y + lengthdir_y(radius + border_thickness, angle_offset + ((i + 1) % points) * step);

	        //draw_line(x1, y1, x2, y2);
			draw_thick_line(x1, y1, x2, y2, border_thickness, color);
	    }
	    draw_set_color(c_white);
	}


	function draw_thick_line(x1, y1, x2, y2, thickness, color) {
	    // Oblicz wektor normalny do linii
	    var angle = point_direction(x1, y1, x2, y2);
	    var dx = lengthdir_x(thickness / 2, angle + 90);
	    var dy = lengthdir_y(thickness / 2, angle + 90);

	    // Rysuj "grubą" linię jako prostokąt
	    draw_primitive_begin(pr_trianglestrip);
	    draw_vertex_color(x1 - dx, y1 - dy, color, 1);
	    draw_vertex_color(x1 + dx, y1 + dy, color, 1);
	    draw_vertex_color(x2 - dx, y2 - dy, color, 1);
	    draw_vertex_color(x2 + dx, y2 + dy, color, 1);
	    draw_primitive_end();
	}
}
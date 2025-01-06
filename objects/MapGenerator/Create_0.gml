//var r = 64; // Promień heksagonu (wysokość / 2)
//var w = 128; // Szerokość heksagonu
////var w = sqrt(3) * r; // Szerokość heksagonu
//var h = 2 * r; // Wysokość heksagonu
var cols = 13; // Liczba kolumn
var rows = 10; // Liczba wierszy

var margin_x = global.__map_tile_width
var margin_y = global.__map_tile_height

my_map_init(rows, cols)

/// Generowanie heksagonów
for (var row = 0; row < rows; row++) {
    for (var col = 0; col < cols; col++) {
        // Oblicz pozycję X i Y dla każdego heksagonu
        var pos_x = col * global.__map_tile_width + ((row % 2) * (global.__map_tile_width / 2)); // Przesunięcie co drugi wiersz
        var pos_y = row * (1.5 * global.__map_tile_radius);
        
		var tile = instance_create_layer(pos_x + margin_x, pos_y + margin_y, global.LAYERS_GROUND, desert_1_empty);
		
		my_map_set_tile(row, col, tile)
		tile.visible = false;
        // Stwórz obiekt heksagonu
        
		
		// Przypisz kolumnę i wiersz do heksagonu
        tile._init_col = col;
        tile._init_row = row;
    }
}

my_map_show_map();
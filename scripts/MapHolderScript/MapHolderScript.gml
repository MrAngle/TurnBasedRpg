// róznica kafelkow góra dół 21 pixeli góra i dół 

// Tworzenie pustej tablicy
global.__map_holder = array_create(100);
global.__map_rows = 100; // Liczba wierszy
global.__map_cols = 100; // Liczba kolumn

global.__map_tile_radius = 128 - 1; // Promień heksagonu (wysokość / 2)
global.__map_tile_width = 214 - 1; // Szerokość heksagonu
//global.__map_tile_width = sqrt(3) * global.__map_tile_radius; // Szerokość heksagonu
//global.__map_tile_width = 128; // Szerokość heksagonu
//var w = sqrt(3) * r; // Szerokość heksagonu
global.__map_tile_height = 2 * global.__map_tile_radius; // Wysokość heksagonu



function my_map_init(init_rows, init_cols) {
	
    global.__map_holder[init_rows] = array_create(init_cols); // Każdy wiersz to nowa tablica
	global.__map_rows = init_rows
	global.__map_cols = init_cols

	// Stwórz pustą tablicę dla mapy
	global.__map_holder = array_create(global.__map_rows);

	// Zainicjalizuj każdy wiersz jako pustą tablicę
	for (var row = 0; row < global.__map_rows; row++) {
	    global.__map_holder[row] = array_create(global.__map_cols);
	}
}

function my_map_set_tile(row, col, map_tile) {
	global.__map_holder[row][col] = map_tile
}

function my_map_show_map() {
	for (var row = 0; row < global.__map_rows; row++) {
	    for (var col = 0; col < global.__map_cols; col++) {
	        var tile = global.__map_holder[row][col];
	        if (tile != noone) {
	            tile.visible = true; // Ustaw widoczność na true
	        }
	    }
	}
}

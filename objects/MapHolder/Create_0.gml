var init_rows = 100; // Liczba wierszy
var init_cols = 100; // Liczba kolumn

// Tworzenie pustej tablicy
global.hex_grid = array_create(init_rows);

// Inicjalizacja siatki
for (var row = 0; row < init_rows; row++) {
    global.hex_grid[row] = array_create(init_cols); // Każdy wiersz to nowa tablica

    for (var col = 0; col < cols; col++) {
        // Tworzenie danych dla pojedynczego pola
        global.hex_grid[row][col] = {
            x: 0, // Pozycja X na mapie
            y: 0, // Pozycja Y na mapie
          
        };
    }
}
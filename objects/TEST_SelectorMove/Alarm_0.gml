frame_counter = 0; // Licznik klatek
test_passed = true; // Flaga określająca wynik testu

    // Pobranie kafelka na współrzędnych (1, 4)
tile = global.myCombatMapHolder.get_tile(5, 5);

    // Sprawdzenie poprawności kafelka
if (tile == noone) {
    show_debug_message("Test failed: Tile (1, 4) does not exist.");
    return false;
}


startTest = false;
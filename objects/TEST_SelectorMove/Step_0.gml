if(startTest == true) {
	if(frame_counter == 0) {
		show_debug_message("START TEST_SelectorMove");
	}
    // Parametry testu

    // Pobranie współrzędnych kafelka
    //var x_position = tile.__x_position;
    //var y_position = tile.__y_position;

    // Obiekt obsługujący klawisz Escape
    //var escape_handler = obj_escape_handler; // Zamień na właściwy obiekt obsługujący Escape

    // Logika testu wykonywana w evencie Step
    if (frame_counter == 20) {
        helper_simulate_click_at_index(5, 5);
    }
	
	if (frame_counter == 30) {
        helper_simulate_click_at_index(3, 5);
    }
	
	if (frame_counter == 40) {
        helper_simulate_click_at_index(1, 6);
    }
	
	if (frame_counter == 45) {
        helper_simulate_click_at_index(2, 4);
    }
	
	if (frame_counter == 50) {
        helper_simulate_click_at_index(2, 4);
    }
	
	if (frame_counter == 60) {
        helper_simulate_click_at_index(2, 4);
    }

    if (frame_counter == 100) {
        // Klatka 10: Symulacja naciśnięcia Escape
        show_debug_message("Simulating Escape key press.");
        helper_simulate_key_press_escape();
    }

    if (frame_counter > 110) {
        // Weryfikacja wyników
		startTest = false;
        if (test_passed) {
            show_debug_message("Test passed: Tile click and Escape behavior.");
        } else {
            show_debug_message("Test failed.");
        }

        // Zakończenie testu
        return true; // Zwrócenie `true` oznacza zakończenie testu
    }

    // Zwiększenie licznika klatek
    frame_counter++;
    //return false; // Test jeszcze trwa
	
	//alarm[2] = 30;
	
}
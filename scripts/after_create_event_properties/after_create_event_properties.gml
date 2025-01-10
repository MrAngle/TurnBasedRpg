function properties_load_after_create_event() {
	properties_is_after_create_event = true;
	
    // Inicjalizacja flagi wykonania
    after_create_executed = false;
    // Domyślna implementacja after_create_event
    after_create_event = function() {
        if (!after_create_executed) {
            show_debug_message("after_create_event executed.");
            after_create_executed = true; // Ustaw flagę
        }
    };
}
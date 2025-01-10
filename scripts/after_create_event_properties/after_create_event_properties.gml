function properties_load_after_create_executed(_obj) {
    // Inicjalizacja flagi wykonania
    _obj.after_create_executed = false;
    // Domyślna implementacja after_create_event
    _obj.after_create_event = function() {
        if (!after_create_executed) {
            show_debug_message("after_create_event executed.");
            after_create_executed = true; // Ustaw flagę
        }
    };
}
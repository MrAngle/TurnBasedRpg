if(properties_debugger_is_enabled) {
    // Liczba instancji dla konkretnych typów obiektów
    var count_abst_tile = instance_number(abst_tile);
    var count_background_obj = instance_number(background_obj);
    var count_abst_combat_character = instance_number(abst_combat_character);
    var count_HexMapElementGridCoverSelector = instance_number(HexMapElementGridCoverSelector);
    var count_abst_super_manager = instance_number(abst_super_manager);
	
	//LAYERS
	//var managers_instances_on_layer = layer_get_all_instances(global.LAYERS.managers.id);
	//var count_managers = array_length(managers_instances_on_layer);
	//var layer_name = "LayerName"; // Podaj nazwę warstwy
	var count_managers = array_length(layer_get_all_elements(global.LAYERS.managers.id));
	var count_gui_menu = array_length(layer_get_all_elements(global.LAYERS.gui_menu.id));
	var count_gui_game_menu = array_length(layer_get_all_elements(global.LAYERS.gui_game_menu.id));
	
	var count_managing_instances = count_managers + count_gui_menu + count_gui_game_menu;
	
	

	// Przejdź przez wszystkie instancje
	//with (all) {
	//    if (layer_get_name(other.layer) == global.LAYERS.managers.id) {
	//        count_managers += 1;
	//    }
	//}
	
	
    
    // Liczba wszystkich instancji
    var total_instances = instance_count;
	
	var count_instances_without_managers_and_gui = total_instances - count_managing_instances;
    
    // FPS
    var fps_real_value = fps_real; // Rzeczywiste FPS
    
    // Liczba obiektów rysowanych na ekranie (przykład dla rysowania)
    var drawn_instances = 0;
    with (all) {
        if (bbox_right > view_xview[0] && bbox_left < view_xview[0] + view_wview[0] &&
            bbox_bottom > view_yview[0] && bbox_top < view_yview[0] + view_hview[0]) {
            drawn_instances += 1;
			}
    }
    
    // Opcjonalne logowanie krytycznych spadków FPS
    if (fps_real_value < 55) {
        show_debug_message("Krytyczny spadek FPS: " + string(fps_real_value));
    }
	
	global.MY_EMPTY_FUNCTION();
}
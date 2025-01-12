// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function TEST_helpersScripts() 
{

}

//function on_tile_click(row, col) {
//    var tile = global.myCombatMapHolder.get_tile(row, col);
//    if (tile != noone) {
//        tile.on_click(); // Wywołaj logikę kliknięcia kafelka
//    }
//}

//function helper_simulate_click_at_position(_x, _y) {
//    // Ustaw pozycję myszy
//    mouse_x = _x;
//    mouse_y = _y;

//    // Wywołaj zdarzenie kliknięcia
//    event_perform(ev_mouse, ev_mouse_leftbutton);
//}
function helper_simulate_click_at_position(_x, _y) {
    // Pobranie obiektu w danym punkcie
    var clickable_object = instance_position(_x, _y, all);

    // Jeśli znaleziono obiekt, wykonaj na nim symulację kliknięcia
    if (clickable_object != noone) {
		show_debug_message("Simulate click at (" + string(_x) + ", " + string(_y) + ")");
		with (clickable_object) {
            event_perform(ev_mouse, ev_left_press);
		}

    } else {
        // Jeśli nie znaleziono obiektu, wyświetl komunikat
        show_debug_message("No clickable object at (" + string(_x) + ", " + string(_y) + ")");
    }
}

function helper_simulate_click_at_index(_x_index, _y_index) {
    // Pobranie obiektu w danym punkcie
	
	var tile = global.myCombatMapHolder.get_tile(_x_index, _y_index);
	var _x = tile.__x_position;
	var _y = tile.__y_position;
	
    var clickable_object = instance_position(_x, _y, all);

    // Jeśli znaleziono obiekt, wykonaj na nim symulację kliknięcia
    if (clickable_object != noone) {
		show_debug_message(
		"Simulate click at INDEX (" + string(_x_index) + ", " + string(_y_index) + ")" +
		" Position(" + string(_x) + ", " + string(_y) + ")");

		with (clickable_object) {
            event_perform(ev_mouse, ev_left_press);
		}

    } else {
        // Jeśli nie znaleziono obiektu, wyświetl komunikat
        show_debug_message("No clickable object at (" + string(_x) + ", " + string(_y) + ")");
    }
}



function helper_simulate_key_press_escape() {
	
	with (all) {
	    event_perform(ev_keypress, vk_escape)
	}
    //event_perform(ev_keyboard, vk_escape);
}
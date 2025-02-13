// Pobranie pozycji myszy w GUI
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Sprawdzenie, czy mysz jest nad przyciskiem
var over_button = (mx > button_x && mx < button_x + button_width &&
                   my > button_y && my < button_y + button_height);

// Wykrywanie kliknięcia
if (over_button && mouse_check_button_pressed(mb_left)) {
    button_pressed = true;
} else {
    button_pressed = false;
}
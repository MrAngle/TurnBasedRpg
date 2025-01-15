// Pobierz kamerę z View 0
//cam = view_camera[0];

//// Ustaw początkową pozycję kamery
//camera_x = camera_get_view_x(cam);
//camera_y = camera_get_view_y(cam);

//// Prędkość ruchu kamery
//camera_speed = 5;

//var constrParams = get_params_byName_from_global_map(global.CONSTRUCTOR_PARAMS_CAMERA);
//playerRef = constrParams[0]

//1280x720
//resolutioManagerRef = getResolutionManager();
//view_width = getResolutionManager().current_width; // Ustaw jako zmienna instancji
//view_height = getResolutionManager().current_height;// Ustaw jako zmienna instancji


//cam = camera_create();
//camera_set_view_size(cam, 3840, 2160);
//camera_x = camera_get_view_x(cam);
//camera_y = camera_get_view_y(cam);


cam = view_camera[0];
camera_x = camera_get_view_x(cam);
camera_y = camera_get_view_y(cam);

// Prędkość kamery
camera_speed = 20;

view_camera[0] = cam;

// Zmienne kierunku
move_left = false;
move_right = false;
move_up = false;
move_down = false;
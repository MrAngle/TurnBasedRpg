// Pobierz ID aktywnej kamery
var cam = view_get_camera(0);

// Pobierz pozycję i rozmiar kamery
var cam_x = camera_get_view_x(cam); // Lewy górny róg kamery (X)
var cam_y = camera_get_view_y(cam); // Lewy górny róg kamery (Y)
var cam_h = camera_get_view_height(cam); // Wysokość widoku

// Oblicz pozycję w lewym dolnym rogu
x = cam_x + offset_x; // Lewa krawędź kamery + przesunięcie
y = cam_y + cam_h - sprite_height - offset_y; // Dół kamery - wysokość sprite'a - przesunięcie
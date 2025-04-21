// Parametry animacji
lifespan = 30; // Czas życia tekstu w klatkach
alpha = 1;
vertical_speed = -0.5;

// Obliczenie losowych przesunięć na podstawie rozmiaru sprite'a obiektu docelowego
var offset_range_x = target.sprite_width * 0.25; // 25% szerokości sprite'a
var offset_range_y = target.sprite_height * 0.1; // 10% wysokości sprite'a

x += random_range(-offset_range_x, offset_range_x);
y += random_range(-offset_range_y, offset_range_y);

// Tworzenie obiektu Scribble z tekstem obrażeń
text = scribble("[FNT_receiveDamage][c_red]" + string(damage_amount));
text.scale = 3;

// Efekt "maszyny do pisania"
typist = scribble_typist().in(3, 5);
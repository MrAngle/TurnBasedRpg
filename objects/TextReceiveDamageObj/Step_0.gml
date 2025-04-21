// Aktualizacja pozycji i przezroczystości
y += vertical_speed;
alpha -= 1 / lifespan;

if (alpha <= 0) {
    instance_destroy();
}
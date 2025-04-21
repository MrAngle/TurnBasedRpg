if (target != noone && instance_exists(target)) {
    if (timer > 0) {
        timer -= 1;
        target.x = original_x + random_range(-intensity, intensity);
        target.y = original_y + random_range(-intensity, intensity);
    } else {
        target.x = original_x;
        target.y = original_y;
        instance_destroy(); // Usunięcie efektu po zakończeniu
    }
} else {
    instance_destroy(); // Usunięcie efektu, jeśli obiekt docelowy nie istnieje
}
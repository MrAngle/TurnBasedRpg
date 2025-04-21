// Rysowanie tekstu z aktualną przezroczystością
draw_set_alpha(alpha);
text.draw(x, y, typist);
draw_set_alpha(1); // Przywrócenie domyślnej przezroczystości
// Rysowanie samej karty
draw_self();

// Określenie pozycji tekstu
var textX = x + 10;
var textY = y + 10;

var cardName = "Magiczna Karta";
var cardDescription = "Dodaje 5 many";
var cardCost = 3;
draw_set_font(MyFontGame_size_10);
// Tło dla tekstu
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(textX - 5, textY - 5, textX + 1000, textY + 350, false);
draw_set_alpha(1);



// Rysowanie nazwy karty
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_text_transformed(textX, textY, cardName, 2, 2, 0)

draw_text(100, 100, "Test Czcionki");

// Koszt karty
draw_set_halign(fa_right);
draw_text(x + sprite_width - 10, y + 10, string(cardCost));

// Opis karty
draw_set_halign(fa_left);
draw_text(textX, textY + 20, cardDescription);
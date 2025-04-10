for (var i = 0; i < array_length(draw_container); i++) {
    var draw_fn = draw_container[i];
    draw_fn(); // wywołanie funkcji
}
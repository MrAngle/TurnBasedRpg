for (var i = 0; i < array_length(draw_container); i++) {
    var draw_fn = draw_container[i];
    draw_fn(); // wywołanie funkcji
}


// draw_self();

for (var l = 0; l < array_length(__drawLayers); l++) {
    var drawLayer = __drawLayers[l];

    var elementsCount = ds_list_size(drawLayer);
    if (elementsCount > 10) {
        var layerName = "";
        if (drawLayer == __drawStates)  layerName = "STATE";
        if (drawLayer == __drawEffects) layerName = "EFFECT";

        LOG_CRITICAL_MESSAGE("Too many draw elements in " + string(i) + ": " + string(elementsCount));
    }

    for (var i = 0; i < elementsCount; i++) {
        var fn = drawLayer[| i].fn;
        fn(self);
    }
}


// var key_list = ds_map_keys_to_array(onDrawContainer);
// for (var i = 0; i < array_length(key_list); i++) {
//     var fn = onDrawContainer[? key_list[i]];
//     fn(self);
// }
// if (ds_exists(drawOverlays, ds_type_map)) {
//     ds_map_destroy(drawOverlays);
// }

for (var l = 0; l < array_length(__drawLayers); l++) {
    var list = __drawLayers[l];
    if (ds_exists(list, ds_type_list)) {
        ds_list_destroy(list);
    }
}

// (opcjonalnie) wyzeruj wskaźniki
__drawStates  = undefined;
__drawEffects = undefined;
__drawLayers  = undefined;
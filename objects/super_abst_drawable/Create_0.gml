event_inherited();
draw_container = [draw_self];


// Create Event (np. w obiekcie B)
__drawStates  = ds_list_create();
__drawEffects = ds_list_create();

__drawLayers = [
    __drawStates,
    __drawEffects
];

__drawAdd  = function(list, id, fn) {
    if (!is_string(id)) return;
    if (!is_callable(fn)) return;

    // Sprawdź, czy już istnieje — jeśli tak, usuń
    // for (var i = 0; i < ds_list_size(list); i++) {
    //     if (list[| i].id == id) {
    //         ds_list_delete(list, i);
    //         break;
    //     }
    // }

    var entry = { id: id, fn: fn };
    ds_list_add(list, entry);
}

/// @param {Struct.DrawFunction} _drawFunction
drawAddEffect = function(_drawFunction) {
    __drawAdd(__drawEffects, _drawFunction.id, _drawFunction.fn);
}

/// @param {Struct.DrawFunction} _drawFunction
drawAddState = function(_drawFunction) {
    __drawAdd(__drawStates, _drawFunction.id, _drawFunction.fn);
}



// REMOVE actions


__drawRemoveById = function(list, id) {
    if (!ds_exists(list, ds_type_list)) return;
    if (!is_string(id)) return;

    for (var i = 0; i < ds_list_size(list); i++) {
        var entry = list[| i];
        if (is_struct(entry) && entry.id == id) {
            ds_list_delete(list, i);
            break;
        }
    }
}

drawRemoveEffect = function(id) {
    __drawRemoveById(__drawEffects, id);
}

drawRemoveState = function(id) {
    __drawRemoveById(__drawStates, id);
}


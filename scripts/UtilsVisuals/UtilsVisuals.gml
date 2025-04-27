/// PSEUDO INTERFACE
/// CONTRACT FOR GENERIC VISUALS
/// @returns {Struct.VisualGenericStruct}
function VisualGenericStruct() constructor {
    onCreate = function(_self){}
    onStep = function(){}
    onDestroy = function(){}
    onDraw = function() {}
    shouldDestroy = function(){}
}

/// @param {Struct.VisualGenericStruct} _visualGenericStruct
function createVisualGenericObjForObj(_positionReference, _visualGenericStruct) {
    createVisualGenericWithPosition(
        _positionReference.x - _positionReference.sprite_width * 0.5, 
        _positionReference.y - _positionReference.sprite_height,
        _visualGenericStruct);
}

/// @param {Struct.VisualGenericStruct} _visualGenericStruct
function createVisualGenericWithPosition(_x_pos, _y_pos, _visualGenericStruct) {
    instance_create_layer(
        _x_pos, 
        _y_pos,  
        global.LAYERS.gui_effects.id, 
        VisualGenericObj, 
        { visualGenericStruct: _visualGenericStruct }
    );
}

/// @param {Struct.VisualGenericStruct} _visualGenericStruct
function createVisualGeneric(_visualGenericStruct, layerId = global.LAYERS.gui_effects.id) {
    instance_create_layer(
        0, 
        0,  
        layerId, 
        VisualGenericObj, 
        { visualGenericStruct: _visualGenericStruct }
    );
}

/// @function shakeObject(objToShake, intensity, duration)
/// @param {object} objToShake - Obiekt, który ma drgać
/// @param {real} intensity - Intensywność drgania
/// @param {real} duration - Czas trwania drgania w klatkach
function visualsShakeObject(
            objToShake, 
            intensity = global.COMBAT_GLOBALS.VISUAL_PROPERTIES.TILE_RADIUS * 0.2, 
            duration = global.MY_ROOM_SPEED * 0.3) {
    
    var _tile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getTileByTurnEntityObj(objToShake);
                
    
    var closedOnStep = {
        target: objToShake,
        intensity: intensity,
        duration: duration,
        timer: duration,
        original_x: _tile.__x_position,
        original_y: _tile.__y_position,
        onStep: function() {
            timer -= 1;
            target.x = original_x + random_range(-intensity, intensity);
            target.y = original_y + random_range(-intensity, intensity);
        },
        onDestroy: function() {
            if(helper_is_definied(target)) {
                target.x = original_x;
                target.y = original_y;
            } else {
                LOG_CRITICAL_MESSAGE("SD")
            }
        },
        shouldDestroy: function () {
            if (helper_is_not_definied(target)) {
                return true;
            }
            if (timer < 1) {
                return true;
            }
            return false;
        }
    }
    createVisualGenericObjForObj(objToShake, closedOnStep);
}

/// @function draw_scribble_with_background(txt, pos_x, pos_y, bg_color, margin, alpha)
/// @description Rysuje tekst Scribble z dopasowanym tłem.
/// @param txt       Obiekt Scribble (np. scribble("tekst"))
/// @param pos_x     Pozycja X (środek tekstu)
/// @param pos_y     Pozycja Y (środek tekstu)
/// @param bg_color  Kolor tła (np. c_black)
/// @param margin    Margines wokół tekstu (np. 4)
/// @param alpha     Przezroczystość tła (0.0 - 1.0)

function draw_scribble_with_background(txt, pos_x, pos_y, bg_color) {
    var margin = 2;

    // Obliczenie wymiarów tekstu z uwzględnieniem skali
    var text_width = txt.get_width();
    var text_height = 40;

    // Obliczenie pozycji prostokąta tła
    var x1 = pos_x - margin ;
    var y1 = pos_y - margin + 20;
    var x2 = pos_x + text_width + margin;
    var y2 = pos_y + text_height + 20 + margin;

    // Rysowanie prostokąta tła
    draw_set_color(bg_color);
    draw_rectangle(x1, y1, x2, y2, false);
    draw_set_alpha(1); // Przywrócenie pełnej nieprzezroczystości

    // Rysowanie tekstu
    txt.draw(pos_x, pos_y);
}
/// PSEUDO INTERFACE
/// CONTRACT FOR GENERIC VISUALS
/// @returns {Struct.VisualGenericStruct}
function VisualGenericStruct() constructor {
    onStep = function(){}
    onDestroy = function(){}
    shouldDestroy = function(){}
}

/// @param {Struct.VisualGenericStruct} _visualGenericStruct
function createVisualGenericObjForObj(_positionReference, _visualGenericStruct) {
    createVisualGenericObj(
        _positionReference.x - _positionReference.sprite_width * 0.5, 
        _positionReference.y - _positionReference.sprite_height,
        _visualGenericStruct);
}

/// @param {Struct.VisualGenericStruct} _visualGenericStruct
function createVisualGenericObj(_x_pos, _y_pos, _visualGenericStruct) {
    instance_create_layer(
        _x_pos, 
        _y_pos,  
        global.LAYERS.effects.id, 
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
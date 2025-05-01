/// /// @function shakeObject(objToShake, intensity, duration)
/// @param {Struct.MyMapTile} myMapTile
/// @param {real} intensity - Intensywność drgania
/// @param {real} duration - Czas trwania drgania w klatkach
function visualsAttackTileObject(
            myMapTile,
            duration = global.MY_ROOM_SPEED * 0.5) {
                
    /// @type {Struct.VisualGenericStruct} visualGenericStruct
    var visualGenericStruct = {
        _target: myMapTile,
        _duration: duration,

        /// @param {Id.Instance.VisualGenericObj} _self
        onCreate: function(_self) {

            _self.x = _target.getXPosition()
            _self.y = _target.getYPosition();
            _self.original_x = _self.x;
            _self.original_y = _self.y;
            _self.sprite_index = SpriteAttackDefault;

            _self.intensity = global.COMBAT_GLOBALS.VISUAL_PROPERTIES.TILE_RADIUS * 0.2;
            // _self.intensity = 0;
        },
        onStep: function(_self) {
            _duration -= 1;
            
            _self.x = _self.original_x + random_range(-_self.intensity, _self.intensity);
            _self.y = _self.original_y + random_range(-_self.intensity, _self.intensity);
        },
        onDestroy: function() {
        },
        shouldDestroy: function () {
            if (_duration < 1) {
                return true;
            }
            return false;
        }
    }
    createVisualGeneric(visualGenericStruct, global.LAYERS.visual_effects.id);
}
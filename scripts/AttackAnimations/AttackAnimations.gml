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
            _self.sprite_index = SpriteAttackDefault;
        },
        onStep: function() {
            _duration -= 1;
            
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
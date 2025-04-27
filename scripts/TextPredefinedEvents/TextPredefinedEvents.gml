
/// @function TextReceiveDamage(_target, _damage_amount)
/// @param {object} _target - Obiekt, który otrzymał obrażenia
/// @param {real} _damage_amount - Wartość obrażeń do wyświetlenia

function TextReceiveDamage(_target, _damage_amount) {
    var inst = instance_create_layer(
        _target.x - _target.sprite_width * 0.5, 
        _target.y - _target.sprite_height,  
        global.LAYERS.gui_effects.id, 
        TextReceiveDamageObj, 
        { damage_amount: _damage_amount, target : _target }
    );
}


// Its used only to handle on step actions and auto destroy
function VisualGenericStruct() constructor {
    onStep = function(){}
    onDestroy = function(){}
    onDraw = function() {}
    shouldDestroy = function(){}
}

/// @type {Struct.VisualGenericStruct}
var vgs = visualGenericStruct;

// if(helper_is_not_definied(vgs.onDraw)) {
//     vgs.onDraw = function(){}
// }
// if(helper_is_not_definied(vgs.onDestroy)) {
//     vgs.onDestroy = function(){}
// }

var fields = ["onStep", "onDestroy", "onDraw", "shouldDestroy"];

for (var i = 0; i < array_length(fields); i++) {
    var field = fields[i];
    if (!variable_struct_exists(vgs, field)) {
        variable_struct_set(vgs, field, global.MY_EMPTY_FUNCTION);
    }
}

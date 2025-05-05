/// @type {Struct.VisualGenericStruct}
vgs = visualGenericStruct;

var fields = ["onCreate", "onStep", "onDestroy", "onDraw", "shouldDestroy"];

for (var i = 0; i < array_length(fields); i++) {
    var field = fields[i];
    if (!variable_struct_exists(vgs, field)) {
        variable_struct_set(vgs, field, global.MY_EMPTY_FUNCTION);
    }
}

vgs.onCreate(self);

/// @type {Struct.VisualGenericStruct}
var vgs = visualGenericStruct;

if (helper_is_not_definied(vgs) || vgs.shouldDestroy()) {
    vgs.onDestroy()
    instance_destroy();
} else {
    vgs.onStep(self);
}

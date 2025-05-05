/// @type {Struct.VisualGenericStruct}
if (helper_is_not_definied(vgs) || vgs.shouldDestroy(self)) {
    vgs.onDestroy(self)
    instance_destroy();
} else {
    vgs.onStep(self);
}

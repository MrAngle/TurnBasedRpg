/// 

/// @type {Struct.VisualGenericStruct}
var vgs = visualGenericStruct;

if (helper_is_not_definied(vgs) || vgs.shouldDestroy()) {
    instance_destroy();
    visualGenericStruct.onDestroy()
} else {
    vgs.onDraw();
}

// SHOULD BE CREATED BY constructor: HexFieldSelectorDecorationFactory

// Properties:
properties_load_layer();

// Constr Condition =============================================
myMapTileToDecorate = noone; //MyMapTile
selectorTypeEnum = noone; //SELECTOR_TYPE_ENUM

// MUST BE RUN AFTER CREATE - 
HexFieldSelectorDecoration_run_after_constructor = function() {
	switch (self.selectorTypeEnum) {
		case SELECTOR_TYPE_ENUM.ACTIVE:
		    sprite_index = default_active_hex_sprite
			break;
		case SELECTOR_TYPE_ENUM.HOVER:
		    sprite_index = default_hover_hex_sprite
			break;
		case SELECTOR_TYPE_ENUM.SELECTED:
			sprite_index = default_hover_hex_sprite
			break;
		default:
		    // Nieznana strategia, zwracamy false jako domyślną wartość
		    show_debug_message("Unknown SELECTOR_TYPE_ENUM: " + string(self.selectorTypeEnum));
	}
	
	layer_set_default_depth(global.LAYERS.selectors.depth + self.selectorTypeEnum);
	
	self.x = myMapTileToDecorate.__x_position;
	self.y = myMapTileToDecorate.__y_position;
}
//============================================================




// Other params
//isConstructed = false;
//isDrawDecorationActive = false; // when startDraw is true and tileToDecorate == noone it will destroy instance

//global.constructor_HexFieldSelectorDecoration_myMapTileToDecorate = noone;
//global.constructor_HexFieldSelectorDecoration_selectorDecorationTypeEnum = noone;
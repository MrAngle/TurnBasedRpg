// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function properties_load_background_decoration() 
{
	properties_is_background_decoration = true;
	
	properties_bg_sprite = noone;
	properties_bg_instance = noone;
	
	properties_bg_print = function() {
		if (properties_bg_sprite != noone && !instance_exists(properties_bg_instance)) {
	        properties_bg_instance = instance_create_layer(x, y, global.LAYERS.ground.id, background_obj);
	        properties_bg_instance.sprite_index = properties_bg_sprite;
			properties_bg_set_default_depth();
	    }
	};
	
	properties_bg_set_default_depth = function() {
		if(properties_bg_instance != noone) {
			properties_bg_instance.depth = self.depth + global.LAYERS_BACKGROUND_DEPTH_DIFF;
		}
	}
	
	properties_bg_set_depth = function(_depth) {
		if(properties_bg_instance != noone) {
			properties_bg_instance.depth = _depth + global.LAYERS_BACKGROUND_DEPTH_DIFF;
		}
	}
	
	properties_bg_set_sprite = function(_properties_bg_sprite) {
		properties_bg_sprite = _properties_bg_sprite;
		properties_bg_print();
	}
}


// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function properties_load_layer() 
{
	properties_layer_base_depth = 0;
	
	layer_set_depth = function(_depth) {
		__layer_set_depth(_depth);
	}
	
	layer_set_default_depth = function(_depth) {
		properties_layer_base_depth = _depth;
		__layer_set_depth(properties_layer_base_depth);
	}
	
	__layer_set_depth = function(_depth) {
		self.depth = _depth;
	}
}
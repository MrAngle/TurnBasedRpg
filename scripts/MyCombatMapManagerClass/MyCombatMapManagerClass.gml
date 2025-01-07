// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

function MyCombatMapManager(_combat_map_holder) {
    var combat_map_manager_instance = {
        __combat_map_holder: _combat_map_holder, // number

		// constructor
		init: function() {
			//__my_map_holder_init(self);
        },

		move_to: function(_target_row_index, _target_col_index, _target_obj) {
			__my_move_to(self, _target_row_index, _target_col_index, _target_obj)
		},

    };
	
	combat_map_manager_instance.init();
	return combat_map_manager_instance;
}

function __my_move_to(_obj,_target_row_index, _target_col_index, _target_obj) {
	var currentPositionMyMapTile = __combat_map_holder.get_tile(_target_obj._row_index, _target_obj._col_index);
	var destinationMyMapTile = __combat_map_holder.get_tile(_target_row_index, _target_col_index);
	
	currentPositionMyMapTile.set_tile(noone, TileObjectTypeEnum.CHARACTER);
	destinationMyMapTile.set_tile(_target_obj, TileObjectTypeEnum.CHARACTER);
	
}
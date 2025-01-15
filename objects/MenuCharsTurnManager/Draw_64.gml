if (	
		my_menu_visible == true &&
		!is_undefined(global.COMBAT_GLOBALS.STORE.ACTIVE_CHARACTERS_HOLDER) && 
		global.COMBAT_GLOBALS.STORE.ACTIVE_CHARACTERS_HOLDER != noone && 
		typeof(global.COMBAT_GLOBALS.STORE.ACTIVE_CHARACTERS_HOLDER) == global.TYPEOF_STRUCT
		) {
	if(my_menu_expanded) {
		draw_set_color(c_black);
		draw_rectangle(panel_x, panel_y, panel_x + panel_width, panel_y + panel_height, false);

		// Oblicz odstępy między ikonami

		
		draw_characters(global.COMBAT_GLOBALS.STORE.ACTIVE_CHARACTERS_HOLDER.get_characters(CombatCharacterIndex.PLAYER));
	} else {
		show_wrapped_tooltip_text();
	}
}


function draw_characters(_character_list) {
	var icon_size = 64; // Rozmiar ikony postaci
	var padding = 10; // Odstęp między ikonami
	var icon_x = panel_x + padding;
	
	for (var i = 0; i < array_length(_character_list); i++) {
	    var char = _character_list[i];

	    // Rysuj tło dla ikony (kolor zależny od statusu)
	    //if (char.my_turn_finished) {
	    //    draw_set_color(c_gray); // Postać wykonała ruch
	    //} else {
	    //    draw_set_color(c_green); // Postać dostępna
	    //}
	    //draw_rectangle(icon_x, panel_y + padding, icon_x + icon_size, panel_y + padding + icon_size, false);

	    // Rysuj sprite postaci
	    draw_sprite(char.sprite_index, 0, icon_x + icon_size / 2, panel_y + padding + icon_size / 2);

	    // Przesuń pozycję na kolejną ikonę
	    icon_x += icon_size + padding;
	}
}
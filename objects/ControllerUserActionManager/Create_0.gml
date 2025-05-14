character = 
	global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles([mapTile_filter_element_contains_player_character()])[0].__turnEntity;

repeat_timer = 0;
repeat_delay = 30;     // po ilu klatkach od przytrzymania zacznie spamować (np. 1 sekunda = 60 klatek)
repeat_interval = 5;  // jak często powtarzać (co ile klatek)

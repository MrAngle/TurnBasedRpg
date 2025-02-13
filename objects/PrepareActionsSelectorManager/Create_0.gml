global.COMBAT_GLOBALS.MANAGERS.ACTION_SELECTOR = self;
action_0 = instance_create_layer(0, 0, global.LAYERS.gui_card_selector.id, CardElement);

properties_character_to_prepare_actions = noone; // abst_combat_character

alarm[0] = 1;


action_0.__actionClass = Action_Predefined_Move_In_Radius(global.COMBAT_GLOBALS.ACTION_PREPARATION.CURRENT_CHARACTER_TO_PREPARE, 5);
//action_0.__actionSelectorManager = self;

__actions_to_select = [action_0];
__actions_selected = [];

__on_click_action_element = function(_cardElement /* CardElement */) {
	array_push(__actions_selected, _cardElement.__actionClass)
}


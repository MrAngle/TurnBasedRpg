selectorActionManager.cancel_current_move(self);

global.TILE_SELECTOR_EVENT_ON_CLICK = function(_self) {
	selectorActionManager.execute(_self);
}
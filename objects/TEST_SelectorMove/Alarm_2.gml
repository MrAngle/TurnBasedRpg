testActionsManager.process();

if(!testActionsManager.__is_finished) {
	alarm[2] = testActionsManager.getNextActionTimeInFrames();
}

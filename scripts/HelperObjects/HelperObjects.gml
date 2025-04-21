/// 

function helper_obj_is_turn_entity(functionToCloseInFunction) 
{
	if (object_is_ancestor(functionToCloseInFunction.object_index, AbstTurnEntity)) {
       return true
    }
    return false;
}
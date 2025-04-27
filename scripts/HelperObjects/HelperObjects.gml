/// 

function helper_obj_is_turn_entity(_turnEntity) 
{
    if(helper_is_not_definied(_turnEntity) || helper_object_not_exists(_turnEntity)) {
        return false;
    }

	if (object_is_ancestor(_turnEntity.object_index, AbstTurnEntity)) {
       return true
    }
    return false;
}
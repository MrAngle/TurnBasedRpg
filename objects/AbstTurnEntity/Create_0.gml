/// 
event_inherited();

properties_load_turn_entity(__SELF);

properties_layer_base_depth = global.LAYERS.turn_entities.depth;
__TURN_ENTITY_ATTRIBUTES.setFaction(FACTION_ENUM.NEUTRAL)
properties_map_element_obj_type = MapElementObjectTypeEnum.TURN_ENTITY;// Typ domyślny dla kafelków
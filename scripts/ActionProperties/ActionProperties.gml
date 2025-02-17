// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377


function SelectorPropertiesBuilder() constructor {
    base = 1;
    scaling = 1;
    statistics_impact_modifiers = [];

    return {
        set_base: function(val) {
            base = val;
            return self;
        },
        set_scaling: function(val) {
            scaling = val;
            return self;
        },
		set_statistics_modifiers: function(modifier) {
            statistics_impact_modifiers = modifier;
            return self;
        },
        add_statistics_modifiers: function(modifier) {
            array_push(statistics_impact_modifiers, modifier);
            return self;
        },
        build: function() {
            return {
                BASE: base,
                SCALING: scaling,
                STATISTICS_IMPACT_MODIFIERS: impact_modifiers
            };
        }
    };
}


function ActionPropertiesClass() 
{
	var custom_selector = SelectorPropertiesBuilder()
	    .set_base(2)
	    .set_scaling(1.5)
	    .set_modifiers([global.STATISTICS.MOVEMENT])
	    .build();
	
	var SELECTOR_PROPERTIES = [{
	    BASE: 1,
	    SCALING: 1,
		IMPACT_MODIFIERS: [global.STATISTICS.MOVEMENT]
	}]
	
	var ACTION_PROPERTIES = {
	    MOVEMENT: {
	        BASE: 1,
	        SPEED_SCALING: 1,
	    },
	    PHYSICAL_ATTACK: {
	        BASE_DAMAGE: 1,
	        STRENGTH_SCALING: 1
	    },
	    MAGIC_ATTACK: {
	        BASE_DAMAGE: 1,
	        INT_SCALING: 1
	    }
	};
	
	var _actionGroupPropertiesClass = {
		__action_points: 0,
		__initiative_points: 0,
		__phases: 0
	}
}
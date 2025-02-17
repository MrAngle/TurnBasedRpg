// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
enum MODIFIER_PHASE {
	BASE,
	CALCULATION,
	SUMMARIZE
}

enum MODIFIER_CALCULATION_TYPE {
	ADD,
	MULTIPLICADOR
}

function ModifierClass(arg_ModifierName, arg_modifer_phase, arg_modifer_calculation_type, arg_modifier_value_numeric) 
{
	var map_ModifierClass = {
        __modifierName: arg_ModifierName,
        __modifer_phase: arg_modifer_phase,
        __modifer_calculation_type: arg_modifer_calculation_type,
        __value_modifier_numeric: arg_modifier_value_numeric,
        
		// constructor
		__init_ModifierClass: function() {
        },
		
		// Funkcja usuwania
        getModifierNumeric: function() {
            return __value_modifier_numeric;
        }

    };
	
	map_ModifierClass.__init_ModifierClass();
	return map_ModifierClass;
}
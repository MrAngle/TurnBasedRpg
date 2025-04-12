// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
enum EVENT_ACTION_TYPE {
	ATTACK,
	STEP,
	STAND
}

function Action_TEMPLETE() 
{
	var SKILL_TYPE_VAR = EVENT_ACTION_TYPE.ATTACK;
	var ACTION_PROPERTIES = 
	{
		SKILL_TYPE: SKILL_TYPE_VAR,
		INVOKER_CHAR: noone, // character
		ACTION_COST: function(SKILL_TYPE_VAR) {}
	}
}
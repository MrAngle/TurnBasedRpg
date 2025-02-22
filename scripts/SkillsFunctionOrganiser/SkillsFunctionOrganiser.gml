// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function VALUE_FUNC(arg_value_to_return) 
{
	closedFunction = {
		value_to_return: arg_value_to_return,
		toReturn: function() {
			return value_to_return;
		}
	}
	return closedFunction.toReturn;
}
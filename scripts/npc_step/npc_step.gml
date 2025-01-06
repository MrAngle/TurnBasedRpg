// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function npc_step(_self) 
{
	with(_self) {
		moveStrategy(_self);
		attackStrategy(_self);
		perFrameFunction(_self);
	}
}
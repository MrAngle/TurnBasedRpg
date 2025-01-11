// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

//enum SELECTOR_DECORATION_TYPE_ENUM {
//	HOVER = 1, // ITS use also for layers
//	SELECTED = 2,
//	ACTIVE = 3,
//}

function HexFieldSelectorDecorationFactory(_myMapTile, _selectorTypeEnum) 
{
	if(_myMapTile == undefined || _myMapTile == noone || _selectorTypeEnum == noone) {
		return;
	}
	var hexFieldSelectorDecoration = instance_create_layer(0, 0, global.LAYERS.selectors.id, HexFieldSelectorDecoration);
	with (hexFieldSelectorDecoration)
	{
		hexFieldSelectorDecoration.myMapTileToDecorate = _myMapTile;
		hexFieldSelectorDecoration.selectorTypeEnum = _selectorTypeEnum;
		hexFieldSelectorDecoration.HexFieldSelectorDecoration_run_after_constructor();
	}
	
	return hexFieldSelectorDecoration;
}
// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

//enum SELECTOR_DECORATION_TYPE_ENUM {
//	HOVER = 1, // ITS use also for layers
//	SELECTED = 2,
//	ACTIVE = 3,
//}

function HexFieldSelectorDecorationFactory(_myMapTile, _selectorTypeEnum) 
{
	if(_myMapTile == undefined || _myMapTile == noone || _selectorDecorationTypeEnum == noone) {
		return;
	}
	var hexFieldSelectorDecoration = instance_create_layer(0, 0, global.LAYERS.selectors.id, HexFieldSelectorDecoration);
	with (hexFieldSelectorDecoration)
	{
		hexFieldSelectorDecoration.myMapTileToDecorate = _myMapTile;
		hexFieldSelectorDecoration.selectorDecorationTypeEnum = _selectorDecorationTypeEnum;
		hexFieldSelectorDecoration.layer_set_default_depth(global.LAYERS.selectors.depth + _selectorDecorationTypeEnum);
	}
	
	return hexFieldSelectorDecoration;
}
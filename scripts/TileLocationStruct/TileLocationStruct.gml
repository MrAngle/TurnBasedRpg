/// 
/// @param {Struct.MyMapTile|Id.Instance.abst_tile} _relatedElement
function TileLocationStruct(_relatedElement, _row_index = 0, _col_index = 0, _x_position = 0, _y_position = 0) constructor {
    __relatedElement = undefined;
    __row_index = _row_index;
    __col_index = _col_index;
    __x_position = _x_position;
    __y_position = _y_position;

    if(is_struct(_relatedElement)) {
        __relatedElement = weak_ref_create(_relatedElement);
    } else {
        __relatedElement = _relatedElement;
    }

    getRow = function() {
        return __row_index;
    };

    getCol = function() {
        return __col_index;
    };

    getXPosition = function() {
        return __x_position;
    };

    getYPosition = function() {
        return __y_position;
    };

    /// @param {Struct.MyMapTile|Id.Instance.abst_tile} _myMapTile
    function setRowCol(_myMapTile) {
        if(helper_is_not_definied(_myMapTile)) {
            return;
        }

        self.__x_position = _myMapTile.getXPosition();
        self.__y_position = _myMapTile.getYPosition();

        self.__row_index = _myMapTile.getRow();
        self.__col_index = _myMapTile.getCol();

        
        if(!is_struct(__relatedElement)) {
            if(helper_object_exists(__relatedElement)) {
                __setPositionForRelatedObject(_myMapTile);
            }
        }
    }

    // /// @param {Struct.MyMapTile} _myMapTile
    // __setPositionForObject = function(_myMapTile) {
    //     self.__relatedElement.x = _myMapTile.getXPosition();
    //     self.__relatedElement.y = _myMapTile.getYPosition();
    // }
	
    __setPositionForRelatedObject = function() {
        if(!is_struct(__relatedElement)) {
            if(helper_object_exists(__relatedElement)) {
                self.__relatedElement.map_element_set_x_y(getXPosition(), getYPosition())
            }
        } else {
            self.__relatedElement.x = getXPosition();
            self.__relatedElement.y = getYPosition();
        }
    
    }

	// setPositionX = function(_x) {
    //     if(!is_struct(__relatedElement)) {
    //     }
    //     self.__relatedElement.map_element_set_x(_x)
	// 	__setPositionForRelatedObject();
	// }

	// setPositionY = function(_y) {
	// 	self.y = _y;
    //     __setPositionForRelatedObject();
	// }

	// setPositionXY = function(_x, _y) {
	// 	setPositionX(_x);
	// 	setPositionY(_y);
    //     __setPositionForRelatedObject();
	// }
}

/// @param {Struct.MyMapTile|Id.Instance.abst_tile} _elementReference
/// @returns {Struct.TileLocationStruct}
function getTileLocationFromObjOrStruct(_elementReference) {
	/// @type {} // any object - add validation in feature
	var ref = _elementReference

    if(is_struct(_elementReference)) {
        _elementReference.getTileLocationStruct();
    }
	if (helper_obj_is_abst_tile(ref)) {
        return ref.getTileLocationStruct();
    } else if (is_instanceof(ref, TurnEntityStruct)) {
		LOG_CRITICAL_MESSAGE("Use getTurnEntityStruct for struct instead of Instance")
		return ref;
	}
        
    return ref.getTileLocationStruct();
    //}
    //LOG_CRITICAL_MESSAGE("Use getTurnEntityStruct for struct instead of Instance")
	//return undefined;
}

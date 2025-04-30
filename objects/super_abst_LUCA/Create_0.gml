__SELF = privGetSelfFunc(self);
__PARAMS = {};

/// @returns {Struct.__ActionStruct}
getParams = function() {
	return self;
}

function privGetSelfFunc(_self) {
	var closedFunction = {
		param_self: _self,
		toReturn: function() {
			return param_self;
		}
	}
	return closedFunction.toReturn;
}
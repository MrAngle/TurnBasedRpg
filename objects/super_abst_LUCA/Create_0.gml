__SELF = privGetSelfFunc(self);

function privGetSelfFunc(_self) {
	var closedFunction = {
		param_self: _self,
		toReturn: function() {
			return param_self;
		}
	}
	return closedFunction.toReturn;
}
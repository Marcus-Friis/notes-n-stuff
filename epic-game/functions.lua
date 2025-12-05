local function linear(x, alpha)
	alpha = alpha or 200
	return alpha * x
end

local functions = {
	sin = math.sin,
	-- cos = math.cos,
	-- tan = math.tan,
	-- sinh = math.sinh,
	-- cosh = math.cosh,
	-- tanh = math.tanh,
	-- linear = linear,
}
return functions

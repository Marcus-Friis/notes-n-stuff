local utils = {}

function utils.getRandomFunction()
	local list = {}
	for _, v in pairs(BallFunctions) do
		list[#list + 1] = v
	end
	return list[math.random(#list)]
end

return utils

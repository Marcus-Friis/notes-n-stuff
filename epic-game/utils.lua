local utils = {}

function utils.getRandomFunction()
	local list = {}
	for _, v in pairs(BallFunctions) do
		list[#list + 1] = v
	end
	return list[math.random(#list)]
end

function utils.previewTrajectory(func)
	local windowWidth, _ = love.graphics.getDimensions()
	for x = 0, windowWidth, 1 do
		local y = func(x)
		love.graphics.circle("line", x, y, 1)
	end
end

function utils.showFPS()
	fps = love.timer.getFPS()
	love.graphics.print(fps, 10, 10)
end

return utils

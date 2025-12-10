local utils = {}

function utils.getRandomFunction()
	local list = {}
	for _, v in pairs(BallFunctions) do
		list[#list + 1] = v
	end
	return list[math.random(#list)]
end

function utils.previewTrajectory(func, mirror)
	local windowWidth, _ = love.graphics.getDimensions()
	windowWidth = math.floor(windowWidth)

	local ys = {}
	for x = 0, windowWidth do
		ys[#ys + 1] = func(x)
	end

	if mirror then
		for x = 0, windowWidth do
			local idx = windowWidth - x + 1 -- 1-based index for mirrored x
			local y = ys[idx]
			if y then
				love.graphics.circle("line", x, y, 1)
			end
		end
		return
	end

	for i = 1, #ys do
		local x = i - 1
		love.graphics.circle("line", x, ys[i], 1)
	end
end

function utils.showFPS()
	fps = love.timer.getFPS()
	love.graphics.print(fps, 10, 10)
end

return utils

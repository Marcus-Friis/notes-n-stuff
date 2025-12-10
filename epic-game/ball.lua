local function newBall(x, y, radius)
	local ball = {}
	ball.x = x or 420
	ball.y = y or 420
	ball.radius = radius or 32
	ball.vx = 400
	ball.vy = 0
	ball.yCoef = 1
	ball.functionX = 0
	ball.ballFunction = nil
	local windowWidth, windowHeight = love.graphics.getDimensions()

	function ball:draw()
		love.graphics.circle("line", ball.x, ball.y, ball.radius)
	end

	function ball:update(dt)
		ball.x = ball.x + (ball.vx * dt)
		ball.functionX = ball.functionX + (math.abs(ball.vx) * dt)
		if ball.ballFunction then
			ball.y = ball.ballFunction(ball.functionX) * ball.yCoef
		end

		-- if ball exits game window, do stuff
		-- bottom boundary
		if ball.y + ball.radius > windowHeight then
			ball.y = windowHeight - ball.radius -- clamp
			ball.yCoef = -ball.yCoef -- invert
		end

		-- top boundary
		if ball.y - ball.radius < 0 then
			ball.y = ball.radius -- clamp
			ball.yCoef = -ball.yCoef -- invert
		end
	end

	function ball:invertXDirection()
		if self.x > windowWidth / 2 then
			self.x = windowWidth
		elseif self.x < windowWidth / 2 then
			self.x = 0
		else
			print("wtf")
		end
		self.vx = self.vx * -1
	end

	function ball:setFunction(func)
		ball.ballFunction = func
		ball.functionX = 0
	end

	return ball
end

return newBall

local function newBall(x, y, radius)
	local ball = {}
	ball.x = x or 420
	ball.y = y or 420
	ball.radius = radius or 32
	ball.vx = 400
	ball.vy = 0
	ball.iterator = 0
	ball.ballFunction = nil

	function ball:draw()
		love.graphics.circle("line", ball.x, ball.y, ball.radius)
	end

	function ball:update(dt)
		ball.x = ball.x + (ball.vx * dt)
		if ball.ballFunction then
			ball.y = ball.y + ball.ballFunction(ball.iterator)
		end
		ball.iterator = ball.iterator + dt
	end

	function ball:setFunction(func)
		ball.ballFunction = func
		ball.iterator = 0
	end

	return ball
end

return newBall

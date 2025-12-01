local function newBall(x, y, radius)
	local ball = {}
	ball.x = x or 420
	ball.y = y or 420
	ball.radius = radius or 32
	ball.vx = 100
	ball.vy = 0

	function ball:draw()
		love.graphics.circle("line", ball.x, ball.y, ball.radius)
	end

	function ball:update(dt)
		ball.x = ball.x + (ball.vx * dt)
		ball.y = ball.y + (ball.vy * dt)
	end

	return ball
end

return newBall

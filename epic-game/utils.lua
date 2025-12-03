local utils = {}

function utils.getRandomFunction()
	local list = {}
	for _, v in pairs(BallFunctions) do
		list[#list + 1] = v
	end
	return list[math.random(#list)]
end

function utils.playerBallCollision(player, ball)
	-- Find the closest point on the paddle to the ball
	local closestX = math.max(player.x, math.min(ball.x, player.x + player.width))
	local closestY = math.max(player.y, math.min(ball.y, player.y + player.height))

	-- Distance from closest point to ball center
	local dx = ball.x - closestX
	local dy = ball.y - closestY

	-- If distance² < radius² → collision
	if (dx * dx + dy * dy) < (ball.radius * ball.radius) then
		-- Push ball out so it doesn't stick
		if ball.vx > 0 then
			-- Ball moving right → hit Player2
			ball.x = player.x - ball.radius
		else
			-- Ball moving left → hit Player1
			ball.x = player.x + player.width + ball.radius
		end

		-- Reverse X direction
		ball.vx = -ball.vx

		-- assign a function the y movement
		local func = utils.getRandomFunction()
		ball:setFunction(func)
		return true
	end
	return false
end

return utils

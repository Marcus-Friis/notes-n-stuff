local function newPlayer(x, y, width, height)
	local player = {}
	player.x = x or 200
	player.y = y or 200
	player.width = width or 100
	player.height = height or 100
	player.vy = 0

	function player:update(dt)
		local speed = 1000
		if love.keyboard.isDown("s") then
			self.y = self.y + speed * dt
		elseif love.keyboard.isDown("w") then
			self.y = self.y - speed * dt
		end
	end

	function player:draw()
		love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
	end

	function player:ballCollision(ball)
		-- Find the closest point on the paddle to the ball
		local closestX = math.max(self.x, math.min(ball.x, self.x + self.width))
		local closestY = math.max(self.y, math.min(ball.y, self.y + self.height))

		-- Distance from closest point to ball center
		local dx = ball.x - closestX
		local dy = ball.y - closestY

		-- If distance² < radius² → collision
		if (dx * dx + dy * dy) < (ball.radius * ball.radius) then
			-- Push ball out so it doesn't stick
			if ball.vx > 0 then
				-- Ball moving right → hit Player2
				ball.x = self.x - ball.radius
			else
				-- Ball moving left → hit Player1
				ball.x = self.x + self.width + ball.radius
			end

			-- Reverse X direction
			ball:invertXDirection()

			-- assign a function the y movement
			-- local func = utils.getRandomFunction()
			-- ball:setFunction(func)
			return true
		end
		return false
	end

	return player
end

return newPlayer

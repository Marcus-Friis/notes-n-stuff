local function newPlayer(x, y, width, height)
	local player = {}
	player.x = x or 200
	player.y = y or 200
	player.width = width or 100
	player.height = height or 100
	player.vy = 0

	function player:update(dt)
		speed = 1000
		if love.keyboard.isDown("s") then
			self.y = self.y + speed * dt
		elseif love.keyboard.isDown("w") then
			self.y = self.y - speed * dt
		end
	end

	function player:draw()
		love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
	end

	return player
end

return newPlayer

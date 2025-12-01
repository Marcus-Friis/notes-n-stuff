local function playerBallCollision(player, ball)
	local closestX = math.max(player.x, math.min(ball.x, player.x + player.width))
	local closestY = math.max(player.y, math.min(ball.y, player.y + player.height))

	local dx = ball.x - closestX
	local dy = ball.y - closestY

	if (dx * dx + dy * dy) < (ball.radius * ball.radius) then
		ball.vx = -ball.vx

		-- Prevent sticking
		if ball.vx > 0 then
			ball.x = player.x + player.width + ball.radius
		else
			ball.x = player.x - ball.radius
		end
	end
end

function love.load()
	newPlayer = require("player")
	newBall = require("ball")
	Player1 = newPlayer(20, 20, 20, 200)
	Player2 = newPlayer(780, 20, 20, 200)
	Players = { Player1, Player2 }
	Ball = newBall()
end

function love.update(dt)
	playerBallCollision(Player1, Ball)
	for _, p in ipairs(Players) do
		p:update(dt)
	end
	Ball:update(dt)
end

function love.draw()
	Player1:draw()
	Player2:draw()
	Ball:draw()
end

-- pong men det er matematik funktioner
local function getRandomFunction()
	local list = {}
	for _, v in pairs(BallFunctions) do
		list[#list + 1] = v
	end
	return list[math.random(#list)]
end

local function playerBallCollision(player, ball)
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
		local func = getRandomFunction()
		ball:setFunction(func)
	end
end

function love.load()
	-- window data
	local windowWidth, windowHeight = love.graphics.getDimensions()

	-- class constructors
	local newPlayer = require("player")
	local newBall = require("ball")

	-- load ball functions
	BallFunctions = require("functions")

	-- player data
	local playerPadding = 16
	local playerWidth = 20
	local playerHeight = 100
	local playerYSpawn = (windowHeight / 2) - (playerHeight / 2)

	-- init players
	Player1 = newPlayer(playerPadding, playerYSpawn, playerWidth, playerHeight)
	Player2 = newPlayer(windowWidth - playerPadding - playerWidth, playerYSpawn, playerWidth, playerHeight)
	Players = { Player1, Player2 }

	-- init ball
	local ballRadius = 10
	local ballXSpawn = (windowWidth / 2) - (ballRadius / 2)
	local ballYSpawn = (windowHeight / 2) - (ballRadius / 2)
	Ball = newBall(ballXSpawn, ballYSpawn, ballRadius)
end

function love.update(dt)
	for _, p in ipairs(Players) do
		p:update(dt)
		playerBallCollision(p, Ball)
	end
	Ball:update(dt)
end

function love.draw()
	Player1:draw()
	Player2:draw()
	Ball:draw()
end

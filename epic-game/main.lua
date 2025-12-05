-- pong men det er matematik funktioner

function love.load()
	mathOverlay = require("mathoverlay")
	utils = require("utils")
	BallFunctions = require("functions")

	-- window data
	local windowWidth, windowHeight = love.graphics.getDimensions()

	-- class constructors
	local newPlayer = require("player")
	local newBall = require("ball")

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
	local collisionFlag = false
	local hasCollision = false

	if not mathOverlay.isActive then
		for _, p in ipairs(Players) do
			p:update(dt)
			hasCollision = p:ballCollision(Ball)
			collisionFlag = collisionFlag or hasCollision
		end
		Ball:update(dt)
		if hasCollision then
			print("Hit!")
			mathOverlay:toggle()
		end
	else
		if mathOverlay.submit then
			local mathFunc = mathOverlay:interpretFunction(mathOverlay.input)
			Ball:setFunction(mathFunc)
			mathOverlay.submit = false
		end
	end
end

function love.draw()
	Player1:draw()
	Player2:draw()
	Ball:draw()
	mathOverlay:displayOverlay()
end

function love.textinput(t)
	mathOverlay:textinput(t)
end

function love.keypressed(key, scancode, isrepeat)
	mathOverlay:keypressed(key)
end

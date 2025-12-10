-- pong men det er matematik funktioner

function love.load()
	mathOverlay = require("mathoverlay")
	mathOverlay:load()
	utils = require("utils")
	BallFunctions = require("functions")

	-- game state vars
	GameState = "playing" -- playing|mathing|paused
	ShootingPlayer = nil -- track which player is actively shooting

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
	Player1 = newPlayer(playerPadding, playerYSpawn, playerWidth, playerHeight, "player1")
	Player2 = newPlayer(windowWidth - playerPadding - playerWidth, playerYSpawn, playerWidth, playerHeight, "player2")
	Players = { Player1, Player2 }

	-- init ball
	local ballRadius = 10
	local ballXSpawn = (windowWidth / 2) - (ballRadius / 2)
	local ballYSpawn = (windowHeight / 2) - (ballRadius / 2)
	Ball = newBall(ballXSpawn, ballYSpawn, ballRadius)

	-- grid
	local newGrid = require("grid")
	local gridPixelSpan = 32
	local gridPadding = 48
	Grid = newGrid(gridPixelSpan, gridPadding)

	-- shaders
	Shaders = require("shaders")
end

function love.update(dt)
	local hasCollision = false
	if GameState == "playing" then
		Ball:update(dt)
		for _, p in ipairs(Players) do
			if p ~= ShootingPlayer then
				p:update(dt)
				hasCollision = p:ballCollision(Ball)
				if hasCollision then
					ShootingPlayer = p
					print("Hit!")
					mathOverlay:toggle()
					GameState = "mathing"
				end
			end
		end
	elseif GameState == "mathing" then
		mathOverlay:update(dt)
		if mathOverlay.submit then
			local mathFunc = Grid:scaleFunction(mathOverlay:interpretFunction())
			ShootingPlayer:shoot(Ball, mathFunc)
			mathOverlay.submit = false
			GameState = "playing"
		end
	end
end

function love.draw()
	Grid:displayGrid()
	Player1:draw()
	Player2:draw()
	if Ball.ballFunction then
		local mirror = ShootingPlayer.name ~= "player1"
		utils.previewTrajectory(Ball.ballFunction, mirror)
	end
	Ball:draw()
	mathOverlay:displayOverlay()

	utils.showFPS()
end

function love.textinput(t)
	if mathOverlay.isActive then
		mathOverlay:textinput(t)
	end
end

function love.keypressed(key, scancode, isrepeat)
	if mathOverlay.isActive then
		mathOverlay:keypressed(key)
	end
end

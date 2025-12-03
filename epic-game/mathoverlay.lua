local mathOverlay = {}

local utf8 = require("utf8")

-- state
mathOverlay.isActive = false
mathOverlay.input = ""

function mathOverlay:displayOverlay()
	-- only display overlay when toggled
	if not self.isActive then
		return
	end

	local windowWidth, windowHeight = love.graphics.getDimensions()
	local overlayWidth = windowWidth * 0.66
	local overlayHeight = windowHeight * 0.33
	local overlayX = (windowWidth / 2) - (overlayWidth / 2)
	local overlayY = (windowHeight / 2) - (overlayHeight / 2)

	love.graphics.setColor(0.3, 0.3, 0.3, 0.8)
	love.graphics.rectangle("fill", overlayX, overlayY, overlayWidth, overlayHeight)

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print(mathOverlay.input, overlayX + 10, overlayY + 10)

	-- Reset color so it doesn’t affect other draws
	love.graphics.setColor(1, 1, 1, 1)
end

-- handle text input (call from love.textinput)
function mathOverlay:textinput(t)
	if not self.isActive then
		return
	end
	-- append typed character
	self.input = self.input .. t
end

-- handle keypresses (call from love.keypressed)
function mathOverlay:keypressed(key)
	if key == "backspace" then
		-- delete last UTF-8 character (simple byte-based is usually fine for ASCII math)
		local byteoffset = utf8.offset(self.input, -1)
		if byteoffset then
			self.input = string.sub(self.input, 1, byteoffset - 1)
		else
			self.input = ""
		end
	elseif key == "return" or key == "kpenter" then
		-- Accept / evaluate final expression — we already show live result; you could clear input or keep it
		-- For this example, we'll keep input but maybe flash cursor
		-- Optionally, you can move input to history later.
	elseif key == "escape" then
		-- optional: clear input
		self.input = ""
	elseif key == "v" and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) then
		-- paste from clipboard (if Love2D supports it)
		local ok, clip = pcall(love.system.getClipboardText)
		if ok and clip then
			self.input = self.input .. tostring(clip)
		end
	end
end

function mathOverlay:toggle()
	self.isActive = not self.isActive
end

return mathOverlay

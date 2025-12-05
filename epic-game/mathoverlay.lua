local mathOverlay = {}

local utf8 = require("utf8")

-- state
mathOverlay.isActive = false
mathOverlay.input = ""
mathOverlay.submit = false

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
		self.submit = true
		self:toggle()
		print(self.input)
		return true
	elseif key == "escape" then
		self.input = ""
	elseif key == "v" and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) then
		-- paste from clipboard
		local ok, clip = pcall(love.system.getClipboardText)
		if ok and clip then
			self.input = self.input .. tostring(clip)
		end
	end
	return false
end

function mathOverlay:interpretFunction(inputStr)
	if not inputStr or inputStr == "" then
		return function()
			return 0
		end
	end

	local expr = inputStr

	-- Fix implicit multiplication:
	expr = expr:gsub("(%d)(%a)", "%1*%2") -- 3x → 3*x
	expr = expr:gsub("(%a)(%d)", "%1*%2") -- x3 → x*3   (but don't touch hex etc.)
	expr = expr:gsub("%)(%a)", ")*%1") -- )x → )*x
	expr = expr:gsub("(%a)%(", "%1*(") -- x( → x*(
	expr = expr:gsub("%)(%d)", ")*%1") -- )3 → )* 3

	local functions = { "sin", "cos", "tan", "asin", "acos", "atan", "log", "log10", "sqrt", "abs", "exp" } -- Replace math functions with math.* form

	for _, fn in ipairs(functions) do
		expr = expr:gsub(fn .. "%(", "math." .. fn .. "(")
	end

	-- Replace ^ with Lua’s exponent operator **
	expr = expr:gsub("%^", "**")

	-- Now wrap this into a Lua function string
	local chunk = "return function(x) return " .. expr .. " end"

	local f, err = load(chunk)
	if not f then
		print("Error loading function:", err)
		return function()
			return 0
		end
	end

	-- Run the chunk → returns the actual function
	local ok, mathFunc = pcall(f)
	if not ok then
		print("Error executing function:", mathFunc)
		return function()
			return 0
		end
	end

	return mathFunc
end

function mathOverlay:toggle()
	self.isActive = not self.isActive
end

return mathOverlay

local utf8 = require("utf8")

-- state
local mathOverlay = {
	isActive = false,
	input = "",
	padding = 14,
	widthFactor = 0.66,
	heightFactor = 0.33,
	-- caret/blink
	caretVisible = true,
	caretTimer = 0,
	caretInterval = 0.5,
	-- fonts (created in load)
	font = nil,
	titleFont = nil,
	-- styling
	cornerRadius = 12,
	shadowOffset = 8,
	shadowAlpha = 0.35,
	borderAlpha = 0.15,
	bgAlpha = 0.92,
}
-- mathOverlay.isActive = false
-- mathOverlay.input = ""
-- mathOverlay.submit = false

function mathOverlay:load()
	-- Create fonts once
	self.font = love.graphics.newFont(14) -- body / input
	self.titleFont = love.graphics.newFont(18) -- title
	self.labelFont = love.graphics.newFont(12) -- small subtitle
end

function mathOverlay:update(dt)
	if not self.isActive then
		return
	end
	-- caret blink
	self.caretTimer = self.caretTimer + dt
	if self.caretTimer >= self.caretInterval then
		self.caretTimer = self.caretTimer - self.caretInterval
		self.caretVisible = not self.caretVisible
	end
end

-- Utility: draw rounded rectangle with border
local function drawRoundedRect(x, y, w, h, r, fillColor, borderColor, borderWidth)
	-- fill
	love.graphics.setColor(fillColor)
	love.graphics.rectangle("fill", x, y, w, h, r, r)
	-- border
	if borderColor and (borderWidth or 1) > 0 then
		love.graphics.setLineWidth(borderWidth or 1)
		love.graphics.setColor(borderColor)
		love.graphics.rectangle(
			"line",
			x + (borderWidth / 2),
			y + (borderWidth / 2),
			w - borderWidth,
			h - borderWidth,
			r,
			r
		)
	end
end

function mathOverlay:displayOverlay()
	if not self.isActive then
		return
	end

	local windowWidth, windowHeight = love.graphics.getDimensions()
	local overlayWidth = windowWidth * self.widthFactor
	local overlayHeight = windowHeight * self.heightFactor
	local overlayX = (windowWidth / 2) - (overlayWidth / 2)
	local overlayY = (windowHeight / 2) - (overlayHeight / 2)

	-- SHADOW (soft-ish)
	love.graphics.setColor(0, 0, 0, self.shadowAlpha)
	love.graphics.rectangle(
		"fill",
		overlayX + self.shadowOffset,
		overlayY + self.shadowOffset,
		overlayWidth,
		overlayHeight,
		self.cornerRadius,
		self.cornerRadius
	)

	-- BACKGROUND: slightly gradient-ish by stacking two rectangles
	local bgTopColor = { 0.14, 0.16, 0.18, self.bgAlpha } -- top darker
	local bgBottomColor = { 0.12, 0.14, 0.16, self.bgAlpha * 0.98 } -- very subtle difference

	drawRoundedRect(
		overlayX,
		overlayY,
		overlayWidth,
		overlayHeight,
		self.cornerRadius,
		bgTopColor,
		{ 1, 1, 1, self.borderAlpha },
		1
	)

	-- small bottom overlay to fake a vertical gradient
	love.graphics.setScissor(overlayX, overlayY + overlayHeight * 0.5, overlayWidth, overlayHeight * 0.5)
	love.graphics.setColor(bgBottomColor)
	love.graphics.rectangle(
		"fill",
		overlayX,
		overlayY + overlayHeight * 0.5,
		overlayWidth,
		overlayHeight * 0.5,
		self.cornerRadius,
		self.cornerRadius
	)
	love.graphics.setScissor() -- reset

	-- padding and layout
	local x = overlayX + self.padding
	local y = overlayY + self.padding

	-- Title
	love.graphics.setFont(self.titleFont)
	love.graphics.setColor(1, 1, 1, 0.95)
	love.graphics.print("Function Overlay", x, y)

	-- subtitle / hint
	love.graphics.setFont(self.labelFont)
	love.graphics.setColor(1, 1, 1, 0.75)
	love.graphics.print("Type an expression in x (press Enter to evaluate)", x, y + 26)

	-- Draw input box
	local inputBoxY = y + 46
	local inputBoxH = 36
	local inputBoxW = overlayWidth - (self.padding * 2)

	-- input box background (slightly translucent)
	drawRoundedRect(
		x,
		inputBoxY,
		inputBoxW,
		inputBoxH,
		self.cornerRadius * 0.5,
		{ 0.02, 0.02, 0.02, 0.18 },
		{ 1, 1, 1, 0.06 },
		1
	)

	-- render expression text
	love.graphics.setFont(self.font)
	love.graphics.setColor(1, 1, 1, 0.98)

	-- Break long input into clipped area
	love.graphics.push()
	love.graphics.setScissor(x + 6, inputBoxY + 6, inputBoxW - 12, inputBoxH - 12)

	local textX = x + 8
	local textY = inputBoxY + (inputBoxH - self.font:getHeight()) / 2
	love.graphics.print(self.input, textX, textY)

	-- caret (draw at end of text)
	if self.caretVisible then
		local textWidth = self.font:getWidth(self.input)
		local caretX = textX + textWidth + 2
		local caretTop = textY
		local caretBottom = textY + self.font:getHeight()
		love.graphics.setLineWidth(2)
		love.graphics.setColor(1, 1, 1, 0.95)
		love.graphics.line(caretX, caretTop, caretX, caretBottom)
	end

	love.graphics.pop()
	love.graphics.setScissor() -- ensure scissor cleared

	-- Render result preview underneath input (f(x) = ...)
	local previewY = inputBoxY + inputBoxH + 12
	love.graphics.setFont(self.font)
	love.graphics.setColor(1, 1, 1, 0.9)
	local outputStr = "f(x) = " .. (self.input ~= "" and self.input or "—")
	love.graphics.print(outputStr, x, previewY)

	-- Optional little accent line / divider
	love.graphics.setColor(1, 1, 1, 0.06)
	love.graphics.setLineWidth(1)
	love.graphics.line(
		x,
		overlayY + overlayHeight - self.padding - 26,
		overlayX + overlayWidth - self.padding,
		overlayY + overlayHeight - self.padding - 26
	)

	-- Small footer: keys hint
	love.graphics.setFont(self.labelFont)
	love.graphics.setColor(1, 1, 1, 0.55)
	love.graphics.print("Esc: close   Enter: evaluate", x, overlayY + overlayHeight - self.padding - 20)

	-- Reset color
	love.graphics.setColor(1, 1, 1, 1)
end

-- function mathOverlay:displayOverlay()
-- 	-- only display overlay when toggled
-- 	if not self.isActive then
-- 		return
-- 	end
--
-- 	local windowWidth, windowHeight = love.graphics.getDimensions()
-- 	local overlayWidth = windowWidth * 0.66
-- 	local overlayHeight = windowHeight * 0.33
-- 	local overlayX = (windowWidth / 2) - (overlayWidth / 2)
-- 	local overlayY = (windowHeight / 2) - (overlayHeight / 2)
--
-- 	love.graphics.setColor(0.3, 0.3, 0.3, 0.8)
-- 	love.graphics.rectangle("fill", overlayX, overlayY, overlayWidth, overlayHeight)
--
-- 	love.graphics.setColor(1, 1, 1, 1)
-- 	outputStr = "f(x) = " .. mathOverlay.input
-- 	love.graphics.print(outputStr, overlayX + 10, overlayY + 10)
--
-- 	-- Reset color so it doesn’t affect other draws
-- 	love.graphics.setColor(1, 1, 1, 1)
-- end

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

function mathOverlay:validateInputStr(inputStr)
	-- implement me
	return true
end

function mathOverlay:interpretFunction()
	if not self.input or self.input == "" then
		return function()
			return 0
		end
	end

	local expr = self.input

	-- list and set of known math functions
	local functions = { "sin", "cos", "tan", "asin", "acos", "atan", "log", "log10", "sqrt", "abs", "exp" }
	local fnset = {}
	for _, fn in ipairs(functions) do
		fnset[fn] = true
	end

	-- 1) fix numeric/letter implicit multiplication (e.g. 3x -> 3*x)
	expr = expr:gsub("(%d)(%a)", "%1*%2") -- 3x -> 3*x
	expr = expr:gsub("(%a)(%d)", "%1*%2") -- x3 -> x*3
	expr = expr:gsub("%)(%a)", ")*%1") -- )x -> )*x
	expr = expr:gsub("%)(%d)", ")*%1") -- )3 -> )*3

	-- 2) handle identifier followed by '('.
	-- If identifier is a known function, keep it as-is (sin(...)).
	-- Otherwise insert a multiplication: name( -> name*(  (for variables like x(...))
	expr = expr:gsub("([_%a][_%w]*)%s*%(", function(name)
		if fnset[name] then
			return name .. "("
		else
			return name .. "*("
		end
	end)

	-- 3) now convert known math functions to math.<fn>( so we haven't broken them
	for _, fn in ipairs(functions) do
		-- match function name followed immediately by '(' (allow optional spaces)
		expr = expr:gsub(fn .. "%s*%(", "math." .. fn .. "(")
	end

	-- optional: you may want to remove accidental spaces
	expr = expr:gsub("%s+", "")

	-- Build chunk and load it in a restricted environment (math available)
	local chunk = "return function(x) return " .. expr .. " end"

	-- safer load: give it only math in its environment (prevents accidental globals)
	local env = { math = math }
	local f, err = load(chunk, "userfunc", "t", env)
	if not f then
		print("Error loading function:", err)
		return function()
			return 0
		end
	end

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

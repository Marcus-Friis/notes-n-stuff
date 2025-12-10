local function newGrid(gridPixelSpan, gridPadding, fitGridNeatly)
	local grid = {}
	grid.gridPixelSpan = gridPixelSpan or 80
	-- user-specified minimum padding (applies when not fitting neatly, or as a minimum when fitting)
	grid.gridPadding = gridPadding or 0
	-- default behavior: fit neatly when nil/true; set to false to disable
	local _fitGridNeatly = (fitGridNeatly == nil) and true or fitGridNeatly

	-- per-axis paddings (kept on grid so other code can read them)
	grid.gridPaddingX = grid.gridPadding
	grid.gridPaddingY = grid.gridPadding

	-- Converts a grid-based function f(gx) -> gy into a world-based function f(wx) -> wy (pixels).
	function grid:scaleFunction(funcIn)
		return function(wx)
			-- convert world-x → grid-x (use per-axis padding)
			local gx = (wx - self.gridPaddingX) / self.gridPixelSpan

			-- evaluate original grid-function
			local gy = funcIn(gx)

			-- convert grid-y → world-y (use Y padding)
			local wy = self.gridPaddingY + gy * self.gridPixelSpan

			return wy
		end
	end

	function grid:displayGrid()
		local windowWidth, windowHeight = love.graphics.getDimensions()
		love.graphics.setColor(1, 1, 1, 0.55)

		-- If fitting neatly, compute per-axis paddings so inner area is an integer multiple of gridPixelSpan.
		if _fitGridNeatly then
			-- Start from the minimum padding the user requested
			local minPadX = self.gridPadding
			local minPadY = self.gridPadding

			-- Compute available space after the minimum padding on both sides
			local availW = windowWidth - 2 * minPadX
			local availH = windowHeight - 2 * minPadY

			-- How many whole cells can we fit within the available area?
			local cols = math.floor(availW / self.gridPixelSpan)
			local rows = math.floor(availH / self.gridPixelSpan)

			-- If zero cols/rows (very small window), fallback to at least 1 to avoid division by zero layout oddities
			if cols < 1 then
				cols = 1
			end
			if rows < 1 then
				rows = 1
			end

			-- used inner size that exactly fits integer number of cells
			local usedW = cols * self.gridPixelSpan
			local usedH = rows * self.gridPixelSpan

			-- center the used area inside the window, but never use less padding than the user's minPad
			local padX = math.floor((windowWidth - usedW) / 2)
			local padY = math.floor((windowHeight - usedH) / 2)

			-- ensure we honor the minimum padding the user asked for
			if padX < minPadX then
				padX = minPadX
			end
			if padY < minPadY then
				padY = minPadY
			end

			self.gridPaddingX = padX
			self.gridPaddingY = padY
		else
			-- not fitting neatly: use the user-specified uniform padding
			self.gridPaddingX = self.gridPadding
			self.gridPaddingY = self.gridPadding
		end

		-- Compute inner rectangle (where grid lines should lie)
		local left = self.gridPaddingX
		local top = self.gridPaddingY
		local right = windowWidth - self.gridPaddingX
		local bottom = windowHeight - self.gridPaddingY

		local innerWidth = right - left
		local innerHeight = bottom - top

		-- Now compute counts based on that inner size (this fixes the stretching bug)
		local numCols = math.floor(innerWidth / self.gridPixelSpan)
		local numRows = math.floor(innerHeight / self.gridPixelSpan)

		-- If the innerWidth/innerHeight happen to not be an exact multiple (due to enforced min padding),
		-- we draw lines that fit inside the rectangle (so we don't draw outside it).
		-- Draw horizontal lines (rows)
		for i = 0, numRows do
			local y = top + i * self.gridPixelSpan
			love.graphics.line(left, y, right, y)
		end

		-- Draw vertical lines (cols)
		for i = 0, numCols do
			local x = left + i * self.gridPixelSpan
			love.graphics.line(x, top, x, bottom)
		end

		-- reset color
		love.graphics.setColor(1, 1, 1)
	end

	return grid
end

return newGrid

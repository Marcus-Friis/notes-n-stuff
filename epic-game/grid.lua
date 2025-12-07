local function newGrid(gridPixelSpan, gridPadding)
	local grid = {}
	grid.gridPixelSpan = gridPixelSpan or 80
	grid.gridPadding = gridPadding or 0

	-- Converts a grid-based function f(gx) -> gy
	-- into a world-based function f(wx) -> wy (pixels).
	function grid:scaleFunction(funcIn)
		return function(wx)
			-- convert world-x → grid-x
			local gx = (wx - self.gridPadding) / self.gridPixelSpan

			-- evaluate original grid-function
			local gy = funcIn(gx)

			-- convert grid-y → world-y
			local wy = self.gridPadding + gy * self.gridPixelSpan

			return wy
		end
	end

	function grid:displayGrid()
		local windowWidth, windowHeight = love.graphics.getDimensions()

		local left = self.gridPadding
		local top = self.gridPadding
		local right = windowWidth - self.gridPadding
		local bottom = windowHeight - self.gridPadding

		local gridWidth = right - left
		local gridHeight = bottom - top

		local numHorizontalLines = math.floor(gridHeight / self.gridPixelSpan)
		local numVerticalLines = math.floor(gridWidth / self.gridPixelSpan)

		-- Horizontal lines
		for i = 0, numHorizontalLines do
			local y = top + i * self.gridPixelSpan
			love.graphics.line(left, y, right, y)
		end

		-- Vertical lines
		for i = 0, numVerticalLines do
			local x = left + i * self.gridPixelSpan
			love.graphics.line(x, top, x, bottom)
		end
	end

	return grid
end

return newGrid

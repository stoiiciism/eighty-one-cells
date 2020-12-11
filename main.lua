function love.load()
	Cell = require "cell"
	cells = {}
	for y = 1, 9 do
		cells[y] = {}
		for x = 1, 9 do cells[y][x] = Cell.new(x - 1, y - 1) end
	end
end

function love.update(dt) end

function love.draw()
	for y = 1, 9 do
		for x = 1, 9 do
			cells[y][x]:draw()
		end
	end
end

function love.keypressed(key)
	if key == "escape" then love.event.quit() end
end

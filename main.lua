function reset()
	cells = {}
	for y = 1, 9 do
		cells[y] = {}
		for x = 1, 9 do cells[y][x] = Cell.new((x - 1) * 32, (y - 1) * 32) end
	end
	
	local m = 10
	while m > 0 do
		local x = math.floor(math.random() * 9) + 1
		local y = math.floor(math.random() * 9) + 1
		if cells[y][x].value ~= "mine" then
			cells[y][x].value = "mine"
			m = m - 1
		end
	end
	
	for y = 1, 9 do
		for x = 1, 9 do
			if cells[y][x].value ~= "mine" then
				local t = 0
				if y > 1 and cells[y - 1][x].value == "mine" then t = t + 1 end
				if y < 9 and cells[y + 1][x].value == "mine" then t = t + 1 end
				if x > 1 and cells[y][x - 1].value == "mine" then t = t + 1 end
				if x < 9 and cells[y][x + 1].value == "mine" then t = t + 1 end
				if y > 1 and x > 1 and cells[y - 1][x - 1].value == "mine" then t = t + 1 end
				if y < 9 and x > 1 and cells[y + 1][x - 1].value == "mine" then t = t + 1 end
				if y > 1 and x < 9 and cells[y - 1][x + 1].value == "mine" then t = t + 1 end
				if y < 9 and x < 9 and cells[y + 1][x + 1].value == "mine" then t = t + 1 end
				cells[y][x].value = t
			end
		end
	end
end

function love.load()
	math.randomseed(os.time())
	Cell = require "cell"
	reset()
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

function love.keyreleased(key)
	if key == "r" then reset() end
end

function love.mousepressed(x, y, button)
	for y = 1, 9 do
		for x = 1, 9 do
			cells[y][x]:mousepressed(x, y, button)
		end
	end
end

function love.mousereleased(x, y, button)
	for y = 1, 9 do
		for x = 1, 9 do
			cells[y][x]:mousereleased(x, y, button)
		end
	end
end

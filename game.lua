local M = {}
M.__index = M

local Cell = require "cell"

function M.new() return setmetatable({ mouseEnabled = true }, M) end

function M.start(self)
	self.cells = {}
	for j = 1, 9 do
		self.cells[j] = {}
		for i = 1, 9 do self.cells[j][i] = Cell.new(self, (i - 1) * 32, (j - 1) * 32) end
	end
	local m = 10
	while m > 0 do
		local x = math.floor(math.random() * 9) + 1
		local y = math.floor(math.random() * 9) + 1
		if self.cells[y][x].value ~= "mine" then
			self.cells[y][x].value = "mine"
			m = m - 1
		end
	end
	for j = 1, 9 do
		for i = 1, 9 do
			if self.cells[j][i].value ~= "mine" then
				local t = 0
				if j > 1 and self.cells[j - 1][i].value == "mine" then t = t + 1 end
				if j < 9 and self.cells[j + 1][i].value == "mine" then t = t + 1 end
				if i > 1 and self.cells[j][i - 1].value == "mine" then t = t + 1 end
				if i < 9 and self.cells[j][i + 1].value == "mine" then t = t + 1 end
				if j > 1 and i > 1 and self.cells[j - 1][i - 1].value == "mine" then t = t + 1 end
				if j < 9 and i > 1 and self.cells[j + 1][i - 1].value == "mine" then t = t + 1 end
				if j > 1 and i < 9 and self.cells[j - 1][i + 1].value == "mine" then t = t + 1 end
				if j < 9 and i < 9 and self.cells[j + 1][i + 1].value == "mine" then t = t + 1 end
				self.cells[j][i].value = t
			end
		end
	end
	self.mouseEnabled = true
end

function M.checkIfWon(self)
	local c = 71
	for j = 1, 9 do
		for i = 1, 9 do
			if self.cells[j][i].value ~= "mine" and self.cells[j][i]:isRevealed() then
				c = c - 1
			end
		end
	end
	if c == 0 then
		self.mouseEnabled = false
		love.audio.play(love.audio.newSource("assets/audio/tada.wav", "static"))
	end
end

function M.lose(self, x, y)
	self.mouseEnabled = false
	for j = 1, 9 do
		for i = 1, 9 do
			if self.cells[j][i].value ~= "mine" and self.cells[j][i]:isFlagged() then
				self.cells[j][i].image = love.graphics.newImage("assets/cells/nomine.png")
			end
			if self.cells[j][i].value == "mine" and not self.cells[j][i]:isFlagged() then
				self.cells[j][i]:reveal()
			end
		end
	end
	self.cells[y][x].image = love.graphics.newImage("assets/cells/fail.png")
	love.audio.play(love.audio.newSource("assets/audio/explode.wav", "static"))
end

function M.draw(self)
	for j = 1, 9 do
		for i = 1, 9 do self.cells[j][i]:draw() end
	end
end

function M.mousepressed(self, x, y, button)
	if self.mouseEnabled then
		for j = 1, 9 do
			for i = 1, 9 do self.cells[j][i]:mousepressed(x, y, button) end
		end
	end
end

function M.mousereleased(self, x, y, button)
	if self.mouseEnabled then
		for j = 1, 9 do
			for i = 1, 9 do self.cells[j][i]:mousereleased(x, y, button) end
		end
	end
end

return M

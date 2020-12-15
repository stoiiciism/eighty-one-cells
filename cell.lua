local M = {}
M.__index = M

function cursorover(cell, x, y)
	return x >= cell.x and x < cell.x + 32 and y >= cell.y and y < cell.y + 32
end

function M.new(x, y)
	local self = setmetatable({}, M)
	self.value = 0
	self.x = x
	self.y = y
	self:fix()
	return self
end

function M.isFixed(self)
	return not self.p[1] and not self.p[2] and not self.p[3]
end

function M.isFlagged(self)
	return self.p[1]
end

function M.isPressed(self)
	return self.p[2]
end

function M.isRevealed(self)
	return self.p[3]
end

function M.fix(self)
	self.p = { false, false, false }
	self.image = love.graphics.newImage("assets/cells/block.png")
end

function M.flag(self)
	self:fix()
	self.p[1] = true
	self.image = love.graphics.newImage("assets/cells/flag.png")
end

function M.press(self)
	self:fix()
	self.p[2] = true
	self.image = love.graphics.newImage("assets/cells/0.png")
end

function M.reveal(self)
	self:fix()
	self.p[3] = true
	self.image = love.graphics.newImage("assets/cells/"..self.value..".png")
end

function M.draw(self)
	if self.image ~= nil then
		love.graphics.draw(self.image, self.x, self.y)
	end
end

function M.mousepressed(self, x, y, button)
	if cursorover(self, x, y) then
		if self:isFixed() then
			if button == 1 then
				self:press()
			elseif button == 2 then
				self:flag()
			end
		elseif self:isFlagged() then
			if button == 2 then
				self:fix()
			end
		end
	end
end

function M.mousereleased(self, x, y, button)
	if cursorover(self, x, y) then
		if self:isPressed() then
			if button == 1 then
				self:reveal()
			end
		end
	end
end

return M

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
	self:setState(0)
	return self
end

function M.setState(self, state)
	self.state = state
	if self.state == 0 then self.image = love.graphics.newImage("assets/cells/block.png")
	elseif self.state == 1 then self.image = love.graphics.newImage("assets/cells/flag.png")
	elseif self.state == 2 then self.image = love.graphics.newImage("assets/cells/0.png")
	elseif self.state == 3 then self.image = love.graphics.newImage("assets/cells/"..self.value..".png") end
end

function M.draw(self)
	if self.image ~= nil then
		love.graphics.draw(self.image, self.x, self.y)
	end
end

function M.mousepressed(self, x, y, button)
	if cursorover(self, x, y) then
		if self.state == 0 then
			if button == 1 then self:setState(2)
			elseif button == 2 then self:setState(1) end
		end
	end
end

function M.mousereleased(self, x, y, button)
	if cursorover(self, x, y) then
		if self.state == 2 then
			if button == 1 then self:setState(2) self:setState(3) end
		end
	end
end

return M

local M = {}
M.__index = M

function M.new(x, y)
	local self = setmetatable({}, M)
	self.value = 0
	self.image = love.graphics.newImage("assets/cells/0.png")
	self.x = x
	self.y = y
	return self
end

function M.draw(self)
	if self.image ~= nil then
		love.graphics.draw(self.image, self.x * 32, self.y * 32)
	end
end

function M.mousepressed(self, x, y, button)
	
end

return M

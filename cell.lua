local M = {}
M.__index = M

function M.new(x, y)
	local self = setmetatable({}, M)
	self.image = love.graphics.newImage("assets/cells/block.png")
	self.x = x
	self.y = y
	return self
end

function M.draw(self)
	if self.image ~= nil then
		love.graphics.draw(self.image, self.x * 32, self.y * 32)
	end
end

return M

local Game = require "game"
local game = Game.new()

function love.load()
	math.randomseed(os.time())
	game:start()
end

function love.update(dt) end

function love.draw()
	game:draw()
end

function love.keypressed(key)
	if key == "escape" then love.event.quit() end
end

function love.keyreleased(key)
	if key == "r" then game:start() end
end

function love.mousepressed(x, y, button)
	game:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	game:mousereleased(x, y, button)
end

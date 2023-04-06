Classe = require "classic"
require "jogo"
require "cenario"
require "player"
require "score"

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    jogo = Jogo()
end

function love.update(dt)
    jogo:update(dt)
end

function love.draw()
    jogo:draw()
end
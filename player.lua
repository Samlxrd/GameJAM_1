Player = Classe:extend()

function Player:new()
    self.x, self.y = love.graphics.getDimensions()
    self.w, self.h = 50, 50
    self.x, self.y = (self.x / 2) - (self.w / 2), (self.y / 8)
    self.speed = 400
    self.score, self.highscore = 0,0
end

function Player:update(dt)
    if love.keyboard.isDown("a") and self.x > 0 then
        self.x = self.x - self.speed * dt
    end

    if love.keyboard.isDown("d") and self.x < love.graphics.getWidth() - self.w then
        self.x = self.x + self.speed * dt
    end
end

function Player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end
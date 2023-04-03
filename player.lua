Player = Classe:extend()

leftKey = {"a", "left"}
rightKey = {"d", "right"}
upKey = {"w", "up"}
downKey = {"s", "down"}

gravity = 2

function Player:new()
    self.x, self.y = love.graphics.getDimensions()
    self.w, self.h = 2, 2
    self.x, self.y = (self.x / 2) - (self.w / 2), (self.y / 8)
    self.direction = 1
    self.speed = 400
    self.score, self.highscore = 0,0

    self.sprite = love.graphics.newImage("images/MyChar.png")
end

function Player:update(dt)

    if self.y < love.graphics.getHeight() - (self.h * self.sprite:getHeight()) then
        self.y = self.y + gravity
    end

    if love.keyboard.isDown(leftKey) and self.x > 0 then
        if self.direction == -1 then
            self.direction = 1
            self.x = self.x - self.w * self.sprite:getWidth()
        end
        self.x = self.x - self.speed * dt
    end

    if love.keyboard.isDown(rightKey) and self.x < love.graphics.getWidth() - (self.w * self.sprite:getWidth()) then
        if self.direction == 1 then
            self.direction = -1
            self.x = self.x + self.w * self.sprite:getWidth()
        end
        self.x = self.x + self.speed * dt
    end

    if love.keyboard.isDown(upKey) and self.y > 0 then
        self.y = self.y - self.speed * dt
    end

    if love.keyboard.isDown(downKey) and self.y < love.graphics.getHeight() - (self.h * self.sprite:getHeight()) then
        self.y = self.y + self.speed * dt
    end
end

function Player:draw()
    love.graphics.draw(self.sprite, self.x, self.y, 0, self.direction * self.w, self.h)
end
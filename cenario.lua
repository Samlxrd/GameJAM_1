Cenario = Classe:extend()

waterSprite = love.graphics.newImage("images/bkWater.png")
boxSprite = love.graphics.newImage("images/box.png")
boxDimension = 32

function Cenario:new()
    time = 0
    max_time = 1.5
    min_time = 0.4
    self.obstacles = {}
    table.insert(self.obstacles, Cenario:generateObstacle())

    self.bubbles = {}
    table.insert(self.bubbles, Cenario:generateBubble())

    self.background = love.graphics.newImage("images/bkBlue.bmp")
end

function Cenario:update(dt)
    time = time + dt
    if time > max_time then -- Ao longo do tempo diminui o intervalo em que são gerados os obstáculos
        table.insert(self.obstacles, Cenario:generateObstacle())
        time = 0
        if max_time > min_time then 
            max_time = max_time - 2*dt
        end
    end

    if math.random(0, 100) > 90 then
        table.insert(self.bubbles, Cenario:generateBubble())
    end

    for i, obstacle in ipairs(self.obstacles) do
        obstacle.y = obstacle.y + obstacle.speed + obstacle.gravity*dt -- Obstáculos subindo
        obstacle.x = obstacle.x + (10 / (max_time * 3)) * math.sin(obstacle.y*dt) -- Variação do x do obstáculo
    end

    for i, bubble in ipairs(self.bubbles) do
        bubble.y = bubble.y + bubble.speed*dt
    end

    Cenario:passed() -- Ao sair da tela, remove o obstáculo da tabela
end

function Cenario:draw()
    for i = 0, love.graphics.getWidth() / self.background:getWidth() do
        for j = 0, love.graphics.getHeight() / self.background:getHeight() do
            love.graphics.draw(self.background, i * self.background:getWidth(), j * self.background:getHeight())
        end
    end

    for i, obstacle in ipairs(self.obstacles) do
        for i = 0, obstacle.w / boxDimension do
            for j = 0, obstacle.h / boxDimension do
                love.graphics.draw(boxSprite, obstacle.x + (boxDimension * i), obstacle.y + (boxDimension * j))
            end
        end

        --love.graphics.setColor(obstacle.color)
        --love.graphics.rectangle("fill", obstacle.x, obstacle.y, obstacle.w, obstacle.h)
        --love.graphics.setColor(90,90,90,1)
    end

    for i, bubble in ipairs(self.bubbles) do
        love.graphics.draw(waterSprite, bubble.x, bubble.y, 0, 2, 2)
    end
end

function Cenario:generateObstacle()
    ob = {}
    ob.h = boxDimension * math.random(1, 2)   --math.random(30,80)
    ob.w = boxDimension * math.random(3, 8)   --math.random(100, 200)
    ob.x = math.random(0, love.graphics.getWidth() - ob.w)
    ob.y = love.graphics.getHeight()
    ob.passed = false
    ob.gravity = -200
    ob.speed = -5.5
    return ob
end

function Cenario:generateBubble()
    bubble = {}
    bubble.x = math.random(0, love.graphics.getWidth() - waterSprite:getWidth())
    bubble.y = love.graphics.getHeight()
    bubble.speed = -200
    return bubble
end

function Cenario:passed()
    if self.obstacles ~= nil then
        for i, obstacle in ipairs(self.obstacles) do
            if obstacle.y < love.graphics.getHeight() - obstacle.height then
                table.remove(self.obstacles, i)
            end
        end
    end

    if self.bubbles ~= nil then
        for i, bubble in ipairs(self.bubbles) do
            if bubble.y < love.graphics.getHeight() - bubble.h then
                table.remove(self.bubbles, i)
            end
        end
    end
end
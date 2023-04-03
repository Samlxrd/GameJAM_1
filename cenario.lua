Cenario = Classe:extend()

function Cenario:new()
    time = 0
    max_time = 1.5
    min_time = 0.4
    self.obstacles = {}
    table.insert(self.obstacles, Cenario:generateObstacle())

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

    for i, obstacle in ipairs(self.obstacles) do
        obstacle.y = obstacle.y + obstacle.speed + obstacle.gravity*dt -- Obstáculos subindo
        obstacle.x = obstacle.x + (10 / (max_time * 3)) * math.sin(obstacle.y*dt) -- Variação do x do obstáculo
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
        love.graphics.setColor(obstacle.color)
        love.graphics.rectangle("fill", obstacle.x, obstacle.y, obstacle.w, obstacle.h)
        love.graphics.setColor(90,90,90,1)
    end
end

function Cenario:generateObstacle()
    ob = {}
    ob.h = math.random(30,80)
    ob.w = math.random(100, 200)
    ob.x = math.random(0, love.graphics.getWidth() - ob.w)
    ob.y = love.graphics.getHeight()
    ob.passed = false
    ob.gravity = -200
    ob.speed = -5.5
    ob.color = {0.5,0.5,0.5}
    return ob
end

function Cenario:passed()
    if self.obstacles ~= nil then
        for i, obstacle in ipairs(self.obstacles) do
            if obstacle.y < love.graphics.getHeight() - obstacle.height then
                table.remove(self.obstacles, i)
            end
        end
    end
end
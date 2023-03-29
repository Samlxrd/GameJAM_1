Score = Classe:extend()

function Score:new()
    self.score, self.highscore = 0,0
end

function Score:update(dt)

end

function Score:draw()
    local font = love.graphics.getFont()
    s = "Score: "..tostring(self.score).."\n".."Highscore: "..tostring(self.highscore)
    love.graphics.newText(font,s)
    --love.graphics.setColor(1, 1, 0, 1)
    local x,y = love.graphics.getDimensions()
    x,y = x - 15/100 * x, y - 10/100 * y
    love.graphics.print(s, x, y, 0, 1,1,0)
end
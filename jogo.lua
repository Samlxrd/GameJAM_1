Jogo = Classe:extend()

function Jogo:new()
    cenario = Cenario()
    player = Player()
    score = Score()
    --self.score = 0
    --self.highscore = 0
end

function Jogo:update(dt)
    for i, box in ipairs(cenario.obstacles) do
        if verificaColisao(player, box) then
            score.score = 0
            player = Player()
            cenario = Cenario()
        end
    end
    cenario:update(dt)
    player:update(dt)
    for i, box in ipairs(cenario.obstacles) do
        if (player.y + player.h > box.y + box.h) and box.passed == false then
            score.score = score.score + 1
            box.passed = true
            if score.score > score.highscore then
                score.highscore = score.score
            end
        end
    end
end

function Jogo:draw()
    cenario:draw()
    player:draw()
    score:draw()
end

function verificaColisao(player, box)
    if player.x < box.x + box.w and
        player.x + player.w > box.x and
        player.y < box.y + box.h and
        player.y + player.h > box.y then
            return true
    end
end

--[[ function Jogo:Score(player, box)
    if player.y + player.h > box.y + box.h then
        self.score = self.score + 1
        if self.score > self.highscore then
            self.highscore = self.score
        end
    end
end ]]
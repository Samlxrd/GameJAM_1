Jogo = Classe:extend()

function Jogo:new()
    cenario = Cenario()
    player = Player()
    score = Score()
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
        if (player.y + player.scale > box.y + box.h) and box.passed == false then
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
        player.x  + (player.scale * player.sprite:getWidth())> box.x and
        player.y < box.y + box.h and
        player.y + (player.scale * player.sprite:getHeight()) > box.y then
            return true
    end
end
SMODS.Atlas{
    key = "annoying",
	atlas_table = "ANIMATION_ATLAS",
	path = "b_swapper.png",
	px = 34,
	py = 34,
	frames = 1
}

SMODS.Blind{
    key = "annoying",
    loc_txt = {
        name = "The Annoying",
        text = {
            "placeholder"
        }
    },
    name = "The Annoying",
    dollars = 5,
    mult = 1,
    boss = { min = 1 },
    boss_colour = HEX("24cca5"),
    atlas = "annoying",
    pos = { x = 0, y = 0 },
    config = {},
    set_blind = function(self)
        local last = os.clock()
        local lasers = RansomJunk.lasers
        local tick = 0
        RansomJunk.defeat = false
        G.E_MANAGER:add_event(Event({
            blocking = false,
            func = function()
                local now = os.clock()
                if now - last >= 0.05 then
                    tick = tick + 1
                    last = now
                    if tick % 8 == 0 then
                        if math.random(2) == 1 then
                            table.insert(lasers, { x = love.mouse.getX(), time = 0 })
                        else
                            table.insert(lasers, { y = love.mouse.getY(), time = 0 })
                        end
                    end
                    for i = #lasers, 1, -1 do
                        local laser = lasers[i]
                        if laser.time == 27 then
                            table.remove(lasers, i)
                        end
                        if laser.time >= 18 then
                            if laser.x then
                                if love.mouse.getX() > laser.x - 60 and love.mouse.getX() < laser.x + 60 then
                                    G.GAME.chips = math.floor(math.min(G.GAME.chips - G.GAME.blind.chips / 100, G.GAME.chips * 0.96))
                                end
                            else
                                if love.mouse.getY() > laser.y - 60 and love.mouse.getY() < laser.y + 60 then
                                    G.GAME.chips = math.floor(math.min(G.GAME.chips - G.GAME.blind.chips / 100, G.GAME.chips * 0.96))
                                end
                            end
                        end
                        laser.time = laser.time + 1
                    end
                end
                if RansomJunk.defeat then
                    return true
                end
            end
        }))
    end,
    defeat = function(self)
        RansomJunk.defeat = true
        RansomJunk.lasers = {}
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end
}

local love_draw_ref = love.draw
function love.draw()
    love_draw_ref()

    if G.GAME.blind and G.GAME.blind.config.blind.key == "bl_rj_annoying" then
        love.graphics.setLineWidth(30)
        for _, laser in pairs(RansomJunk.lasers) do
            if laser.time >= 18 then
                love.graphics.setColor(1, 0, 0, 1)
            elseif laser.time >= 15 then
                love.graphics.setColor(1, 0, 0, (laser.time - 13) / 5)
            else
                love.graphics.setColor(1, 0, 0, 0.2)
            end
            if laser.x then
                love.graphics.line(laser.x, 0, laser.x, 2000)
            else
                love.graphics.line(0, laser.y, 2000, laser.y)
            end
        end
    end
end
-- AIVCDA8L
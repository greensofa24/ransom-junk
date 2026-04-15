SMODS.Shader({ key = "cool", path = "test.fs" })

SMODS.Edition({
    key = "cool",
    config = { chips = 73 },
    pos = { x = 0, y = 0 },
    shader = "cool",
    in_shop = true,
    weight = 8,
    extra_cost = 4,
    sound = { sound = "foil1", per = 1.2, vol = 0.4 },
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            G.GAME.blind.chips = math.floor(G.GAME.blind.chips * 8/9)
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end,
    loc_vars = function(self, info_queue, edition)
        return { vars = { self.config.chips } }
    end
})
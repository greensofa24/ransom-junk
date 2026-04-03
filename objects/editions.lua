SMODS.Shader({ key = "cool", path = "test.fs" })

SMODS.Edition({
    key = "cool",
    config = { chips = 73 },
    pos = { x = 0, y = 0 },
    shader = "cool",
    in_shop = true,
    weight = 800,
    extra_cost = 6,
    apply_to_float = true,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                chips = self.config.chips
            }
        end
    end,
    loc_vars = function(self, info_queue, edition)
        return { vars = { self.config.chips } }
    end
})
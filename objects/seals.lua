SMODS.Atlas({
    key = "double_red",
    path = "double_red_seal.png",
    px = 71,
    py = 95
})

SMODS.Seal {
    key = "double_red",
    pos = { x = 0, y = 0 },
    config = { extra = { retriggers = 2 } },
    badge_colour = G.C.RED,
    atlas = "double_red",
    calculate = function(self, card, context)
        if context.repetition then
            return {
                repetitions = card.ability.seal.extra.retriggers,
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.retriggers } }
    end
}
SMODS.Atlas({
    key = "debuff",
    path = "j_placeholder.png",
    px = 71,
    py = 95
})

SMODS.Consumable({
    set = "Spectral",
    key = "debuff",
    atlas = "debuff",
    pos = { x = 0, y = 0 }, 
    loc_txt = {
        name = "debuff",
        text = {
            "debuff test"
        }
    },
    cost = 4,
    config = {},
    can_use = function(self, card)
        return #G.hand.cards > 0
    end,
    use = function(card, area, copier)
        G.hand.highlighted[1]:flip()
    end,
    loc_vars = function(self, info_queue, card)
        return {}
    end
})
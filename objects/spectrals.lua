SMODS.Atlas({
    key = "insomnia",
    path = "j_placeholder.png",
    px = 71,
    py = 95
})

SMODS.Consumable({
    set = "Spectral",
    key = "insomnia",
    atlas = "insomnia",
    pos = { x = 0, y = 0 }, 
    loc_txt = {
        name = "Insomnia",
        text = {
            "Destroy {C:attention}1{} random",
            "card in your hand, add {C:attention}1",
            "random card with a",
            "{C:attention}Red Seal with a Red Seal",
            "to your hand"
        }
    },
    cost = 4,
    config = { amount = 4 },
    can_use = function(self, card)
        return #G.hand.cards > 0
    end,
    use = function(card, area, copier)
        local used_tarot = copier or card
        local card_to_destroy = pseudorandom_element(G.hand.cards, 'random_destroy')
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true
            end
        }))
        SMODS.destroy_cards(card_to_destroy)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function()
                added_card = SMODS.add_card { set = "Base", seal = "rj_double_red" }
                SMODS.calculate_context({ playing_card_added = true, cards = { added_card } })
                return true
            end
        }))
        delay(0.3)
    end,
    loc_vars = function(self, info_queue, card)
        return {}
    end
})
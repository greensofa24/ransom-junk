SMODS.Joker:take_ownership("8_ball", {
    rarity = "rj_junk"
}, true)

SMODS.Joker:take_ownership("delayed_grat", {
    rarity = "rj_junk"
}, true)

SMODS.Joker:take_ownership("faceless", {
    rarity = "rj_junk"
}, true)

SMODS.Joker:take_ownership("superposition", {
    rarity = "rj_junk"
}, true)

SMODS.Joker:take_ownership("matador", {
    rarity = "rj_junk"
}, true)

SMODS.Joker:take_ownership("seance", {
    rarity = 1
}, true)

SMODS.Joker:take_ownership("pareidolia", {
    rarity = 1
}, true)

SMODS.Joker:take_ownership("hit_the_road", {
    rarity = 2
}, true)

SMODS.Consumable:take_ownership("strength", {
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if G.hand.highlighted[i]:get_id() == 14 and next(SMODS.find_card("c_hex")) then
                        assert(SMODS.change_base(G.hand.highlighted[i], nil, "rj_B"))
                    else
                        assert(SMODS.modify_rank(G.hand.highlighted[i], 1))
                    end
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end
})

SMODS.Joker:take_ownership("fibonacci", {
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 2 or
                context.other_card:get_id() == 3 or
                context.other_card:get_id() == 5 or
                context.other_card:get_id() == 8 or
                context.other_card:get_id() == 14 or
                context.other_card:get_id() == 15 or
                context.other_card:get_id() == 16 or
                context.other_card:get_id() == 19 then
                return {
                    mult = card.ability.extra
                }
            end
        end
    end
})
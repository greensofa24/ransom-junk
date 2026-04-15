SMODS.Atlas({
    key = "temporary",
    path = "temporary.png",
    px = 71,
    py = 95
})

SMODS.Sticker({
    key = "temporary",
    badge_colour = HEX("3f3f3f"),
    pos = { x = 0, y = 0 },
    atlas = "temporary"
})

local end_round_ref = end_round
function end_round()
    local temporary_cards = {}

    for _, v in ipairs(G.jokers and G.jokers.cards or {}) do
        if v.ability.rj_temporary then
            temporary_cards[#temporary_cards + 1] = v
        end
    end

    for _, v in ipairs(G.consumeables and G.consumeables.cards or {}) do
        if v.ability.rj_temporary then
            temporary_cards[#temporary_cards + 1] = v
        end
    end

    for _, v in ipairs(G.playing_cards or {}) do
        if v.ability.rj_temporary then
            temporary_cards[#temporary_cards + 1] = v
        end
    end

    if #temporary_cards > 0 then
        SMODS.destroy_cards(temporary_cards)
    end

    return end_round_ref()
end

local eval_play_ref = G.FUNCS.evaluate_play
function G.FUNCS.evaluate_play()
    local ret = eval_play_ref()

    if G.GAME.chips + SMODS.calculate_round_score() >= G.GAME.blind.chips then
        local temporary_cards = {}

        for _, v in ipairs(G.play.cards or {}) do
            if v.ability.rj_temporary then
                temporary_cards[#temporary_cards + 1] = v
            end
        end

        if #temporary_cards > 0 then
            SMODS.destroy_cards(temporary_cards)
        end
    end

    return ret
end

SMODS.Atlas({
    key = "pinned",
    path = "pinned.png",
    px = 71,
    py = 95
})

SMODS.Sticker:take_ownership("pinned", {
    pos = { x = 0, y = 0 },
    atlas = "pinned"
}, true)

SMODS.Atlas({
    key = "locked",
    path = "locked.png",
    px = 71,
    py = 95
})

SMODS.Sticker({
    key = "locked",
    badge_colour = HEX("cac8d2"),
    pos = { x = 0, y = 0 },
    atlas = "locked"
})

SMODS.Atlas({
    key = "hazardous",
    path = "hazardous.png",
    px = 71,
    py = 95
})

SMODS.Sticker({
    key = "hazardous",
    badge_colour = HEX("5fe348"),
    pos = { x = 0, y = 0 },
    atlas = "hazardous",
    apply = function(self, card, val)
        if val then
            card.ability.extra_slots_used = card.ability.extra_slots_used + 1
        else
            card.ability.extra_slots_used = card.ability.extra_slots_used - 1
        end
        card.ability[self.key] = val
    end
})
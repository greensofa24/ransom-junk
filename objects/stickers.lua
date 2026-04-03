SMODS.Atlas({
    key = "temporary",
    path = "temporary.png",
    px = 71,
    py = 95
})

SMODS.Sticker({
    key = "temporary",
    badge_colour = HEX("ba3535"),
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

    if G.GAME.chips + hand_chips * mult >= G.GAME.blind.chips then
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
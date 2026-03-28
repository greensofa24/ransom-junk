-- Config
discovered_by_default = true

SMODS.Atlas({
    key = "one",
    path = "j_placeholder.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "two",
    path = "j_two.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "four",
    path = "j_four.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "six",
    path = "j_six.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "x",
    path = "j_x.png",
    px = 71,
    py = 95
})

SMODS.Joker{
	key = "one",
    config = { extra = {} },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "one",
    calculate = function(self, card, context)
        if context.pre_joker_main then
            for _, played_card in ipairs(context.scoring_hand) do
                if played_card:get_id() == 4 then
                    SMODS.destroy_cards(G.play.cards)
                    local added_card = SMODS.create_card { set = "Base", rank = "rj_1", suit = "Clubs", edition = "e_negative", area = G.hand }
                    table.insert(G.playing_cards, added_card)
                    G.hand:emplace(added_card)
                    added_card.states.visible = nil

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            added_card:start_materialize()
                            G.GAME.blind:debuff_card(added_card)
                            G.hand:sort()
                            if context.blueprint_card then
                                context.blueprint_card:juice_up()
                            else
                                card:juice_up()
                            end
                            SMODS.calculate_context({ playing_card_added = true, cards = { added_card } })
                            save_run()
                            return true
                        end
                    }))

                    return nil, true
                end
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end
}

SMODS.Joker{
	key = "two",
    config = { extra = { e_mult = 2^(1/2) } },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "two",
    calculate = function(self, card, context)
        --[[if context.pre_joker_main then
            local evens = {}
            for _, played_card in ipairs(context.scoring_hand) do
                local id = played_card:get_id()
                if id <= 10 and id >= 0 and id % 2 == 0 then
                    if table.contains(evens, id) then
                        return {
                            message = "^2^(1/2) Mult",
                            colour = G.C.RJ.GREEN,
                            e_mult = card.ability.extra.e_mult,
                            remove_default_message = true
                        }
                    else
                        table.insert(evens, id)
                    end
                end
            end
        end]]
        if context.initial_scoring_step then
            return {
                message = "^2^(1/2) Mult",
                colour = G.C.RJ.GREEN,
                e_mult = card.ability.extra.e_mult,
                remove_default_message = true
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end
}

SMODS.Joker{
	key = "four",
    config = { extra = { h_x_mult = 4, c_x_mult = 4^(1/4) } },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "four",

	calculate = function(self, card, context)
        --[[if context.setting_blind then
            trigger_card = context.blueprint_card or card
            level_up_hand(trigger_card, "Straight", nil, -4)
            level_up_hand(trigger_card, "Flush", nil, -4)
            level_up_hand(trigger_card, "Full House", nil, -4)
            level_up_hand(trigger_card, "Straight Flush", nil, -4)
            level_up_hand(trigger_card, "Five of a Kind", nil, -4)
            level_up_hand(trigger_card, "Flush House", nil, -4)
            level_up_hand(trigger_card, "Flush Five", nil, -4)
        end]]
        if context.individual and context.cardarea == G.play and
            context.other_card:get_id() == 4 then
            return {
                message = "X4^(1/4) Mult",
                colour = G.C.SECONDARY_SET.Spectral,
                x_mult = card.ability.extra.c_x_mult,
                remove_default_message = true
            }
        end
        if context.joker_main then
            if #G.play.cards == 4 then
                return {
                    message = "X4 Mult",
                    colour = G.C.SECONDARY_SET.Spectral,
                    x_mult = card.ability.extra.h_x_mult,
                    remove_default_message = true
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.h_x_mult } }
	end
}

SMODS.Joker{
	key = "six",
    config = { extra = { select_limit = 1 } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "six",
	add_to_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(card.ability.extra.select_limit)
		SMODS.change_discard_limit(card.ability.extra.select_limit)
	end,
	remove_from_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(-card.ability.extra.select_limit)
		SMODS.change_discard_limit(-card.ability.extra.select_limit)
		if G.hand and G.hand.highlighted and #G.hand.highlighted == 6 then
			G.hand:unhighlight_all()
		end
	end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.select_limit } }
	end
}

SMODS.Joker{
	key = "x",
    config = { extra = { min_x_mult = 1.1, max_x_mult = 1.7, max_triggers = 77, triggers = 0 } },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "x",

	calculate = function(self, card, context)
        local x_mult = math.random(card.ability.extra.min_x_mult * 10, card.ability.extra.max_x_mult * 10) / 10

        if context.before then
            card.ability.extra.triggers = 0
        end

        if card.ability.extra.triggers == card.ability.extra.max_triggers then
            return
        end

        if not context.end_of_round and context.individual then
            if context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_steel") then
                card.ability.extra.triggers = card.ability.extra.triggers + 1
                return {
                    message = "X"..x_mult.." Mult",
                    colour = G.C.RJ.YELLOW,
                    x_mult = x_mult,
                    remove_default_message = true
                }
            end
            if context.cardarea == G.play and context.other_card.edition and context.other_card.edition.polychrome then
                card.ability.extra.triggers = card.ability.extra.triggers + 1
                return {
                    message = "X"..x_mult.." Mult",
                    colour = G.C.RJ.YELLOW,
                    x_mult = x_mult,
                    remove_default_message = true
                }
            end
        end

        if context.post_trigger then
            local other_ret = context.other_ret.jokers or {}
            if context.other_card == card then return end
            if (other_ret.x_mult or other_ret.xmult or other_ret.Xmult_mod) then
                card.ability.extra.triggers = card.ability.extra.triggers + 1
                return {
                    message = "X"..x_mult.." Mult",
                    colour = G.C.RJ.YELLOW,
                    x_mult = x_mult,
                    remove_default_message = true
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.min_x_mult, card.ability.extra.max_x_mult, card.ability.extra.max_triggers } }
	end
}
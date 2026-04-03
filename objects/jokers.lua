-- Config
discovered_by_default = true

SMODS.Atlas({
    key = "one",
    path = "j_one.png",
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
    key = "three",
    path = "j_three.png",
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
    key = "eight",
    path = "j_eight.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "nine",
    path = "j_nine.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "ten",
    path = "j_placeholder.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "x",
    path = "j_x.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "chipped_tooth",
    path = "j_chipped_tooth.png",
    px = 213,
    py = 285
})

SMODS.Atlas({
    key = "annoying_fly",
    path = "j_annoying_fly.png",
    px = 213,
    py = 285
})

SMODS.Atlas({
    key = "garbage_dealer",
    path = "j_garbage_dealer.png",
    px = 213,
    py = 285
})

SMODS.Joker{
	key = "one",
    config = { extra = {} },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
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
            local four_count = 0
            for _, played_card in ipairs(context.scoring_hand) do
                if played_card:get_id() == 4 then
                    four_count = four_count + 1
                end
            end
            if four_count > 0 then
                if not context.blueprint then
                    SMODS.destroy_cards(G.play.cards)
                end
                for i = 1, four_count do
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
                end
                return nil, true
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
	key = "three",
    config = { extra = { c_x_mult = 1, x_x_mult = 1.03 } },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "three",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return {
                message = "X"..(math.floor(card.ability.extra.c_x_mult * 100 + 0.5) / 100).." Mult",
                colour = G.C.RJ.THREE,
                x_mult = card.ability.extra.c_x_mult,
                remove_default_message = true
            }
        end
        if context.remove_playing_cards and not context.blueprint then
            card.ability.extra.c_x_mult = card.ability.extra.c_x_mult * card.ability.extra.x_x_mult ^ #context.removed
            return {
                message = localize {
                    type = "variable",
                    key = "a_xmult",
                    vars = {
                        card.ability.extra.c_x_mult
                    }
                }
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.c_x_mult, card.ability.extra.x_x_mult } }
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
	key = "eight",
    config = { extra = { chance = (1/8)^(1/8), uses = 0 } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "eight",
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            card.ability.extra.uses = card.ability.extra.uses + 1

            return {
                message = "+1 Use",
                colour = G.C.RJ.GREY
            }
        end
    end,
    can_use = function(self, card)
        return #G.hand.highlighted == 1 and card.ability.extra.uses > 0
    end,
    use = function(self, card, context)
        if #G.hand.highlighted == 1 then
            if math.random() < card.ability.extra.chance then
                local created_cards = {}

                for i = 1, 3 do
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local card_copied = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)

                    card_copied:add_sticker("rj_temporary", true)
                    card_copied:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, card_copied)
                    G.hand:emplace(card_copied)
                    card_copied.states.visible = nil

                    table.insert(created_cards, card_copied)

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_copied:start_materialize()
                            return true
                        end
                    }))
                end

                return {
                    message = localize('k_copied_ex'),
                    colour = G.C.RJ.GREY,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.calculate_context({ playing_card_added = true, cards = created_cards })
                                return true
                            end
                        }))
                    end
                }
            else
                return {
                    message = "Go Fish",
                    colour = G.C.RJ.GREY
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end
}

SMODS.Joker{
	key = "nine",
    config = { extra = { edition = "e_rj_cool", scored_tally = 0 } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "nine",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            card.ability.extra.scored_tally = card.ability.extra.scored_tally + 1
            if card.ability.extra.scored_tally == 9 then
                card.ability.extra.scored_tally = 0
                local other_card = context.other_card
                SMODS.calculate_effect({
                    message = "Coolness Up!",
                    colour = G.C.RJ.NINE
                }, other_card)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        other_card:set_edition(card.ability.extra.edition)
                        return true
                    end
                }))
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.edition } }
	end
}
--[[
SMODS.Joker{
	key = "ten",
    config = { extra = { chips = 1 } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "ten",
    calculate = function(self, card, context)
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end
}
]]
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

SMODS.Joker{
	key = "chipped_tooth",
    config = { extra = { chips = 1 } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = "rj_junk",
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "chipped_tooth",
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end
}

SMODS.Joker{
	key = "annoying_fly",
    config = { extra = { mult = 1 } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = "rj_junk",
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "annoying_fly",
    calculate = function(self, card, context)
        if context.joker_main then
            if math.random(1, 111) == 1 then
                return {
                    mult = card.ability.extra.mult
                }
            else
                return {
                    message = localize('k_nope_ex'),
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end
}

SMODS.Joker{
	key = "garbage_dealer",
    config = { extra = { j_x_mult = 2 } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = "rj_garbage",
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "garbage_dealer",
    calculate = function(self, card, context)
        if context.joker_main then
            local junk_count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.rarity == "rj_junk" then
                    junk_count = junk_count + 1
                end
            end
            return {
                message = "X"..card.ability.extra.j_x_mult * junk_count.." Mult",
                colour = G.C.MULT,
                x_mult = card.ability.extra.j_x_mult * junk_count,
                remove_default_message = true
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.j_x_mult } }
	end
}
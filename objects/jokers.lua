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
    key = "five",
    path = "j_five.png",
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

SMODS.Atlas({
    key = "oops_all_1s",
    path = "j_oops_all_1s.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "joker^",
    path = "j_joker^.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "repeat",
    path = "j_repeat.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "lineage",
    path = "j_lineage.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "lua",
    path = "j_lua.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "floating_point",
    path = "j_placeholder.png",
    px = 71,
    py = 95
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
	key = "five",
    config = { extra = { tax = 2/5, yield = 2/5, boss = false, chips = 0 } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "five",
    calculate = function(self, card, context)
        if G.GAME.blind then
            if G.GAME.blind.boss then
                card.ability.extra.boss = true
            elseif G.GAME.blind.boss == false then
                card.ability.extra.boss = false
            end
        end
        if context.starting_shop and card.ability.extra.boss then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - G.GAME.dollars * card.ability.extra.tax
            return {
                dollars = -math.ceil(G.GAME.dollars * card.ability.extra.tax),
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
		RansomJunk.chips_kept = RansomJunk.chips_kept + card.ability.extra.yield
	end,
	remove_from_deck = function(self, card, from_debuff)
		RansomJunk.chips_kept = RansomJunk.chips_kept - card.ability.extra.yield
	end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.tax, card.ability.extra.yield } }
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
    config = { extra = { min_x_factor = 1.1, max_x_factor = 1.7, max_triggers = 77, triggers = 0 } },
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
        local x_factor = math.random(card.ability.extra.min_x_factor * 10, card.ability.extra.max_x_factor * 10) / 10
        local triggered = false

        if context.before then
            card.ability.extra.triggers = 0
        end

        if card.ability.extra.triggers == card.ability.extra.max_triggers then return end

        if context.individual and not context.end_of_round then
            if context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_steel") then
                triggered = true
            end
            if context.cardarea == G.play and (context.other_card.edition and context.other_card.edition.polychrome or SMODS.has_enhancement(context.other_card, "m_glass")) then
                triggered = true
            end
            if triggered then
                card.ability.extra.triggers = card.ability.extra.triggers + 1
                return {
                    message = "X"..x_factor.." Mult",
                    colour = G.C.RJ.YELLOW,
                    x_mult = x_factor,
                    remove_default_message = true
                }
            end
        end

        if context.post_trigger then
            local other_ret = context.other_ret.jokers or {}
            if context.other_card == card then return end
            local ret = {
                colour = G.C.RJ.YELLOW,
                remove_default_message = true
            }
            if (other_ret.x_mult or other_ret.xmult or other_ret.Xmult_mod) then
                triggered = true
                ret.message = "X"..x_factor.." Mult"
                ret.x_mult = x_factor
            end
            if (other_ret.x_chips or other_ret.xchips or other_ret.Xchips_mod) then
                triggered = true
                ret.message = "X"..x_factor.." Chips"
                ret.x_chips = x_factor
            end
            if triggered then
                card.ability.extra.triggers = card.ability.extra.triggers + 1
                return ret
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.min_x_factor, card.ability.extra.max_x_factor, card.ability.extra.max_triggers } }
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
            if math.random(111) == 1 then
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

SMODS.Joker{
	key = "oops_all_1s",
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "oops_all_1s",
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator / 2
            }
        end
    end
}

SMODS.Joker{
	key = "joker_joker",
    config = { extra = { x_mult = 4 } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "joker^",
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult } }
	end
}

SMODS.Joker{
	key = "joker_joker_joker",
    config = { extra = { e_mult = 4 } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "joker^",
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = "^4 Mult",
                colour = G.C.MULT,
                e_mult = card.ability.extra.e_mult,
                remove_default_message = true
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.e_mult } }
	end
}

SMODS.Joker{
	key = "joker^4",
    config = { extra = { ee_mult = 4 } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "joker^",
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = "^^4 Mult",
                colour = G.C.MULT,
                ee_mult = card.ability.extra.ee_mult,
                remove_default_message = true
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.ee_mult } }
	end
}

SMODS.Joker{
	key = "joker^5",
    config = { extra = { eee_mult = 4 } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "joker^",
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = "^^^4 Mult",
                colour = G.C.MULT,
                eee_mult = card.ability.extra.eee_mult,
                remove_default_message = true
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.eee_mult } }
	end
}

SMODS.Joker{
	key = "joker^x",
    config = { extra = { hyperoperator = 1, mult_rhs = 4, prefix = "+" } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "joker^",
    calculate = function(self, card, context)
        if context.joker_main then
            local operator = ""

            if card.ability.extra.hyperoperator == 2 then
                operator = "x_"
            else
                operator = "hyper_"
            end

            local ret = {
                message = card.ability.extra.prefix .. "4 Mult",
                colour = G.C.MULT,
                remove_default_message = true
            }
            if operator == "hyper_" then
                ret.hyper_mult = {
                    card.ability.extra.hyperoperator - 2,
                    card.ability.extra.mult_rhs
                }
            else
                ret[operator .. "mult"] = card.ability.extra.mult_rhs
            end

            card.ability.extra.prefix = ""
            card.ability.extra.hyperoperator = card.ability.extra.hyperoperator + 1

            if card.ability.extra.hyperoperator == 1 then
                card.ability.extra.prefix = "+"
            elseif card.ability.extra.hyperoperator == 2 then
                card.ability.extra.prefix = "X"
            elseif card.ability.extra.hyperoperator >= 3 and card.ability.extra.hyperoperator <= 5 then
                for i = 3, card.ability.extra.hyperoperator do
                    card.ability.extra.prefix = card.ability.extra.prefix .. "^"
                end
            elseif card.ability.extra.hyperoperator > 5 then
                card.ability.extra.prefix = "^{" .. (card.ability.extra.hyperoperator - 2) .. "}"
            end

            return ret
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.prefix, card.ability.extra.mult_rhs } }
	end
}

SMODS.Joker{
	key = "joker^x^x",
    config = { extra = { hyperoperator = 1, mult_rhs = 4, prefix = "+", triggers = 0 } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "joker^",
    calculate = function(self, card, context)
        function factorial(n)
            local result = 1
            for i = 2, n do
                result = result * i
            end
            return result
        end
        if context.joker_main then
            local operator = ""

            if card.ability.extra.hyperoperator == 2 then
                operator = "x_"
            else
                operator = "hyper_"
            end

            local ret = {
                message = card.ability.extra.prefix .. "4 Mult",
                colour = G.C.MULT,
                remove_default_message = true
            }
            if operator == "hyper_" then
                ret.hyper_mult = {
                    card.ability.extra.hyperoperator - 2,
                    card.ability.extra.mult_rhs
                }
            else
                ret[operator .. "mult"] = card.ability.extra.mult_rhs
            end

            card.ability.extra.triggers = card.ability.extra.triggers + 1
            local n = card.ability.extra.triggers + 1
            card.ability.extra.hyperoperator = factorial(2 * n - 1) / (factorial(n) * factorial(n - 1))
            card.ability.extra.prefix = ""

            if card.ability.extra.hyperoperator == 1 then
                card.ability.extra.prefix = "+"
            elseif card.ability.extra.hyperoperator == 2 then
                card.ability.extra.prefix = "X"
            elseif card.ability.extra.hyperoperator >= 3 and card.ability.extra.hyperoperator <= 5 then
                for i = 3, card.ability.extra.hyperoperator do
                    card.ability.extra.prefix = card.ability.extra.prefix .. "^"
                end
            elseif card.ability.extra.hyperoperator > 5 then
                card.ability.extra.prefix = "^{" .. (card.ability.extra.hyperoperator - 2) .. "}"
            end

            return ret
        end
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.prefix, card.ability.extra.mult_rhs, card.ability.extra.triggers + 1 } }
	end
}

SMODS.Joker {
    key = "repeat",
    config = {},
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "repeat",
    calculate = function(self, card, context)
        if context.joker_main then
            local this_card = context.blueprint_card or card
            local index = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == this_card then
                    index = i
                    break
                end
            end
            for i = 1, index - 1 do
                local other_joker = G.jokers.cards[i]
                local blueprint_effect = SMODS.blueprint_effect(this_card, other_joker, context)
                if blueprint_effect then
                    SMODS.calculate_effect(blueprint_effect, this_card)
                end
            end
        end
    end
}

SMODS.Joker {
    key = "lineage",
    config = { extra = { x_mult = 5, type = "Five of a Kind" } },
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "lineage",
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, localize(card.ability.extra.type, "poker_hands") } }
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { localize("Five of a Kind", "poker_hands") } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_no_hand' and G.GAME.hands["Five of a Kind"].played == 5
    end
}

SMODS.Joker {
    key = "lua",
    config = {},
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "lua",
    calculate = function(self, card, context)
        if context.post_individual and (context.cardarea == G.play or context.cardarea == G.hand) and not context.end_of_round then
            SMODS.calculate_context({ cardarea = G.jokers, full_hand = G.play.cards, scoring_hand = context.scoring_hand, scoring_name = context.scoring_name, poker_hands = context.poker_hands, joker_main = true })
        end
    end
}

SMODS.Joker {
    key = "floating_point",
    config = {},
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = discovered_by_default,
    effect = nil,
    atlas = "floating_point",
    calculate = function(self, card, context)
    end
}
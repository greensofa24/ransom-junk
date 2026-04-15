G.FUNCS.discard_cards_from_highlighted = function(e, hook)
    stop_use()
    G.CONTROLLER.interrupt.focus = true
    G.CONTROLLER:save_cardarea_focus('hand')

    for k, v in ipairs(G.playing_cards) do
        v.ability.forced_selection = nil
    end

    if G.CONTROLLER.focused.target and G.CONTROLLER.focused.target.area == G.hand then G.card_area_focus_reset = {area = G.hand, rank = G.CONTROLLER.focused.target.rank} end
    local highlighted_count = math.min(#G.hand.highlighted, G.discard.config.card_limit - #G.play.cards)
    if highlighted_count > 0 then 
        update_hand_text({immediate = true, nopulse = true, delay = 0}, {mult = 0, chips = 0, level = '', handname = ''})
        table.sort(G.hand.highlighted, function(a,b) return a.T.x < b.T.x end)
        inc_career_stat('c_cards_discarded', highlighted_count)
        for j = 1, #G.jokers.cards do
            G.jokers.cards[j]:calculate_joker({pre_discard = true, full_hand = G.hand.highlighted, hook = hook})
        end
        local cards = {}
        local destroyed_cards = {}
        for i=1, highlighted_count do
            G.hand.highlighted[i]:calculate_seal({discard = true})
            local removed = false
            for j = 1, #G.jokers.cards do
                local eval = nil
                eval = G.jokers.cards[j]:calculate_joker({discard = true, other_card =  G.hand.highlighted[i], full_hand = G.hand.highlighted})
                if eval then
                    if eval.remove then removed = true end
                    card_eval_status_text(G.jokers.cards[j], 'jokers', nil, 1, nil, eval)
                end
            end
            table.insert(cards, G.hand.highlighted[i])
            if removed then
                destroyed_cards[#destroyed_cards + 1] = G.hand.highlighted[i]
                if G.hand.highlighted[i].ability.name == 'Glass Card' then 
                    G.hand.highlighted[i]:shatter()
                else
                    G.hand.highlighted[i]:start_dissolve()
                end
            else 
                local card = G.hand.highlighted[i]
                if hook and card.edition and card.edition.rj_cool then
                    card:highlight(false)
                else
                    if not card.ability.rj_locked then
                        card.ability.discarded = true
                        draw_card(G.hand, G.discard, i*100/highlighted_count, 'down', false, card)
                    end
                end
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                G.hand:parse_highlighted()
                return true
            end
        }))

        if destroyed_cards[1] then 
            for j=1, #G.jokers.cards do
                eval_card(G.jokers.cards[j], {cardarea = G.jokers, remove_playing_cards = true, removed = destroyed_cards})
            end
        end

        G.GAME.round_scores.cards_discarded.amt = G.GAME.round_scores.cards_discarded.amt + #cards
        check_for_unlock({type = 'discard_custom', cards = cards})
        if not hook then
            if G.GAME.modifiers.discard_cost then
                ease_dollars(-G.GAME.modifiers.discard_cost)
            end
            ease_discard(-1)
            G.GAME.current_round.discards_used = G.GAME.current_round.discards_used + 1
            G.STATE = G.STATES.DRAW_TO_HAND
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    G.STATE_COMPLETE = false
                    return true
                end
            }))
        end
    end
end

function SMODS.score_card(card, context)
    local reps = { 1 }
    local j = 1
    while j <= #reps do
        if reps[j] ~= 1 then
            local _, eff = next(reps[j])
            while eff.retrigger_flag do
                SMODS.calculate_effect(eff, eff.card); j = j+1; _, eff = next(reps[j])
            end
            SMODS.calculate_effect(eff, eff.card)
            percent = percent + percent_delta
        end

        context.main_scoring = true
        local effects = { eval_card(card, context) }
        SMODS.calculate_quantum_enhancements(card, effects, context)
        context.main_scoring = nil
        context.individual = true
        context.other_card = card

        if next(effects) then
            SMODS.calculate_card_areas('jokers', context, effects, { main_scoring = true })
            SMODS.calculate_card_areas('individual', context, effects, { main_scoring = true })
        end

        local flags = SMODS.trigger_effects(effects, card)

        context.individual = nil
        context.post_individual = true
        if reps[j] == 1 and flags.calculated then
            context.repetition = true
            context.card_effects = effects
            SMODS.calculate_repetitions(card, context, reps)
            context.repetition = nil
            context.card_effects = nil
        end
        j = j + (flags.calculated and 1 or #reps)
        context.other_card = nil
        card.lucky_trigger = nil
        context.post_individual = nil
    end
end

--[[local function perform_checks(table1, op, table2, mod)
    for k, v in pairs(table1) do
        for kk, vv in pairs(table2) do
            if op == "==" and v == vv then return true end
            if op == "~=" and v ~= vv then return true end
            if op == ">" and v > vv then return true end
            if op == ">=" and v >= vv then return true end
            if op == "<" and v < vv then return true end
            if op == "<=" and v <= vv then return true end
            if op == "mod" and v % vv == mod then return true end
            if type(op) == "function" and op(v, vv) then return true end
        end
    end
    return false
end

local ids_op_ref = ids_op
function ids_op(card, op, b, c)
    local id = card:get_id()
    if not id then return false end
    local other_results = false
    if ids_op_ref ~= nil then
        other_results = ids_op_ref(card, op, b, c)
    end

    local floating_point = false

    if G and G.jokers then
        for _, joker in pairs(G.jokers.cards) do
            if joker.config.center.key == "j_rj_floating_point" then
                floating_point = true
                break
            end
        end
    end

    local ids = {}
    if floating_point then
        table.insert(ids, id)

        if id > 2 then
            table.insert(ids, id - 1)
        end
        if id < 14 then
            table.insert(ids, id + 1)
        end
    else
        table.insert(ids, id)
    end

    --[[local function alias(x)
        if SMODS.has_enhancement(card, 'm_wild') and not card.debuff then return '11' end
        return x
    end]]

    --[[if other_results == true then
        return true
    end

    if op == "mod" then
        return perform_checks(ids, "mod", {b}, c)
    end

    if op == "==" then
        for _, v in ipairs(ids) do
            if v == b then
                return true
            end
        end
        return false
    end
    if op == "~=" then
        for _, v in ipairs(ids) do
            if v == b then
                return false
            end
        end
        return true
    end

    if op == ">=" then return perform_checks(ids, ">=", {b}) end
    if op == "<=" then return perform_checks(ids, "<=", {b}) end
    if op == ">" then return perform_checks(ids, ">", {b}) end
    if op == "<" then return perform_checks(ids, "<", {b}) end
end

function get_ranks(card, extra_only)
    if SMODS.has_no_rank(card) then return {} end

    local floating_point = false
    if G and G.jokers then
        for _, joker in pairs(G.jokers.cards) do
            if joker.config.center.key == "j_rj_floating_point" then
                floating_point = true
                break
            end
        end
    end

    local ranks = {}

    if not extra_only then
        local id = card:get_id()
        for _, v in ipairs(SMODS.Rank.obj_buffer) do
            if SMODS.Ranks[v].id == id then
                ranks[v] = true
                break
            end
        end
    end

    if floating_point then
        local id = card:get_id()

        local function add_rank_by_id(target_id)
            for _, v in ipairs(SMODS.Rank.obj_buffer) do
                if SMODS.Ranks[v].id == target_id then
                    ranks[v] = true
                    return
                end
            end
        end

        add_rank_by_id(id)

        if id > 2 then
            add_rank_by_id(id - 1)
        end
        if id < 14 then
            add_rank_by_id(id + 1)
        end
    end

    local ranks_array = {}
    for _, v in ipairs(SMODS.Rank.obj_buffer) do
        if ranks[v] then
            ranks_array[#ranks_array+1] = v
        end
    end

    return ranks_array
end

local function get_base_rank(card)
    return card:get_id()
end

local oldgetxsame = get_X_same
function get_X_same(num, hand, or_more)
    local passed = false
    for _, v in ipairs(hand) do
        if get_ranks(v, true)[1] then
            passed = true
            break
        end
    end
    if not passed then return oldgetxsame(num, hand, or_more) end

    local rank_tally = {}
    local rank_cards = {}
    
    for _, card in ipairs(hand) do
        local base_rank = get_base_rank(card)
        rank_tally[base_rank] = (rank_tally[base_rank] or 0) + 1
        local rank_card = rank_cards[base_rank]
        if rank_card then
            rank_card[#rank_card+1] = card
        else
            rank_cards[base_rank] = {card}
        end
    end

    local ret = {}
    for _, v in ipairs(SMODS.Rank.obj_buffer) do
        local tally = rank_tally[v]
        if tally then
            if or_more and (tally >= num) or (tally == num) then
                ret[#ret+1] = rank_cards[v]
            end
        end
    end
    
    return ret
end

local oldgetstraight = get_straight
function get_straight(hand, min_length, skip, wrap)
    local passed = false
    for _, v in ipairs(hand) do
        if get_ranks(v, true)[1] then
            passed = true
            break
        end
    end
    if not passed then return oldgetstraight(hand, min_length, skip, wrap) end
    min_length = min_length or 5
    if min_length < 2 then min_length = 2 end
    if #hand < min_length then return {} end
    local ranks = {}
    for _, v in ipairs(SMODS.Rank.obj_buffer) do ranks[v] = {} end
    for _, card in ipairs(hand) do
        local card_ranks = get_ranks(card)
        for _, rank in ipairs(card_ranks) do
            ranks[rank][#ranks[rank]+1] = card
        end
    end
    local function next_ranks(key, start)
        local rank = SMODS.Ranks[key]
        local ret = {}
        if not start and not wrap and rank.straight_edge then return ret end
        for _, v in ipairs(rank.next) do
            ret[#ret + 1] = v
            if skip and (wrap or not SMODS.Ranks[v].straight_edge) then
                for _, w in ipairs(SMODS.Ranks[v].next) do
                    ret[#ret + 1] = w
                end
            end
        end
        return ret
    end
    local tuples = {}
    local ret = {}
    for _, k in ipairs(SMODS.Rank.obj_buffer) do
        if next(ranks[k]) then
            tuples[#tuples + 1] = { k }
        end
    end
    for i = 2, #hand + 1 do
        local new_tuples = {}
        for _, tuple in ipairs(tuples) do
            local any_tuple
            if i ~= #hand + 1 then
                for _, l in ipairs(next_ranks(tuple[i-1], i == 2)) do
                    if next(ranks[l]) then
                        local new_tuple = {}
                        for _, v in ipairs(tuple) do new_tuple[#new_tuple + 1] = v end
                        new_tuple[#new_tuple+1] = l
                        new_tuples[#new_tuples+1] = new_tuple
                        any_tuple = true
                    end
                end
            end
            if i > min_length and not any_tuple then
                local straight = {}
                for _, v in ipairs(tuple) do
                    for _, card in ipairs(ranks[v]) do
                        straight[#straight+1] = card
                    end
                end
                ret[#ret+1] = straight
            end
        end
        tuples = new_tuples
    end
    table.sort(ret, function(a, b) return #a > #b end)
    return ret
end]]

local node_stop_drag_ref = Node.stop_drag
function Node:stop_drag()
    if G.hand then
        G.hand:parse_highlighted()
    end
    return node_stop_drag_ref(self)
end

--[[function Card:get_chip_bonus()
    if self.ability.extra_enhancement then return self.ability.bonus end

    if self.ability.effect == 'Stone Card' or self.config.center.replace_base_card then
        return self.ability.bonus + (self.ability.perma_bonus or 0)
    end
    return self.base.nominal + self.ability.bonus + (self.ability.perma_bonus or 0)
end]]

function Card:get_chip_mult()
    if self.ability.set == 'Joker' then return 0 end
    local ret = (not self.ability.extra_enhancement and self.ability.perma_mult) or 0

    if self.ability.effect == "Lucky Card" then
        if SMODS.pseudorandom_probability(self, 'lucky_mult', 1, 5) then
            self.lucky_trigger = true
            ret = ret + self.ability.mult
        end
    else
        ret = ret + self.ability.mult + self.base.mult
    end
    return ret
end

local get_straight_ref = get_straight
function get_straight(hand, min_length, skip, wrap)
    local ret = get_straight_ref(hand, min_length, skip, wrap)
    local seperate_ranks = {}
    for _, v in ipairs(hand) do
        local id = v:get_id()
        if id then
            seperate_ranks[id] = true
        end
    end
    if seperate_ranks[2] and seperate_ranks[13] then
        return
    end
    return ret
end
--- GLOBALS

function table.contains(table, element)
    if table and type(table) == "table" then
        for _, value in pairs(table) do
            if value == element then
                return true
            end
        end
        return false
    end
end

SMODS.current_mod.optional_features = {
    retrigger_joker = true,
    -- don't enable unless necessary
    post_trigger = true,
    --[[quantum_enhancements = true,
    cardareas = {
        discard = true,
        deck = true
    }]]--
}

function SMODS.current_mod.set_debuff(card)
    if card.edition and card.edition.rj_cool then
        return 'prevent_debuff'
    end
end

RansomJunk = {}
RansomJunk.chips_kept = 0
RansomJunk.lasers = {}

G.C.RJ = {
    RED = HEX("FF0000"),
    BLACK = HEX("000000"),
    BLUE = HEX("0000FF"),
    GREEN = HEX("00FF00"),
    WHITE = HEX("FFFFFF"),
    TRANSPARENT = HEX("00000000"),
    GREEN = HEX("44C448"),
    YELLOW = HEX("FFFD32"),
    GREY = HEX("7c7c7c"),
    THREE = HEX("F64F4C"),
    NINE = HEX("DDE2EC")
}

local loc_colour_ref = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        loc_colour_ref()
    end
    G.ARGS.LOC_COLOURS.rj_red = G.C.RJ.RED
    G.ARGS.LOC_COLOURS.rj_black = G.C.RJ.BLACK
    G.ARGS.LOC_COLOURS.rj_blue = G.C.RJ.BLUE
    G.ARGS.LOC_COLOURS.rj_green = G.C.RJ.GREEN
    G.ARGS.LOC_COLOURS.rj_white = G.C.RJ.WHITE
    G.ARGS.LOC_COLOURS.rj_transparent = G.C.RJ.TRANSPARENT
    G.ARGS.LOC_COLOURS.rj_green = G.C.RJ.GREEN
    G.ARGS.LOC_COLOURS.rj_yellow = G.C.RJ.YELLOW
    G.ARGS.LOC_COLOURS.rj_grey = G.C.RJ.GREY
    return loc_colour_ref(_c, _default)
end

G.FUNCS.cash_out = function(e)
    stop_use()
      if G.round_eval then  
        e.config.button = nil
        G.round_eval.alignment.offset.y = G.ROOM.T.y + 15
        G.round_eval.alignment.offset.x = 0
        G.deck:shuffle('cashout'..G.GAME.round_resets.ante)
        G.deck:hard_set_T()
        delay(0.3)
        G.E_MANAGER:add_event(Event({
          trigger = 'immediate',
          func = function()
              if G.round_eval then 
                G.round_eval:remove()
                G.round_eval = nil
              end
              G.GAME.current_round.jokers_purchased = 0
              G.GAME.current_round.discards_left = math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards)
              G.GAME.current_round.hands_left = (math.max(1, G.GAME.round_resets.hands + G.GAME.round_bonus.next_hands))
              G.STATE = G.STATES.SHOP
              G.GAME.shop_free = nil
              G.GAME.shop_d6ed = nil
              G.STATE_COMPLETE = false
            return true
          end
        }))
        ease_dollars(G.GAME.current_round.dollars)
        G.E_MANAGER:add_event(Event({
          func = function()
              G.GAME.previous_round.dollars = G.GAME.dollars
            return true
          end
        }))
        play_sound("coin7")
        G.VIBRATION = G.VIBRATION + 1
      end
      ease_chips(RansomJunk.chips_kept * G.GAME.chips)
      if G.GAME.round_resets.blind_states.Boss == 'Defeated' then 
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.ante
        G.GAME.round_resets.blind_tags.Small = get_next_tag_key()
        G.GAME.round_resets.blind_tags.Big = get_next_tag_key()
      end
      reset_blinds()
      delay(0.6)
end
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
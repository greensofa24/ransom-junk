SMODS.Atlas {
    key = "under_2",
    path = "r_under_2.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "hex_ranks",
    path = "r_hex.png",
    px = 71,
    py = 95
}

SMODS.Rank {
    key = "0",
    card_key = "0",
    pos = { x = 0 },
    nominal = 0,
    lc_atlas = "under_2",
    hc_atlas = "under_2",
    shorthand = "0",
    next = { "rj_1" },
    in_pool = function(self, args)
        if args and args.initial_deck then
            return true
        end
    end
}

SMODS.Rank {
    key = "1",
    card_key = "1",
    pos = { x = 1 },
    nominal = 1,
    lc_atlas = "under_2",
    hc_atlas = "under_2",
    shorthand = "1",
    next = { "2" },
    in_pool = function(self, args)
        if args and args.initial_deck then
            return true
        end
    end
}

SMODS.Rank:take_ownership("Ace", {
    straight_edge = false,
    next = { "2", "rj_B" },
    strength_effect = { fixed = 1 }
})

SMODS.Rank {
    key = "B",
    card_key = "B",
    pos = { x = 0 },
    nominal = 11,
    face_nominal = 0.5,
    chips_text = "B",
    mult = 1,
    lc_atlas = "hex_ranks",
    hc_atlas = "hex_ranks",
    shorthand = "B",
    next = { "rj_C" },
    in_pool = function(self, args)
        if args and args.initial_deck then
            return true
        end
    end
}

SMODS.Rank {
    key = "C",
    card_key = "C",
    pos = { x = 1 },
    nominal = 12,
    chips_text = "C",
    mult = 2,
    lc_atlas = "hex_ranks",
    hc_atlas = "hex_ranks",
    shorthand = "C",
    next = { "rj_D" },
    in_pool = function(self, args)
        if args and args.initial_deck then
            return true
        end
    end
}

SMODS.Rank {
    key = "D",
    card_key = "D",
    pos = { x = 2 },
    nominal = 13,
    chips_text = "D",
    mult = 3,
    lc_atlas = "hex_ranks",
    hc_atlas = "hex_ranks",
    shorthand = "D",
    next = { "rj_E" },
    in_pool = function(self, args)
        if args and args.initial_deck then
            return true
        end
    end
}

SMODS.Rank {
    key = "E",
    card_key = "E",
    pos = { x = 3 },
    nominal = 14,
    chips_text = "E",
    mult = 4,
    lc_atlas = "hex_ranks",
    hc_atlas = "hex_ranks",
    shorthand = "E",
    next = { "rj_F" },
    in_pool = function(self, args)
        if args and args.initial_deck then
            return true
        end
    end
}

SMODS.Rank {
    key = "F",
    card_key = "F",
    pos = { x = 4 },
    nominal = 15,
    chips_text = "F",
    mult = 5,
    lc_atlas = "hex_ranks",
    hc_atlas = "hex_ranks",
    shorthand = "F",
    next = { "10" },
    in_pool = function(self, args)
        if args and args.initial_deck then
            return true
        end
    end
}
SMODS.Atlas {
    key = "under_2",
    path = "r_under_2.png",
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
    next = { "1" },
    in_pool = function(self, args)
        if args and args.initial_deck then
            return false
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
            return false
        end
    end
}
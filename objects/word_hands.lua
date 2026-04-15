SMODS.PokerHandPart{
    key = "4_letter_word",
    func = function(hand)
        local valid_words = {
            "ACED",
            "BABE",
            "BACK",
            "BADE",
            "BAKE",
            "BEAD",
            "BEAK",
            "BECK",
            "BEEF",
            "CAFE",
            "CAKE",
            "CEDE",
            "DEAD",
            "DECK",
            "DEED",
            "EKED",
            "FACE",
            "FADE",
            "FAFF",
            "FAKE",
            "FEED",
            "JACK",
            "JADE",
            "KECK"
        }

        local string = ""

        table.sort(hand, function(a, b)
            return a.T.x < b.T.x
        end)

        for _, card in ipairs(hand) do
            string = string .. card.base.value:gsub("rj_", ""):sub(1, 1)
        end

        if table.contains(valid_words, string) then
            return { hand }
        end
    end
}

SMODS.PokerHand {
    key = "4-Letter Word",
    chips = 55,
    mult = 6,
    l_chips = 30,
    l_mult = 4,
    visible = true,
    example = {
        { "C_rj_B", true },
        { "H_A", true },
        { "D_rj_C", true },
        { "H_K", true }
    },
    loc_txt = {
        ["en-us"] = {
            name = "4-Letter Word",
            description = {
                "Exactly 4 cards where their ranks in order spell a word"
            }
        }
    },
    evaluate = function(parts, hand)
        return parts.rj_4_letter_word
    end
}

SMODS.PokerHandPart{
    key = "5_letter_word",
    func = function(hand)
        local valid_words = {
            "ABACK",
            "ABJAD",
            "ADDED",
            "BAKED",
            "CAKED",
            "CEDED",
            "DECAF",
            "EBBED",
            "EFFED",
            "FACED",
            "FADED",
            "FAKED",
            "JADED",
            "KEBAB"
        }

        local string = ""

        table.sort(hand, function(a, b)
            return a.T.x < b.T.x
        end)

        for _, card in ipairs(hand) do
            string = string .. card.base.value:gsub("rj_", ""):sub(1, 1)
        end

        if table.contains(valid_words, string) then
            return { hand }
        end
    end
}

SMODS.PokerHand {
    key = "5-Letter Word",
    chips = 55,
    mult = 6,
    l_chips = 30,
    l_mult = 4,
    visible = true,
    example = {
        { "S_A", true },
        { "D_rj_D", true },
        { "H_rj_D", true },
        { "S_rj_E", true },
        { "D_rj_D", true }
    },
    loc_txt = {
        ["en-us"] = {
            name = "5-Letter Word",
            description = {
                "Exactly 5 cards where their ranks in order spell a word"
            }
        }
    },
    evaluate = function(parts, hand)
        return parts.rj_5_letter_word
    end
}

SMODS.PokerHandPart{
    key = "6_letter_word",
    func = function(hand)
        local valid_words = {
            "ACCEDE",
            "BACKED",
            "BEADED",
            "BEAKED",
            "BECKED",
            "BEDDED",
            "BEDECK",
            "BEEFED",
            "CABBED",
            "DABBED",
            "DEBEAK",
            "DECADE",
            "DECKED",
            "DEEDED",
            "DEFACE",
            "EFFACE",
            "FACADE",
            "FAFFED",
            "JABBED",
            "JACKED",
            "KECKED"
        }

        local string = ""

        table.sort(hand, function(a, b)
            return a.T.x < b.T.x
        end)

        for _, card in ipairs(hand) do
            string = string .. card.base.value:gsub("rj_", ""):sub(1, 1)
        end

        if table.contains(valid_words, string) then
            return { hand }
        end
    end
}

SMODS.PokerHand {
    key = "6-Letter Word",
    chips = 55,
    mult = 6,
    l_chips = 30,
    l_mult = 4,
    visible = true,
    example = {
        { "S_rj_D", true },
        { "C_rj_E", true },
        { "D_rj_C", true },
        { "H_A", true },
        { "S_rj_D", true },
        { "C_rj_E", true }
    },
    loc_txt = {
        ["en-us"] = {
            name = "6-Letter Word",
            description = {
                "Exactly 6 cards where their ranks in order spell a word"
            }
        }
    },
    evaluate = function(parts, hand)
        return parts.rj_6_letter_word
    end
}
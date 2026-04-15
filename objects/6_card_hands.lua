SMODS.PokerHand {
    key = "Three Pair",
    chips = 55,
    mult = 6,
    l_chips = 30,
    l_mult = 4,
    visible = true,
    example = {
        { "H_K", true },
        { "D_K", true },
        { "C_4", true },
        { "H_4", true },
        { "C_2", true },
        { "D_2", true },
    },
    loc_txt = {
        ["en-us"] = {
            name = "Three Pair",
            description = {
                "3 Pairs",
            }
        }
    },
    evaluate = function(parts, hand)
        if #parts._2 < 3 then return {} end
        return parts._all_pairs
    end,
}

SMODS.PokerHand {
    key = "Long Straight",
    chips = 40,
    mult = 6,
    l_chips = 40,
    l_mult = 6,
    visible = true,
    example = {
        { "D_J", true },
        { "C_T", true },
        { "C_9", true },
        { "S_8", true },
        { "H_7", true },
        { "H_6", true },
    },
    loc_txt = {
        ["en-us"] = {
            name = "Long Straight",
            description = {
                "6 cards in a row",
            }
        }
    },
    evaluate = function(parts, hand)
        if #parts._straight < 2 then return {} end
        return parts._straight
    end,
}

SMODS.PokerHandPart{
    key = "full_flush",
    func = function(hand)
        if #hand < 6 then 
            return {} 
        end

        local first_card = hand[1]
        local suit = nil

        if first_card:is_suit("Hearts") then suit = "Hearts" end
        if first_card:is_suit("Spades") then suit = "Spades" end
        if first_card:is_suit("Clubs") then suit = "Clubs" end
        if first_card:is_suit("Diamonds") then suit = "Diamonds" end

        local matching_cards = {}

        for _, card in ipairs(hand) do
            if card:is_suit(suit) then
                table.insert(matching_cards, card)
            else
                break
            end
        end

        if #matching_cards == 6 then
            return { matching_cards }
        end

        return {}
    end
}

SMODS.PokerHand {
    key = "Full Flush",
    chips = 50,
    mult = 7,
    l_chips = 25,
    l_mult = 4,
    visible = true,
    example = {
        { "H_A", true },
        { "H_K", true },
        { "H_T", true },
        { "H_5", true },
        { "H_4", true },
        { "H_2", true },
    },
    loc_txt = {
        ["en-us"] = {
            name = "Full Flush",
            description = {
                "6 cards that share the same suit",
            }
        }
    },
    evaluate = function(parts, hand)
        return parts.rj_full_flush
    end
}

SMODS.PokerHand {
    key = "House Party",
    chips = 80,
    mult = 11,
    l_chips = 45,
    l_mult = 6,
    visible = true,
    example = {
        { "S_J", true },
        { "H_J", true },
        { "C_J", true },
        { "D_J", true },
        { "C_9", true },
        { "H_9", true },
    },
    loc_txt = {
        ["en-us"] = {
            name = "House Party",
            description = {
                "A Four of a Kind and a Pair",
            }
        }
    },
    evaluate = function(parts, hand)
        if #parts._4 < 1 or #parts._2 < 2 then return {} end
        return parts._all_pairs
    end
}

SMODS.PokerHand {
    key = "Double Triple",
    chips = 65,
    mult = 7,
    l_chips = 40,
    l_mult = 5,
    visible = true,
    example = {
        { "S_K", true },
        { "H_K", true },
        { "C_K", true },
        { "D_2", true },
        { "S_2", true },
        { "H_2", true },
    },
    loc_txt = {
        ["en-us"] = {
            name = "Double Triple",
            description = {
                "Two Three of a Kinds",
            }
        }
    },
    evaluate = function(parts, hand)
        if #parts._3 < 2 then return {} end
        return parts._all_pairs
    end
}

SMODS.PokerHand {
    key = "Imperial Flush",
    chips = 160,
    mult = 14,
    l_chips = 70,
    l_mult = 9,
    visible = true,
    example = {
        { "S_Q", true },
        { "S_J", true },
        { "S_T", true },
        { "S_9", true },
        { "S_8", true },
        { "S_7", true },
    },
    loc_txt = {
        ["en-us"] = {
            name = "Imperial Flush",
            description = {
                "6 cards in a row with",
                "all cards sharing the same suit"
            }
        }
    },
    evaluate = function(parts, hand)
        if #parts._straight < 2 then return {} end
        return parts.rj_full_flush
    end,
    modify_display_text = function(self, cards, scoring_hand)
        local royal = true
        for j = 1, #scoring_hand do
            local rank = SMODS.Ranks[scoring_hand[j].base.value]
            royal = royal and (rank.key == "Ace" or rank.key == "10" or rank.key == "9" or rank.face)
        end
        if royal then
            return "God Flush"
        end
    end
}

SMODS.PokerHand {
    key = "Six of a Kind",
    chips = 180,
    mult = 17,
    l_chips = 55,
    l_mult = 6,
    visible = true,
    example = {
        { "S_A", true },
        { "H_A", true },
        { "H_A", true },
        { "C_A", true },
        { "D_A", true },
        { "D_A", true },
    },
    loc_txt = {
        ["en-us"] = {
            name = "Six of a Kind",
            description = {
                "6 cards with the same rank",
            }
        }
    },
    evaluate = function(parts, hand)
        return get_X_same(6, hand, true)
    end
}

SMODS.PokerHand {
    key = "Paired Flush",
    chips = 100,
    mult = 9,
    l_chips = 50,
    l_mult = 3,
    visible = true,
    example = {
        { "D_K", true },
        { "D_K", true },
        { "D_K", true },
        { "D_2", true },
        { "D_2", true },
        { "D_2", true },
    },
    loc_txt = {
        ["en-us"] = {
            name = "Paired Flush",
            description = {
                "3 Pairs that share the same suit",
            }
        }
    },
    evaluate = function(parts, hand)
        if #parts._2 < 3 then return {} end
        return parts.rj_full_flush
    end,
}

SMODS.PokerHand {
    key = "Business Meeting",
    chips = 180,
    mult = 21,
    l_chips = 60,
    l_mult = 5,
    visible = true,
    example = {
        { "C_Q", true },
        { "C_Q", true },
        { "C_Q", true },
        { "C_Q", true },
        { "C_3", true },
        { "C_3", true },
    },
    loc_txt = {
        ["en-us"] = {
            name = "Business Meeting",
            description = {
                "A Four of a Kind and a Pair that share the same suit",
            }
        }
    },
    evaluate = function(parts, hand)
        if #parts._4 < 1 or #parts._2 < 2 then return {} end
        return parts.rj_full_flush
    end
}

SMODS.PokerHand {
    key = "Twinned Flush",
    chips = 165,
    mult = 18,
    l_chips = 70,
    l_mult = 6,
    visible = true,
    example = {
        { "H_K", true },
        { "H_K", true },
        { "H_K", true },
        { "H_2", true },
        { "H_2", true },
        { "H_2", true },
    },
    loc_txt = {
        ["en-us"] = {
            name = "Twinned Flush",
            description = {
                "Two Three of a Kinds that share the same suit",
            }
        }
    },
    evaluate = function(parts, hand)
        if #parts._3 < 2 then return {} end
        return parts.rj_full_flush
    end
}

SMODS.PokerHand {
    key = "Flush Six",
    chips = 270,
    mult = 23,
    l_chips = 80,
    l_mult = 8,
    visible = true,
    example = {
        { "D_A", true },
        { "D_A", true },
        { "D_A", true },
        { "D_A", true },
        { "D_A", true },
        { "D_A", true },
    },
    loc_txt = {
        ["en-us"] = {
            name = "Flush Six",
            description = {
                "6 cards with the same rank and suit",
            }
        }
    },
    evaluate = function(parts, hand)
        if #parts.rj_full_flush < 1 then return {} end
        return get_X_same(6, hand, true)
    end
}
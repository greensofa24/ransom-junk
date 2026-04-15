return {
    descriptions = {
        Back = {
            b_rj_j_test = {
				name = "Joker Testing Deck",
                text = {
                    "Start with a #1# and a #2#"
                }
			},
            b_rj_j_test_2 = {
				name = "Joker Testing Deck 2",
                text = {
                    "Start with a #1# and a #2#"
                }
			},
            b_rj_j_test_3 = {
				name = "Joker Testing Deck 3",
                text = {
                    "Start with a #1# and a #2#"
                }
			},
            b_rj_demoted = {
				name = "Demoted Deck",
                text = {
                    "Start with a #1# and a #2#"
                }
			},
            b_rj_op = {
				name = "OP Deck",
                text = {
                    "Start with a #1# and a #2#"
                }
			},
            b_rj_stickered = {
				name = "Stickered Deck",
                text = {
                    "Each suit has its",
                    "respectively colored",
                    "sticker"
                }
			},
            b_rj_joker = {
                name = "Joker Deck",
                text = {
                    "Start with a #1# and a #2#"
                }
            }
		},
        Edition = {
            e_rj_cool = {
                name = "Cool",
                text = {
                    "Cannot be flipped, debuffed,",
                    "force-discarded, force-selected,",
                    "force-deselected, or cursed and",
                    "Decreases blind requirement",
                    "by 1/9 when scored"
                }
            }
        },
        Joker = {
            j_rj_one = {
                name = "One",
                text = {
                    {
                        "If 1st played hand of round contains",
                        "at least 1 scoring card with rank 4,",
                        "destroy all cards in played hand",
                        "and add a {C:dark_edition}Negative{} 1 of {C:clubs}Clubs{} to hand",
                        "for every scored card with rank 4"
                    }
                }
            },
            j_rj_two = {
                name = "Two",
                text = {
                    {
                        "{X:black,C:mult}^2^(1/2){} Mult before other jokers score"
                    }
                }
            },
            j_rj_three = {
                name = "Three",
                text = {
                    {
                        "Triggers {X:mult,C:white}XMult{} for each card played",
                        "{X:mult,C:white}X1.03{} to {X:mult,C:white}XMult{} for each card destroyed",
                        "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                    }
                }
            },
            j_rj_four = {
                name = "Four",
                text = {
                    {
                        "{X:mult,C:white}X#1#{} Mult if hand contains exactly 4 cards",
                        "{X:mult,C:white}X4^(1/4){} Mult for each scored 4"
                    }
                }
            },
            j_rj_six = {
                name = "Six",
                text = {
                    {
                        "Allows you to select 6 cards"
                    }
                }
            },
            j_rj_eight = {
                name = "Eight",
                text = {
                    {
                        "Gains 1 use per round",
                        "When used, has an {C:green}(1/8)^(1/8){}",
                        "chance of creating 3 Temporary copies",
                        "of a selected playing card"
                    }
                }
            },
            j_rj_nine = {
                name = "Nine",
                text = {
                    {
                        "Every 9th scored card",
                        "becomes cool"
                    }
                }
            },
            j_rj_x = {
                name = "X",
                text = {
                    {
                        "{X:mult,C:white}X#1#-#2#{} Mult for each {X:mult,C:white}XMult{} trigger",
                        "Maximum of #3# triggers per hand played"
                    }
                }
            },
            j_rj_chipped_tooth = {
                name = "Chipped Tooth",
                text = {
                    {
                        "{C:chips}+#1#{} Chip"
                    }
                }
            },
            j_rj_annoying_fly = {
                name = "Annoying Fly",
                text = {
                    {
                        "{C:green}1 in 111{} chance to give {C:mult}+#1#{} Mult"
                    }
                }
            },
            j_rj_garbage_dealer = {
                name = "Garbage Dealer",
                text = {
                    {
                        "Gives {X:mult,C:white}X2{} Mult for each {C:rj_grey}Junk{} joker you currently have,",
                        "starting at {X:mult,C:white}X0{}"
                    }
                }
            },
            j_rj_oops_all_1s = {
                name = "Oops! All 1s",
                text = {
                    "Halves all {C:attention}listed",
                    "{C:green,E:1,S:1.1}probabilities",
                    "{C:inactive}(ex: {C:green}2 in 3{C:inactive} -> {C:green}1 in 3{C:inactive})",
                }
            },
            j_rj_joker_joker = {
                name = "Joker Joker",
                text = {
                    "{X:mult,C:white}X#1#{} Mult"
                }
            },
            j_rj_joker_joker_joker = {
                name = "Joker Joker Joker",
                text = {
                    "{X:black,C:mult}^#1#{} Mult"
                }
            },
            ["j_rj_joker^4"] = {
                name = "Joker^4",
                text = {
                    "{X:mult,C:black}^^#1#{} Mult"
                }
            },
            ["j_rj_joker^5"] = {
                name = "Joker^5",
                text = {
                    "{X:dark_edition,C:mult}^^^#1#{} Mult"
                }
            },
            ["j_rj_joker^x"] = {
                name = "Joker^x",
                text = {
                    "{X:mult,C:dark_edition}#1# #2#{} Mult",
                    "Hyperoperator is increased by 1 each trigger"
                }
            },
            ["j_rj_joker^x^x"] = {
                name = "Joker^x^x",
                text = {
                    "{X:mult,C:dark_edition}#1# #2#{} Mult",
                    "Hyperoperator is equal to 2n-1 choose n",
                    "n is increased by 1 each trigger",
                    "{C:inactive}(Currently n = #3#)"
                }
            },
            j_rj_repeat = {
                name = "Repeat",
                text = {
                    "Triggers every joker",
                    "to the left of itself that",
                    "scores in the main scoring phase"
                }
            },
            j_rj_lineage = {
                name = "The Lineage",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if played",
                    "hand contains",
                    "a {C:attention}#2#",
                },
                unlock = {
                    "Win a run",
                    "having played",
                    "{E:1,C:attention}#1#",
                    "exactly 5 times"
                }
            }
        },
        Other = {
            card_mult = {
                text = {
                    "{C:mult}+#1#{} mult"
                }
            },
            rj_double_red_seal = {
                name = "Red Sealed Red Seal",
                text = {
                    "Retrigger this",
                    "card {C:attention}1{} time, then",
                    "retrigger that",
                    "retrigger {C:attention}1{} time"
                }
            },
            rj_temporary = {
                name = "Temporary",
                text = {
                    "Destroyed at the",
                    "end of the round"
                }
            },
            rj_locked = {
                name = "Locked",
                text = {
                    "Cannot be discarded"
                }
            },
            rj_hazardous = {
                name = "Hazardous",
                text = {
                    "Takes up 1 extra slot"
                }
            }
        },
        Tag = {
            tag_rj_sleeved_juggle = {
                name = "Sleeved Juggle Tag",
                text = {
                    "description"
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_rj_junk = "Junk",
            k_rj_garbage = "Garbage"
        },
        labels = {
            k_rj_junk = "Junk",
            k_rj_garbage = "Garbage",
            rj_double_red_seal = "Red Sealed Red Seal",
            rj_cool = "Cool",
            rj_temporary = "Temporary",
            rj_locked = "Locked",
            rj_hazardous = "Hazardous"
        },
        poker_hands = {
        },
        poker_hand_descriptions = {
        },
        ranks = {
            rj_0 = "0",
            rj_1 = "1",
            rj_B = "B",
            rj_C = "C",
            rj_D = "D",
            rj_E = "E",
            rj_F = "F"
        }
    }
}
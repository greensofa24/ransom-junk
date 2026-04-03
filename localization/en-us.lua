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
                        "{X:dark_edition,C:mult}^2^(1/2){} Mult before other jokers score"
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
            }
        },
        Other = {
            rj_double_red_seal = {
                name = "Red Sealed Red Seal",
                text = {
                    "Retrigger this",
                    "card {C:attention}1{} time, then",
                    "retrigger that",
                    "retrigger {C:attention}1{} time"
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
        },
        poker_hands = {
        },
        poker_hand_descriptions = {
        },
        ranks = {
            rj_0 = "0",
            rj_1 = "1"
        }
    }
}
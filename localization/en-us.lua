return {
    descriptions = {
        Back = {
            b_rj_j_test = {
				name = "Joker Testing Deck",
                text = {
                    "Start with a #1# and a #2#"
                }
			}
		},
        Joker = {
            j_rj_two = {
                name = "Two",
                text = {
                    {
                        "^2^(1/2) Mult before other jokers score",
                        "if played hand contains a 2 of a Kind",
                        "with rank divisible by 2"
                    }
                }
            },
            j_rj_four = {
                name = "Four",
                text = {
                    {
                        "{X:spectral,C:white}X#1#{} Mult if hand contains exactly {C:spectral}4{} cards",
                        "{X:spectral,C:white}X4^(1/4){} Mult for each scored {C:spectral}4{}",
                        --"Decreases the level of all poker hands except Four of a Kind by {C:spectral}4{}"
                    }
                }
            },
            j_rj_six = {
                name = "Six",
                text = {
                    {
                        "Allows you to select {C:chips}6{} cards"
                    }
                }
            },
            j_rj_x = {
                name = "X",
                text = {
                    {
                        "{X:rj_yellow,C:white}X#1#-#2#{} Mult for each XMult trigger",
                        "Maximum of #3# triggers per hand played"
                    }
                }
            }
        }
    },
    misc = {
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
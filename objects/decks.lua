SMODS.Back{
    name = "Joker Testing Deck",
    key = "j_test",
    pos = { x = 0, y = 0 },
    config = { jokers = { "j_rj_one", "j_rj_two", "j_rj_three", "j_rj_four", "j_rj_six", "j_rj_x" }, consumables = { "c_aura", "c_aura", "c_strength", "c_chariot", "c_sigil", "c_hanged_man" } },
    apply = function(self, back)
        --[[G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == "Hearts" or v.base.suit == "Diamonds" then
                        v:change_suit('Spades')
                    end
                end
                return true
            end
        }))]]
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = self.config.jokers }
    end
}

SMODS.Back{
    name = "Joker Testing Deck 2",
    key = "j_test_2",
    pos = { x = 0, y = 0 },
    config = { jokers = { "j_rj_chipped_tooth", "j_rj_annoying_fly", "j_rj_garbage_dealer" } },
    apply = function(self, back)
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = self.config.jokers }
    end
}

SMODS.Back{
    name = "Demoted Deck",
    key = "demoted",
    pos = { x = 0, y = 0 },
    config = { jokers = { "j_8_ball", "j_delayed_grat", "j_faceless", "j_superposition", "j_matador", "j_seance", "j_pareidolia", "j_hit_the_road" } },
    apply = function(self, back)
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = self.config.jokers }
    end
}
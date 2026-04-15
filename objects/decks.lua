SMODS.Back{
    name = "Joker Testing Deck",
    key = "j_test",
    pos = { x = 0, y = 0 },
    config = { jokers = { "j_rj_one", "j_rj_two", "j_rj_three", "j_rj_four", "j_rj_five", "j_rj_six", "j_rj_eight", "j_rj_nine", "j_rj_x" }, consumables = { "c_aura", "c_aura", "c_strength", "c_chariot", "c_justice", "c_sigil", "c_hanged_man", "c_rj_insomnia" } },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == "Hearts" then
                        v:add_sticker("rj_hazardous", true)
                    end
                end
                return true
            end
        }))
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
    name = "Joker Testing Deck 3",
    key = "j_test_3",
    pos = { x = 0, y = 0 },
    config = { jokers = { "j_rj_floating_point", "j_fibonacci", "j_rj_six" }, consumables = { "c_hex", "c_strength", "c_strength", "c_strength", "c_strength", "c_strength", "c_strength", "c_strength" } },
    apply = function(self, back)
        --[[G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == "Hearts" then
                        v:set_ability("m_wild")
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

SMODS.Back{
    name = "OP Deck",
    key = "op",
    pos = { x = 0, y = 0 },
    config = { jokers = { "j_rj_one", "j_rj_three", "j_rj_six", "j_blueprint", "j_brainstorm" }, consumables = { "c_strength", "c_strength", "c_hanged_man", "c_hanged_man", "c_deja_vu", "c_deja_vu", "c_deja_vu", "c_deja_vu", "c_deja_vu", "c_deja_vu" } },
    apply = function(self, back)
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = self.config.jokers }
    end
}

SMODS.Back{
    name = "Stickered Deck",
    key = "stickered",
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == "Hearts" then
                        v:add_sticker("eternal", true)
                    elseif v.base.suit == "Clubs" then
                        v:add_sticker("perishable", true)
                    elseif v.base.suit == "Diamonds" then
                        v:add_sticker("rental", true)
                    elseif v.base.suit == "Spades" then
                        v:add_sticker("rj_temporary", true)
                    end
                end
                return true
            end
        }))
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = self.config.jokers }
    end
}

SMODS.Back{
    name = "Joker Deck",
    key = "joker",
    pos = { x = 0, y = 0 },
    config = { jokers = { "j_joker", "j_rj_joker_joker", "j_rj_joker_joker_joker", "j_rj_joker^4", "j_rj_joker^x", "j_rj_joker^x^x" } },
    apply = function(self, back)
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = self.config.jokers }
    end
}

SMODS.Back{
    name = "Joker Testing Deck 4",
    key = "j_test_4",
    pos = { x = 0, y = 0 },
    config = { jokers = { "j_rj_lineage", "j_rj_lua", "j_rj_repeat", "j_rj_repeat", "j_rj_repeat" }, consumables = { "c_strength", "c_chariot" } },
    apply = function(self, back)
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = self.config.jokers }
    end
}
SMODS.Tag{
    key = "sleeved_boss",
    config = { new_blind_choice = false },
    apply = function(self, tag, context)
        if context.type == "new_blind_choice" then
            tag.config.new_blind_choice = true
        else
            tag.config.new_blind_choice = false
        end
    end,
    click = function(self, tag)
        if tag.config.new_blind_choice and G.STATE ~= G.STATES.SHOP then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep("+", G.C.GREEN, function()
                G.from_boss_tag = true
                G.FUNCS.reroll_boss()

                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.CONTROLLER.locks[lock] = nil
                                return true
                            end
                        }))
                        return true
                    end
                }))

                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

SMODS.Tag{
    key = "sleeved_juggle",
    config = { h_size = 3 },
    click = function(self, tag)
        if G.GAME.blind and G.GAME.blind.in_blind then
            G.hand:change_size(1)
            tag.config.h_size = tag.config.h_size - 1
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + 1
            tag:juice_up()
        end
        if tag.config.h_size <= 0 then
            tag:yep("+", G.C.BLUE, function()
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

local tag_ui = Tag.generate_UI
function Tag:generate_UI(_size)
    local tag_sprite_tab, tag_sprite = tag_ui(self, _size)
    local obj = SMODS.Tags[self.key]
    if obj and obj.click and type(obj.click) == "function" then
        tag_sprite.click = function(tag_sprite_self)
            obj:click(self)
        end
    end
    return tag_sprite_tab, tag_sprite
end
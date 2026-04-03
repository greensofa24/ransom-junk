local function create_my_button_ui(card)
    local center = card.config.center
    local can_use = true

    if center.can_use then
        can_use = center:can_use(card)
    end

  return UIBox {
    definition = {
      n = G.UIT.ROOT,
      config = {
        colour = G.C.CLEAR
      },
      nodes = {
        {
          n = G.UIT.C,
          config = {
            align = "cm",
            padding = 0.1,
            r = 0.08,
            hover = false,
            shadow = true,
            colour = G.C.UI.PURPLE,
            button = "rj_use_click",
            ref_table = card
          },
          nodes = {
            {
              n = G.UIT.R,
              nodes = {
                {
                  n = G.UIT.B,
                  config = {
                    w = 0.22,
                    h = 0
                  }
                },
                {
                  n = G.UIT.T,
                  config = {
                    text = "Use",
                    colour = G.C.UI.TEXT_LIGHT,
                    scale = 0.35
                  }
                },
                {
                  n = G.UIT.B,
                  config = {
                    w = 0.11,
                    h = 0
                  }
                }
              }
            }
          }
        }
      }
    },
    config = {
      align = "cr",
      major = card,
      parent = card,
      offset = { x = -0.2, y = 0.75 }
    }
  }
end

G.FUNCS.rj_use_click = function(e)
    local card = e.config.ref_table
    local center = card.config.center
    --[[local can_use = true

    if center.can_use then
        can_use = center:can_use(card)
    end]]

    if card.ability.extra.uses then
        card.ability.extra.uses = card.ability.extra.uses - 1
    end

    local result = center:use(card)
    if result then
        SMODS.calculate_effect(result, card)
    end
end

SMODS.DrawStep {
    key = "use",
    order = -30,
    func = function(card, layer)
        local btn_ui = card.children.rj_use
        if not btn_ui then return end

        local center = card.config.center
        local can_use = true
        if center.can_use then
            can_use = center:can_use(card)
        end

        local btn_container = btn_ui.definition.nodes[1].config
        btn_container.hover = can_use
        btn_container.button = can_use and "rj_use_click" or nil
        btn_container.colour = can_use and G.C.PURPLE or G.C.UI.BACKGROUND_INACTIVE

        local text_node = btn_ui.definition.nodes[1].nodes[1].nodes[2].config
        text_node.colour = can_use and G.C.UI.TEXT_LIGHT or G.C.UI.TEXT_DARK

        btn_ui:draw()
    end
}

SMODS.draw_ignore_keys.rj_use = true

local highlight_ref = Card.highlight
    function Card.highlight(self, is_highlighted)
        local jokers = { "j_rj_eight" }
        if is_highlighted and self.area == G.jokers and table.contains(jokers, self.config.center.key) then
            self.children.rj_use = create_my_button_ui(self)
        elseif self.children.rj_use then
            self.children.rj_use:remove()
            self.children.rj_use = nil
        end

    return highlight_ref(self, is_highlighted)
end
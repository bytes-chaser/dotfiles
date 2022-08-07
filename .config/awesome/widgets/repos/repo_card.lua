local wibox       = require("wibox")
local beautiful   = require("beautiful")
local dpi         = beautiful.xresources.apply_dpi
local shape_utils = require("commons.shape")
local icons       = require("commons.icons")

return {
  create = function(repo_info, url, source_icon)

    local icon = icons.wbi(repo_info.icon, 16)

    local name = {
      id = "name",
      widget = wibox.widget.textbox,
      markup   = "<span foreground='" .. beautiful.fg_focus .."'>" .. repo_info.name .."</span>",
      font = beautiful.font_famaly .. '12',
    }

    local path = {
      id = "path",
      widget = wibox.widget.textbox,
      markup   = "<span foreground='" .. beautiful.fg_normal .."'>" .. repo_info.path .."</span>",
      font = beautiful.font_famaly .. '10',
    }

    local source_icon_widget = icons.wbi(source_icon, 14)

    local remote_addr = {
      id = "remote",
      wrap = 'word_char',
      widget = wibox.widget.textbox,
      markup   = "<span foreground='" .. beautiful.fg_normal .."'>" .. url .."</span>",
      font = beautiful.font_famaly .. '10',
    }


    function horizontal_scroll(w)
      return wibox.widget {
         layout = wibox.container.scroll.horizontal,
         max_size = 100,
         step_function = wibox.container.scroll.step_functions
                         .nonlinear_back_and_forth,
         speed = 100,
         w,
      }
    end

    function left_margin(w)
      return {
        w,
        widget = wibox.container.margin,
        left   = dpi(20)
      }
    end


    return {
      {
        {
          {
            {
              icon,
              left_margin(name),
              nil,
              layout = wibox.layout.align.horizontal
            },
            {
              icons.wbi("", 14),
              left_margin(horizontal_scroll(path)),
              layout = wibox.layout.align.horizontal
            },
            {
              source_icon_widget,
              left_margin(horizontal_scroll(remote_addr)),
              layout = wibox.layout.align.horizontal
            },
            layout = wibox.layout.flex.vertical
          },
          widget = wibox.container.margin,
          margins = dpi(10)
        },
        layout = require("dependencies.overflow").vertical,
        spacing = dpi(5),
        scrollbar_widget = {
          widget = wibox.widget.separator,
          shape = shape_utils.partially_rounded_rect(beautiful.rounded, true, true, true, true),
        },
        scrollbar_width = dpi(8),
        step = 50,
      },
      widget = wibox.container.background,
      bg = beautiful.palette_c7,
    }
  end
}
local awful       = require("awful")

local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi
local gears     = require("gears")
local shape_utils = require("commons.shape")
local commands = require("commons.commands")
local profile = require("widgets.profile")
local player = require("widgets.player")
local slider_factory = require("widgets.control_slider")
local monitor_panel = require("widgets.monitor_panel")
local sliders_set = require("widgets.sliders_set")
local awful = require("awful")

local dashboard = wibox(
{
    visible = true,
    ontop = false,
    height = dpi(800),
    width = dpi(1300),
    bg = beautiful.bg_normal,
    type = "dashboard",
    border_width = dpi(4),
    border_color = beautiful.border_focus,
    shape =  shape_utils.partially_rounded_rect(beautiful.rounded, true, true, true, true),
    screen = screen.primary,
})


local function create_card(content)
  return wibox.widget{
    {
      {
        content,
        widget = wibox.container.margin,
        margins = dpi(15),
      },
      widget = wibox.container.background,
      bg = beautiful.palette_c6,
    },
    widget = wibox.container.margin,
    margins = dpi(10),
  }
end
dashboard:setup {
  {
    layout = wibox.layout.flex.vertical,
    create_card(profile),
    create_card(sliders_set)
  },
  {
    layout = wibox.layout.flex.vertical,
    create_card(player),
    create_card(monitor_panel)
  },
  layout = wibox.layout.flex.horizontal
}
awful.placement.centered(dashboard, {honor_workarea=true})
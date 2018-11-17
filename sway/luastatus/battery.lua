local common = require "common"

local show_rem_time = false
local discharging_color = common.colors.normal.yellow
local charging_color = common.colors.normal.magenta
local full_color = charging_color

local critical = 10

widget = luastatus.require_plugin('battery-linux').widget{
    est_rem_time = true,
    timer_opts = {period = 2},
    cb = function(t)
        local symbol = ({
            Charging    = '↑',
            Discharging = '↓',
        })[t.status] or ' '
        local rem_seg
        local color = ({
            Charging    = charging_color,
            Discharging = discharging_color,
        })[t.status] or full_color
        local rem_h = -1
        local rem_m = -1
        if t.rem_time then
            rem_h = math.floor(t.rem_time)
            rem_m = math.floor(60 * (t.rem_time - rem_h))
            if show_rem_time then
                rem_seg = {full_text = string.format('%2dh %02dm', rem_h, rem_m), color = color}
            end
        end
        if tonumber(t.capacity) <= critical then
            color = common.colors.normal.red
            common.notify('battery', string.format('%s%% (%2dh%02dm) of battery remaining', t.capacity, rem_h, rem_m), common.notify_level_critical, 2000)
        end
        return {
            {full_text = string.format('BAT:[%s%3s]', symbol, t.capacity), color = color},
            rem_seg,
        }
    end,

    event = function(t)
        if t.button == 1 then -- left
            show_rem_time = not show_rem_time
        end
    end,
}

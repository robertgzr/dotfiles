local common = require "common"

local rem_time = {rem_h = 0, rem_m = 0}
local discharging_color = common.colors.normal.yellow
local charging_color = common.colors.normal.magenta
local full_color = charging_color

local full = 95
local critical = 10

widget = luastatus.require_plugin('battery-linux').widget{
    est_rem_time = true,
    timer_opts = {period = 2},
    cb = function(t)
        local symbol = ({
            Charging    = '',
            Discharging = '',
        })[t.status] or ' '
        local rem_seg
        local color = ({
            Charging    = charging_color,
            Discharging = discharging_color,
        })[t.status] or full_color
        if t.rem_time then
            local rem_h = math.floor(t.rem_time)
            local rem_m = math.floor(60 * (t.rem_time - rem_h))
            rem_time = {rem_h = rem_h, rem_m = rem_m}
        end
        common.dump(rem_time)
        if tonumber(t.capacity) >= full then
            symbol = ''
        end
        -- warn on low power
        if tonumber(t.capacity) <= critical then
            color = common.colors.normal.red
            symbol = ''
        end
        local res = {}
        common.fmt(res, symbol, string.format('%3s', t.capacity), color)
        return res
    end,

    event = function(t)
        if t.button == 1 then -- left
            common.notify('battery', string.format('%dh %02dm remaining', rem_time.rem_h, rem_time.rem_m))
        end
    end,
}

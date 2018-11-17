local common = require "common"

local PERIOD = 3
local wifi_on = true
local last_connection = ''

widget = {
    plugin = 'timer',
    opts = {period = PERIOD},

    cb = function()
        local res = {}

        local o = common.execute_output('nmcli -t --fields IN-USE,SSID,SIGNAL device wifi list | grep "^*"')
        local net = {len = 0}
        for f in (o .. ':'):gmatch('([^:]+):') do
            table.insert(net, f)
            net.len = net.len + 1
        end
        if net.len >= 3 then
            if not last_connection == net[2] then
                common.notify('wifi', string.format('connected to %s', net[2]), common.notify_level_normal)
                last_connection = net[2]
            end
            table.insert(res, {
                    full_text = string.format('WiFi:[%s %3s]', net[2], net[3]),
                    color = common.colors.normal.green,
            })
        else
            table.insert(res, {
                    full_text = 'WiFi:[off]',
                    color = common.colors.normal.green,
            })
        end
        return res
    end,

    event = function(t)
        if t.button == 1 then -- left
            os.execute('zsh -c "alacritty --class nmcli -e nmcli device wifi list &!"')
        elseif t.button == 2 then -- middle
            -- TODO do a rescan of networks, launch rofi with available networks, choose one, connect
        elseif t.button == 3 then -- right
            wifi_on = not wifi_on
            if wifi_on then state = 'on' else state = 'off' end
            assert(os.execute(string.format('nmcli radio wifi %s', state)))
        end
    end,
}

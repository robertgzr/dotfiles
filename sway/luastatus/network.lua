local common = require "common"

local WIFI_COLOR = common.colors.normal.green
local WIRED_COLOR = common.colors.normal.white
local VPN_COLOR = common.colors.normal.white

local NM_SD ='org.freedesktop.NetworkManager'
local NM_OP ='/org/freedesktop/NetworkManager'
local NM_IF ='org.freedesktop.NetworkManager'

local wifi = {
    ready = false,
    connected = false,
    ssid = '-',
    strength = -1,
    bitrate = -1.0,
    issue = nil,
}
local wired = {
    connected = false,
}
local vpn = {
    connected = false,
    banner = '-'
}

local wifi_on = true

local function nmcli_parse()
    local o = common.execute_output('nmcli -t -f TYPE,STATE,CONNECTION device', true)
    for line in o:gmatch("[^\n]+") do
        local net = {len = 0}
        for f in line:gmatch('([^:]+)') do
            table.insert(net, f)
            net.len = net.len + 1
        end
        if net[1] == 'wifi' then
            if not (net[2] == 'unavailable') then wifi.ready = true end
            if net[2] == 'connected' then wifi.connected = true end
            if net[3] then wifi.ssid = net[3] end
        elseif net[1] == 'ethernet' then
            if net[2] == 'connected' then wired.connected = true end
        end
    end
end

local function mk_wifi()
    local res = {}
    if wifi.ready then
        local txt = ''
        if not wifi.connected then 
            txt = '***'
        else
            txt = string.format('%s %3d', wifi.ssid, wifi.strength)
        end
        res = {
            full_text = 'WiFi[' .. txt .. ']',
            color = WIFI_COLOR,
        }
    else
        res = {
            full_text = 'WiFi[x]',
            color = WIFI_COLOR,
        }
    end
    return res
end
local function mk_wired()
    local res = {}
    if wired.connected then
        res = {
            full_text = string.format('LAN:[connected]'),
            color = WIRED_COLOR,
        }
    end
    return res
end
local function mk_vpn()
    local res = {}
    if vpn.connected then
        res = {
            full_text = string.format('VPN:[%s]', vpn.banner),
            color = VPN_COLOR,
        }
    end
    return res
end

widget = {
    plugin = 'dbus',
    opts = {
        greet = true, -- call cb with what=hello on startup
        timeout = 300, -- seconds, call cb with what=timeout if no signal recv
        signals = {
            -- {
            --     interface = NM_IF .. '.Connection.Active',
            --     signal = 'StateChanged',
            --     bus = 'system',
            -- },
            -- {
            --     interface = NM_IF .. '.Connection.Active',
            --     signal = 'PropertiesChanged',
            --     bus = 'system',
            -- },
            {
                interface = NM_IF .. '.Device.Wireless',
                signal = 'PropertiesChanged',
                bus = 'system',
            },
            {
                interface = NM_IF .. '.AccessPoint',
                signal = 'PropertiesChanged',
                bus = 'system',
            },
            {
                interface = NM_IF .. '.Device.Wired',
                signal = 'PropertiesChanged',
                bus = 'system',
            },
            {
                interface = NM_IF .. '.VPN.Connection',
                signal = 'PropertiesChanged',
                bus = 'system',
            },
            {
                interface = NM_IF .. '.VPN.Connection',
                signal = 'VpnStateChanged',
                bus = 'system',
            },
        },
    },

    cb = function(t)
        local res = {}

        if t.what == 'hello' then
            nmcli_parse()

        elseif t.what == 'timeout' then
            nmcli_parse()
            table.insert(res, {
                    full_text = '!',
                    color = common.colors.normal.white,
                    background = common.colors.normal.red,
                })

        elseif t.what == 'signal' then
            -- common.dump(t.interface)
            -- common.dump(t.object_path)

            -- if t.interface == NM_IF .. '.Connection.Active' then
            --     common.dump(t.parameters)

            if t.interface == NM_IF .. '.Device.Wireless' then
                for k, v in pairs(t.parameters) do
                    for k, v in pairs(v) do
                        if v[1] == 'Bitrate' then       wifi.bitrate = v[2] / 1000
                        elseif v[1] == 'State' then
                            -- https://developer.gnome.org/NetworkManager/stable/nm-dbus-types.html#NMDeviceState
                            if v[2] == '20' or v[2] == '30' then 
                                wifi.ready = false
                                wifi.issue = nil
                            elseif v[2] == '100' then 
                                wifi.ready = true
                                wifi.issue = nil
                            else 
                                wifi.issue = { state = v[2] } 
                            end
                        end
                    end
                end

            elseif t.interface == NM_IF .. '.AccessPoint' then
                for k, v in pairs(t.parameters) do
                    for k, v in pairs(v) do
                        if v[1]     == 'Ssid' then          wifi.ssid = v[2]
                        elseif v[1] == 'Strength' then wifi.strength = v[2]
                        end
                    end
                end

            elseif t.interface == NM_IF .. '.Device.Wired' then
                common.dump(t.parameters)

            elseif t.interface == NM_IF .. '.VPN.Connection' then
                common.dump(t.parameters)
                for k, v in pairs(t.parameters) do
                    for k, v in pairs(v) do
                        if v[1] == 'VPNState' then common.dump(v[2])
                        elseif v[1] == 'Banner' then vpn.banner = v[2]
                        end
                    end
                end

            end
        end

        table.insert(res, mk_vpn())
        table.insert(res, mk_wifi())
        table.insert(res, mk_wired())
        return res
    end,

    event = function(t)
        if t.button == 1 then -- left
            -- noop
        elseif t.button == 2 then -- middle
            -- TODO do a rescan of networks, launch rofi with available networks, choose one, connect
        elseif t.button == 3 then -- right
            wifi_on = not wifi_on
            if wifi_on then state = 'on' else state = 'off' end
            assert(os.execute(string.format('nmcli radio wifi %s', state)))
        end
    end,
}

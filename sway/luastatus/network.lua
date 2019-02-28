local common = require "common"

local WIFI_COLOR = common.colors.normal.green
local WIRED_COLOR = common.colors.normal.green
local VPN_COLOR = common.colors.normal.green

local NM_SD ='org.freedesktop.NetworkManager'
local NM_OP ='/org/freedesktop/NetworkManager'
local NM_IF ='org.freedesktop.NetworkManager'

local PRINT_NET_NAMES = true
local HOME_NET = '## HOME WIFI SSID HERE ##'

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
    banner = '--',
    issue = nil,
}

local function parse_vpn_banner()
    local o = common.execute_output('nmcli -t -f type,active,name connection', true)
    for line in o:gmatch("[^\n]+") do
        local net = {}
        for f in line:gmatch('([^:]+)') do
            table.insert(net, f)
        end
        if (net[1] == 'vpn') and (net[2] == 'yes') then
            return net[3]
        end
        if (net[1] == 'tun') and (net[2] == 'yes') then
            return net[3]
        end
    end
end

local function nmcli_parse()
    local o = common.execute_output('nmcli -t -f type,state,connection device', true)
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
        elseif net[1] == 'tun' then
            if net[2] == 'connected' then
                vpn.connected = true
                vpn.banner = parse_vpn_banner()
            end
        end
    end
end

local function mk_wifi(res)
    local txt = ' --'
    if wifi.ready then
        if not wifi.connected then 
            txt = '***'
        else
            if PRINT_NET_NAMES and not (wifi.ssid == HOME_NET) then
                txt = string.format('%s %3d', wifi.ssid, wifi.strength)
            else
                txt = string.format('%s', wifi.strength)
            end
        end
    end
    common.fmt(res, '', txt, WIFI_COLOR)
end
local function mk_wired(res)
    if wired.connected then
        common.fmt(res, '', 'connected', WIRED_COLOR)
    end
end
local function mk_vpn(res)
    local sym = ''
    if vpn.connected or not (vpn.issue == nil) then
        local msg = ''
        if PRINT_NET_NAMES then
            msg = vpn.banner
        end
        if not (vpn.issue == nil) then
            msg = vpn.issue
        else
            sym = ''
        end
        common.fmt(res, sym, msg, VPN_COLOR)
    end
end

local function update(t, res)
    if t.what == 'hello' then
        nmcli_parse()

    elseif t.what == 'timeout' then
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
                    if v[1] == 'Bitrate' then wifi.bitrate = v[2] / 1000
                    elseif v[1] == 'State' then
                        -- https://developer.gnome.org/NetworkManager/stable/nm-dbus-types.html#NMDeviceState
                        if v[2] == '20' or v[2] == '30' then
                            wifi.ready = false
                            wifi.issue = nil
                        elseif v[2] == '100' then
                            wifi.ready = true
                            wifi.issue = nil
                            nmcli_parse()
                        else
                            wifi.issue = { state = v[2] }
                        end
                    end
                end
            end

        elseif t.interface == NM_IF .. '.AccessPoint' then
            for k, v in pairs(t.parameters) do
                for k, v in pairs(v) do
                    if v[1]     == 'Ssid' then wifi.ssid = v[2]
                    elseif v[1] == 'Strength' then wifi.strength = v[2]
                    end
                end
            end

        elseif t.interface == NM_IF .. '.Device.Wired' then
            common.dump(t.parameters)

        elseif t.interface == NM_IF .. '.VPN.Connection' then
            -- common.dump(t.parameters)
            for k, v in pairs(t.parameters) do
                if type(v) == 'table' then
                    for k, v in pairs(v) do
                        if v[1] == 'VpnState' then
                            if v[2] == '0' then vpn.issue = '?'
                            elseif v[2] == '1' then vpn.issue = 'preparing'
                            elseif v[2] == '2' then vpn.issue = 'needs auth'
                            elseif v[2] == '3' then vpn.issue = 'connecting'
                            elseif v[2] == '4' then vpn.issue = 'getting ip'
                            elseif v[2] == '5' then
                                vpn.issue = nil
                                vpn.connected = true
                                vpn.banner = parse_vpn_banner()

                            elseif v[2] == '6' then
                                common.notify('vpn', 'failed to connect')

                            elseif v[2] == '7' then
                                vpn.issue = nil
                                vpn.connected = false
                                vpn.banner = '--'
                            end

                        elseif v[1] == 'Banner' then vpn.banner = v[2]
                        end
                    end
                end
            end

        end
    end

    mk_vpn(res)
    mk_wifi(res)
    mk_wired(res)
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
        update(t, res)
        return res
    end,

    event = function(t)
        if t.button == 1 then -- left
            PRINT_NET_NAMES = not PRINT_NET_NAMES

        elseif t.button == 2 then -- middle
            assert(os.execute(
                'zsh -c "networkmanager_dmenu &!"'))

        elseif t.button == 3 then -- right
            -- noop

        end
    end,
}

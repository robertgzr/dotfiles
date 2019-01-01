local common = require "common"

local BLUETOOTH_COLOR = common.colors.dim.blue

local BT_OP = '/org/bluez/hci0'
local BT_IF = 'org.bluez.Adapter1'
local BTD_IF = 'org.bluez.Device1'
local FD_IF = 'org.freedesktop.DBus.Properties'

local bluetooth = {
    ready = false,
    connected = false,
    name = '-',
}

local bt_on = true

local function mk_bluetooth(res)
    local txt = '--'
    if bluetooth.ready then
        if not bluetooth.connected then 
            txt = '***'
        else
            if not (bluetooth.name == '-') then
                txt = string.format('%s', bluetooth.name)
            else
                txt = '<+>'
            end
        end
        common.fmt(res, '', txt, BLUETOOTH_COLOR)
    end
end

widget = {
    plugin = 'dbus',
    opts = {
        greet = true,
        signals = {
            {
                object_path = BT_OP,
                -- signal = 'PropertiesChanged',
                bus = 'system',
            },
            {
                interface = FD_IF,
                signal = 'PropertiesChanged',
                arg0 = BTD_IF,
                bus = 'system',
            },
        },
    },

    cb = function(t)
        local res = {}

        if t.what == 'hello' then
            -- TODO: figure out how to populate with values before first dbus signal
            -- bluetooth.ready = false

        elseif t.what == 'signal' then
            if t.object_path == BT_OP then
                for k, v in pairs(t.parameters) do
                    if type(v) == 'table' then 
                        for k, v in pairs(v) do
                            if v[1] == 'Powered' then
                                bluetooth.ready = v[2]
                            else
                                common.dump(v)
                            end
                        end
                    end
                end
            elseif t.interface == FD_IF and t.parameters[1] == BTD_IF then
                for k, v in pairs(t.parameters[2]) do
                    if v[1] == 'Connected' then bluetooth.connected = v[2] end
                    if v[1] == 'Alias' then bluetooth.name = v[2] end
                end
            end
        end

        mk_bluetooth(res)
        return res
    end,

    event = function(t)
        if t.button == 1 then -- left
            -- noop
        elseif t.button == 2 then -- middle
            -- TODO do a rescan of available bt devices, launch rofi, choose one, connect
        elseif t.button == 3 then -- right
            -- TODO toggle bluetooth, have to write wrapper around bluetoothctl
            -- bt_on = not bt_on 
            -- if bt_on then
            --     assert(os.execute(''))
            -- else
            --     assert(os.execute(''))
            -- end
        end
    end,
}

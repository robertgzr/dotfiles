local common = require "common"

local COLOR = common.colors.dim.white
local ICON = common.icons.song

local function playerctl(res)
    local ret = {}
    r = common.execute_output('playerctl status -a --format="{{playerName}}={{status}}"', true)
    r = common.split(r)
    for _, l in pairs(r) do
        r = common.split(l, '=')
        player, status = r[1], r[2]
        if status == 'Playing' then
            local d = tonumber(common.execute_output(string.format(
                    'playerctl metadata --player=%s --format="{{mpris:length}}"', player)))
            table.insert(ret, {instance = player, status = common.execute_output(string.format(
                    'playerctl metadata --player=%s --format="{{playerName}}: {{lc(artist)}} / {{lc(title)}} [%s]"', player, common.format_duration(d)))})
        else
            table.insert(ret, {instance = player, status = common.execute_output(string.format(
                    'playerctl metadata --player=%s --format="{{playerName}}: <i>{{lc(status)}}</i>"', player))})
        end
    end
    return ret
end

local function mk_output(res, players)
    for _,player in pairs(players) do
        common.fmt(res, ICON, player.status, COLOR, nil, player.instance)
    end
end

-- function manual_update(res)
--     local p = {}
--     local names = common.execute_output('dbus-send --print-reply=literal --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames')
--     -- detect players
--     for _,name in pairs(common.split(names, ' ')) do
--         bus_name = name:match('org%.mpris%.MediaPlayer2%..+')
--         if bus_name then
--             table.insert(p, bus_name)
--         end
--     end
--     for _,bus_name in pairs(p) do
--         local owner = common.execute_output(string.format(
--             "dbus-send --print-reply=literal --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.GetNameOwner string:'%s'", bus_name))
--         local name = bus_name:match('org%.mpris%.MediaPlayer2%.(.+)')
--         local meta = {}
--         meta["mpris:length"] = common.execute_output(string.format('playerctl -p %s metadata -f "{{mpris:length}}"', name))
--         meta["xesam:artist"] = { common.execute_output(string.format('playerctl -p %s metadata -f "{{xesam:artist}}"', name)) }
--         meta["xesam:title"] = common.execute_output(string.format('playerctl -p %s metadata -f "{{xesam:title}}"', name))
--         players[owner] = { 
--             BusName = name,
--             Metadata = meta,
--             PlaybackStatus = common.execute_output(string.format('playerctl -p %s status -f "{{status}}"', name)),
--         }
--     end
-- end

-- function update(t, res)
--     if t.signal == "NameOwnerChanged" then
--         parse_player_name(t)
--         return
--     end
--     local p = t.sender
--     if not players[p] then players[p] = {} end
--     common.parse_kv_table(players[p], t.parameters)
-- end

-- function parse_player_name(t)
--     local bus_name = t.parameters[1]
--     local new_owner = t.parameters[2]
--     local old_owner = t.parameters[3]
--     bus_name = bus_name:match('org%.mpris%.MediaPlayer2%.([^-]+)')
--     if not bus_name then
--         return
--     end

--     print(string.format('bus: %s) old_owner: %s --> new_owner: %s', bus_name, old_owner, new_owner))

--     if new_owner == "" then
--         -- player appeared
--         players[old_owner] = { BusName = bus_name }
--     end
--     if old_owner == "" then
--         -- player gone
--         players[new_owner] = nil
--     end
-- end

-- function first(t)
--     if #t >= 1 then return t[1] else return nil end
-- end
-- function mk_output(res)
--     for _,state in pairs(players) do
--         if state.PlaybackStatus == "Playing" then
--             common.fmt(res, common.icons.song, string.format(
--                 "%s: %s / %s [%s]", 
--                 state.BusName,
--                 common.try_with(common.try_with(state.Metadata["xesam:artist"], first), string.lower),
--                 common.try_with(state.Metadata["xesam:title"], string.lower),
--                 common.try_with(state.Metadata["mpris:length"], common.format_duration)
--             ), COLOR, nil, state.BusName)
--         elseif state.PlaybackStatus == "Paused" then
--             common.fmt(res, common.icons.song, string.format(
--                 "%s: paused", state.BusName
--             ), COLOR, nil, state.BusName)
--         end
--     end
-- end

widget = {
    plugin = 'dbus',
    opts = {
        greet = true, -- call cb with what=hello on startup
        timeout = 300, -- seconds, call cb with what=timeout if no signal recv
        signals = {
            {
                object_path = '/org/mpris/MediaPlayer2',
            },
            {
                sender = 'org.freedesktop.DBus',
                signal = 'NameOwnerChanged',
                arg0 = 'org.mpris.MediaPlayer2',
                flags = {"match_arg0_namespace"},
            }
        },
    },

    cb = function(t)
        local res = {}
        local players = {}
        if t.what == 'hello' or t.what == 'timeout' then
            players = playerctl()
            -- manual_update(res)
        elseif t.what == 'signal' then
            players = playerctl()
            -- update(t, res)
        end
        mk_output(res, players)
        return res
    end,

    event = function(t)
        if t.button == 1 then -- left
            assert(os.execute(string.format('playerctl --player=%s play-pause', t.instance)))
        end
        if t.button == 3 then -- left
            assert(os.execute(string.format('playerctl --player=%s stop', t.instance)))
        end
    end,
}

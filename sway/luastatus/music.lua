local common = require "common"

local COLOR = common.colors.dim.white

local function currently_playing()
    local status = common.execute_output('mpc status')
    status = status:match('%[%a+%]')
    if status == '[playing]' then
        s = common.execute_output('ncmpcpp --current-song="mpd: {{%a / }%t}|{%f} [{%l}]"')
        return {{instance = 'mpd', status = s:lower()}}
    elseif status == '[paused]' then
        return {{instance = 'mpd', status = 'mpd: paused'}}
    end

    local ret = {}
    r = common.execute_output('playerctl status -a --format="{{playerName}}={{status}}"', true)
    r = common.split(r)
    for _, l in pairs(r) do
        r = common.split(l, '=')
        player, status = r[1], r[2]
        if status == 'Playing' then
            table.insert(ret, {instance = player, status = common.execute_output(string.format(
                    'playerctl metadata --player=%s --format="{{playerName}}: {{lc(artist)}} / {{lc(title)}} [{{duration(mpris:length)}}]"', player))})
        elseif status == 'Paused' then
            table.insert(ret, {instance = player, status = common.execute_output(string.format(
                    'playerctl metadata --player=%s --format="{{playerName}}: {{lc(status)}}"', player))})
        end
    end
    return ret
end

widget = {
    plugin = 'timer',

    cb = function()
        local res = {}
        local playing = currently_playing()
        for _, song in pairs(playing) do
            common.fmt(res, '', song.status, COLOR, nil, song.instance)
        end
        return res
    end,

    event = function(t)
        if t.button == 1 then -- left
            if t.instance == 'mpd' then
                assert(os.execute('mpc toggle'))
            else
                assert(os.execute(string.format('playerctl --player=%s play-pause', t.instance)))
            end
        end
        if t.button == 3 then -- left
            if t.instance == 'mpd' then
                assert(os.execute('mpc stop'))
            else
                assert(os.execute(string.format('playerctl --player=%s stop', t.instance)))
            end
        end
    end,
}

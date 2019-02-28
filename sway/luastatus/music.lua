local common = require "common"

local COLOR = common.colors.dim.white

local function currently_playing()
    local ret = common.execute_output('ncmpcpp --current-song="mpd: {{%a / }%t}|{%f}"')
    if not (ret == '') then
        if not (common.execute_output('mpc status | grep playing') == '') then
            return ret:lower()
        end
    end
    status = common.execute_output('playerctl status')
    if not (status == 'Playing') then
        return '-'
    end
    return common.execute_output('playerctl metadata --format "{{playerName}}: {{lc(artist)}} / {{lc(title)}}"')
end

widget = {
    plugin = 'timer',

    cb = function()
        local res = {}
        local current_song = currently_playing()
        if not (current_song == '-') then
            common.fmt(res, '', current_song, COLOR)
        end
        return res
    end,

    event = function(t)
        if t.button == 1 then -- left
            assert(os.execute('mpc toggle'))
        end
        if t.button == 3 then -- right
            assert(os.execute('playerctl play-pause'))
        end
    end,
}

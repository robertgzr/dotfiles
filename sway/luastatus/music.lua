local common = require "common"

local COLOR = common.colors.dim.white
local ICON = common.icons.song

local function mpdctl()
    local status = common.execute_output('mpc status')
    status = status:match('%[%a+%]')
    if status == '[playing]' then
        s = common.execute_output('ncmpcpp --current-song="mpd: {{%a / }%t}|{%f} [{%l}]"')
        return {instance = 'mpd', status = s:lower()}
    elseif status == '[paused]' then
        return {instance = 'mpd', status = 'mpd: paused'}
    else
        return nil
    end
end

local function mk_output(res, player)
    if not player then return end
    common.fmt(res, ICON, player.status, COLOR, nil, player.instance)
end

widget = {
    plugin = 'timer',
    opts = {
        period = 5,
    },

    cb = function()
        local res = {}
        local player = mpdctl()
        mk_output(res, player)
        return res
    end,

    event = function(t)
        if t.button == 1 then -- left
            assert(os.execute('mpc toggle'))
        end
        if t.button == 3 then -- left
            assert(os.execute('mpc stop'))
        end
    end,
}

local common = require "common"

local SINK = tonumber(common.execute_output('pacmd list-sinks | grep -Po "\\* index: \\K([0-9]+)"'))

widget = {
    plugin = 'pulse',

    opts = {
        sink = tostring(SINK),
    },

    cb = function(t)
        if t.mute then
            return {
                {full_text = '', color = common.colors.dim.red},
            }
        end
        local percent = (t.cur / t.norm) * 100
        return {
            {full_text = '', color = common.colors.normal.cyan},
            {full_text = string.format('%3d', math.floor(0.5 + percent)), color = common.colors.normal.cyan}
        }
    end,

    event = function(t)
        if t.button == 1 then -- left
            local sink_name = common.execute_output(string.format('pactl list short sinks | grep %d | cut -f 2,4', SINK))
            common.notify('pulse', sink_name, 'low', 4000)

            -- -- switch sink
            -- local NSINKS = tonumber(common.execute_output('pactl list sinks short | wc -l'))
            -- local old_sink = SINK
            -- if SINK < (NSINKS-1) then
            --     SINK = SINK + 1
            -- else
            --     SINK = 0
            -- end
            -- if not SINK == old_sink then
            --     -- TODO: parse name here
            --     common.notify('pulse', string.format('switched default sink to %d', SINK))
            -- else
            --     common.notify('pulse', string.format('default sink is %d', SINK))
            -- end

        elseif t.button == 2 then -- middle
            -- show pauvcontrol
            assert(os.execute(
                'zsh -c "pavucontrol &!"'))


        elseif t.button == 3 then -- right
            -- mute sink
            assert(os.execute(string.format(
                'pactl set-sink-mute "%s" toggle', SINK)))
            -- common.notify('pulse', 'toggle mute')

        end
    end,
}

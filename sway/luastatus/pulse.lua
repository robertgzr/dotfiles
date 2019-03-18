local common = require "common"

local SINK = tonumber(common.execute_output('pacmd list-sinks | grep -Po "\\* index: \\K([0-9]+)"'))

widget = {
    plugin = 'pulse',

    opts = {
        sink = tostring(SINK),
        make_self_pipe = true,
    },

    cb = function(t)
        local res = {}

        -- wake_up
        if not t then
            assert(common.notify('', 'pulse: wake_up', 'low'))
            return res
        end

        if t.mute then
            common.fmt(res, '', '', common.colors.normal.red)
            return res
        end

        local percent = (t.cur / t.norm) * 100
        common.fmt(res, '', string.format('%3d', math.floor(0.5 + percent)), common.colors.normal.cyan)
        return res
    end,

    event = function(t)
        if t.button == 1 then -- left
            local sink_name = common.execute_output(string.format(
                'pacmd list-sinks | grep -A 60 -P "index: %d" | grep alsa.card_name | grep -Po "\\"\\K([\\w\\s]+)"', SINK))
            common.notify(nil, 'pulse: ' .. sink_name, 'low', 4000)

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
                'pactl set-sink-mute "%d" toggle', SINK)))
            -- common.notify('pulse', 'toggle mute')

        end
    end,
}

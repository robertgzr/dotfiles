local common = require "common"

widget = {
    plugin = 'pulse',

    opts = {
        sink = '@DEFAULT_SINK@',
        make_self_pipe = true,
    },

    cb = function(t)
        local res = {}

        -- wake_up
        if not t then
            assert(common.notify('pulse', '<i>wakes up</i>', 'low'))
            return res
        end

        if t.mute then
            common.fmt(res, common.icons.volume_mute, '', common.colors.normal.red)
            return res
        end

        local percent = (t.cur / t.norm) * 100
        common.fmt(res, common.icons.volume, string.format('%3d', math.floor(0.5 + percent)), common.colors.normal.cyan)
        return res
    end,

    event = function(t)
        if t.button == 1 then -- left
            local sink_name = common.execute_output([[pacmd list-sinks | tr '\n' '\r' | perl -pe 's/[^\r]*index:.+alsa\.card_name = \"([^\r]+)\".+device\.profile\.name = \"([^\r]+)\".+(?=index|$)/\1 <\2>/g' | tr '\r' '\n' | tail -n +2]])
            common.notify('pulse', 'Current sink: ' .. sink_name, 'low', 4000)

        elseif t.button == 2 then -- middle
            -- show pauvcontrol
            assert(os.execute(
                'zsh -c "pavucontrol &!"'))


        elseif t.button == 3 then -- right
            -- mute sink
            assert(os.execute('pactl set-sink-mute @DEFAULT_SINK@ toggle'))
            -- common.notify('pulse', 'toggle mute')

        end
    end,
}

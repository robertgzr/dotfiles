local common = require "common"

local NSINKS = tonumber(common.execute_output('pactl list sinks short | wc -l'))
local SINK = tonumber(common.execute_output('pacmd list-sinks | grep -Po "\\* index: \\K([0-9]+)"'))

widget = {
    plugin = 'pulse',

    opts = {
        sink = tostring(SINK),
    },

    cb = function(t)
        NSINKS = tonumber(common.execute_output('pactl list sinks short | wc -l'))
        if t.mute then
            return {full_text = 'VOL:[***]', color = common.colors.dim.red}
        end
        local percent = (t.cur / t.norm) * 100
        return {full_text = string.format('VOL:[%3d]', math.floor(0.5 + percent)), color = common.colors.normal.cyan}
    end,

    event = function(t)
        if t.button == 1 then -- left
            -- switch sink
            local old_sink = SINK
            if SINK < (NSINKS-1) then
                SINK = SINK + 1
            else
                SINK = 0
            end
            if not SINK == old_sink then
                -- TODO: parse name here
                common.notify('pulse', string.format('switched default sink to %d', SINK))
            else
                common.notify('pulse', string.format('default sink is %d', SINK))
            end

        elseif t.button == 2 then -- middle
            -- show pauvcontrol
            assert(os.execute(
                'zsh -c "pavucontrol &!"'))


        elseif t.button == 3 then -- right
            -- mute sink
            assert(os.execute(string.format(
                'pactl set-sink-mute "%s" toggle', SINK)))

        end
    end,
}

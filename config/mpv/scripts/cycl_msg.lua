-- Change these values to your own messages
local msg_values = {
    "B : vf -> vs.f3kdb\nP : vf -> vs.interpolation60\nG : vf -> gradfun\n\n1 : vf -> dsize(original)\n2 : vf -> dsize(500)\n3 : vf -> dsize(800)\n4 : vf -> dsize(1280)\n\nH : af -> bs2b",
    "y : decrease SUB delay [-0.1]\nx : increase SUB delay [+0.1]\n\nY : decrease AUDIO delay [-0.1]\nX : increase AUDIO delay [+0.1]",
    "g : take a screenshot\nG : screenshot (without subtitles)\nCmd-g : screenshot w/ subtitles and OSD (scaled)\nAlt-g : screenshot each frame\n\nCmd-s : try autoload subtitles",
    "i : show stats\nv : cycle video tracks\na : cycle audio tracks\ns : cycle subtitle tracks",
    ""
    }
local current_index = 1;

local function cycle_messages()
    local last_index = #msg_values

    mp.osd_message(msg_values[current_index], 3)

    if current_index == last_index then
        current_index = 1
    else
        current_index = current_index + 1
    end
end

mp.add_key_binding("0", "cycle_messages", cycle_messages)
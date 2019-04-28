local common = require "common"

local COLOR = common.colors.dim.white

widget = {
    plugin = 'timer',

    cb = function()
        local res = {}
        common.fmt(res, '|', os.date('<i>%a</i> %d %b %R'), COLOR)
        return res
    end,

    event = function(t)
        if t.button == 1 then -- left
            assert(os.execute('zsh -c "gnome-calendar &!"'))
        end
    end,
}

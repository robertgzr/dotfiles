local common = require "common"

widget = {
    plugin = 'timer',

    cb = function()
        local str = os.date('%a %d %b %R')
        return {
            {full_text = str, color = common.colors.normal.white},
        }
    end,

    event = function(t)
        if t.button == 1 then -- left
            assert(os.execute('zsh -c "gnome-calendar &!"'))
        end
    end,
}

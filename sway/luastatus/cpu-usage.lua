local common = require "common"

local COLOR = common.colors.dim.yellow

widget = luastatus.require_plugin('cpu-usage-linux').widget{
    cb = function(usage)
        if usage ~= nil then
            local res = {}
            common.fmt(res, common.icons.cpu, string.format('%4.1f%%', usage * 100), COLOR)
            return res
        end
    end,

    event = function(t)
        if t.button == 2 then
            assert(os.execute(
                'zsh -c "alacritty --title htop --class htop -e htop &!"'))
        end
    end,
}

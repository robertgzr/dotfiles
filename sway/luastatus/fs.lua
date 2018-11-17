local common = require "common"

local color = common.colors.dim.magenta

widget = {
    plugin = 'fs',
    opts = {
        paths = {'/', '/home'},
    },
    cb = function(t)
        local res = {{full_text = 'FS:', color = color}}
        for k, v in pairs(t) do
            table.insert(res, {
                full_text = string.format('%s %.0f%%',
                    k, (1 - v.avail / v.total) * 100),
                instance = k,
                color = color,
            })
        end
        return res
    end,
}

local common = require "common"

local COLOR = common.colors.dim.magenta

widget = {
    plugin = 'fs',
    opts = {
        paths = {'/'},
    },
    cb = function(t)
        local res = {}
        for k, v in pairs(t) do
            common.fmt(res,'', string.format('%s %.0f%%', k, (1 - v.avail / v.total) * 100), COLOR)
            res[2].instance = k
        end
        return res
    end,
}

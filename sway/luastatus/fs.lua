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
            table.insert(res, {
                full_text = string.format('%s:[%.0f%%]',
                    k, (1 - v.avail / v.total) * 100),
                -- full_text = string.format('%s:[%.1f/%.1f]', k, v.avail/1000000000, v.total/1000000000),
                instance = k,
                color = COLOR,
            })
        end
        return res
    end,
}

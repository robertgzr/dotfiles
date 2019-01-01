local common = require "common"

local COLOR = common.colors.dim.yellow

widget = luastatus.require_plugin('cpu-usage-linux').widget{
    cb = function(usage)
        if usage ~= nil then
            local res = {}
            common.fmt(res, '', string.format('%4.1f%%', usage * 100), COLOR)
            return res
        end
    end,
}

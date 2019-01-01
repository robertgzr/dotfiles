local common = require "common"

local COLOR = common.colors.dim.cyan

widget = luastatus.require_plugin('mem-usage-linux').widget{
    timer_opts = {period = 2},
    cb = function(t)
        local res = {}
        local used_kb = t.total.value - t.avail.value
        common.fmt(res, '', string.format('%3.2f GiB', used_kb / 1024 / 1024), COLOR)
        return res
    end,
}

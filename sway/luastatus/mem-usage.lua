local common = require "common"

widget = luastatus.require_plugin('mem-usage-linux').widget{
    timer_opts = {period = 2},
    cb = function(t)
        local used_kb = t.total.value - t.avail.value
        return {
            full_text = string.format('RAM:[%3.2f GiB]', used_kb / 1024 / 1024), 
            color = common.colors.dim.cyan,
        }
    end,
}

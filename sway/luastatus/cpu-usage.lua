local common = require "common"

widget = luastatus.require_plugin('cpu-usage-linux').widget{
    cb = function(usage)
        if usage ~= nil then
            return {full_text = string.format('CPU:[%5.1f%%]', usage * 100), color = common.colors.dim.yellow}
        end
    end,
}

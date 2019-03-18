local common = require "common"

-- Note that this widget only shows backlight level when it changes.
widget = luastatus.require_plugin('backlight-linux').widget{
    cb = function(level)
        local res = {}
        if level ~= nil then
            common.fmt(res, '', string.format('%2.0f', level * 100), common.colors.normal.yellow)
            return res
        end
    end,
}

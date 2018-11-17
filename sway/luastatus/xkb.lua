local common = require "common"

widget = {
    plugin = 'xkb',
    cb = function(t)
        print(t.name)
        if t.name then
            local base_layout = t.name:match('[^(]+')
            if base_layout == 'gb' or base_layout == 'us' then
                return
                -- return {full_text = '[En]', color = common.colors.dim.white}
            else
                return {full_text = '[' .. base_layout:sub(1, 1):upper() .. base_layout:sub(2) .. ']'}
            end
        else
            return {full_text = '[? ID ' .. t.id .. ']'}
        end
    end,
}

local common = require "common"

local ICON = ''

local function query(kb)
    return common.execute_output(string.format('swaymsg -t get_inputs | jq -r \'[ .[] | select(.identifier=="%s" and .type=="keyboard") ] | unique_by(.identifier) | .[].xkb_active_layout_name\'', kb))
end

widget = {
    plugin = 'timer',
    opts = {
        period = 1,
    },

    cb = function(t)
        local res = {}
        local layouts = {
            query("## KBD 1 ##"),
            query("## KDB 2 ##"),
        }
        for kb, layout in pairs(layouts) do
            common.dump(layout)
            if not (layout == '') and not (layout == 'English (Macintosh)') then
                common.fmt(res, ICON, '(' .. kb .. ')' .. layout:lower(), common.colors.dim.white)
                return res
            end
        end
        return res
    end,
}

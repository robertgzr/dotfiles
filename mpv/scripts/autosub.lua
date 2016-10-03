-- default keybinding: b
-- add the following to your input.conf to change the default keybinding:
-- keyname script_binding auto_load_subs
local utils = require 'mp.utils'
function load_sub_fn()
    subl = "/usr/local/bin/subliminal" -- use 'which subliminal' to find the path
    mp.msg.info("Searching subtitle")
    mp.osd_message("Searching subtitle")
    t = {}
    t.args = {subl, "-v", "-s", "-l", "en", "--", mp.get_property("path")}
    res = utils.subprocess(t)
    if res.status == 0 then
        mp.commandv("rescan_external_files", "reselect")
        mp.msg.info("subtitle download succeeded")
        mp.osd_message("subtitle download succeeded")
    else
        mp.msg.warn("couldn't find subtitles")
        mp.osd_message("couldn't find subtitles")
    end
end

mp.add_key_binding("b", "auto_load_subs", load_sub_fn)

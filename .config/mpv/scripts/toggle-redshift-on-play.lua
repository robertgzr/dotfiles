-- Toggle redshift when viewing videos with mpv
-- When pausing redshift is reenabled (and disabled again when continuing)
-- This script assumes that redshift is running

rs_enabled = true

function rs_toggle()
    os.execute("pkill -x -USR1 redshift")
end

function rs_disable()
    if rs_enabled then
        rs_toggle()
        rs_enabled = false
        mp.msg.log("info", "Disabling redshift")
    end
end

function rs_enable()
    if not rs_enabled then
        rs_toggle()
        rs_enabled = true
        mp.msg.log("info", "Reenabling redshift")
    end
end

function rs_handler()
    if mp.get_property("video") ~= "no" then
        rs_disable()
    else
        rs_enable()
    end
end


function on_pause_change(name, value)
    if value then  --pause started
        rs_enable()
    else
        rs_disable()
    end
end


mp.register_event("file-loaded", rs_handler)
mp.register_event("shutdown", rs_enable)
mp.observe_property("pause", "bool", on_pause_change)
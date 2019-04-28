local common = require "common"

paths = {}
do
    local f = assert(io.popen("printf '%s\n' /sys/class/thermal/thermal_zone*/temp"))
    for p in f:lines() do
        table.insert(paths, p)
    end
    f:close()
end

COOL_TEMP = 50
HEAT_TEMP = 80
function getcolor(temp)
    local t = (temp - COOL_TEMP) / (HEAT_TEMP - COOL_TEMP)
    if t < 0 then 
        return false
    else
        return true
    end
end

widget = {
    plugin = 'timer',
    opts = { period = 2 },
    cb = function()
        local res = {}
        for _, p in ipairs(paths) do
            local f = assert(io.popen(p, 'r'))
            if f then
                local temp = f:read('*number') / 1000
                common.fmt(res, 'T', string.format('%.0f'))
                f:close()
            end
        end
        return res
    end,
}

local common = require "common"

local COLOR = common.colors.dim.red
local TOKEN = '47b6fc91491e720264576d0d29a3590a'

local toggl = 0
local tick = 0

local function timer_duration()
    local d = common.execute_output(string.format('toggl -t %s -j timer ls | jq -r ".[0].duration"', TOKEN))
    if not (d == '') then
        return tonumber(d)
    end
    return nil
end
local function unix_time()
    return tonumber(os.date('%s'))
end
local function refresh()
    -- common.notify(nil, 'refreshing toggl timer')
    local diff = timer_duration()
    if not diff then
        toggl = 0
        return
    end
    toggl = unix_time() + diff
end

widget = {
    plugin = 'timer',
    opts = {
        period = 5,
    },

    cb = function(arg)
        local res = {}

        if (arg == 'hello') then
            refresh()
        end

        if (tick > 120) then
            refresh()
            tick = 0
        else
            tick = tick + 1
        end

        if toggl < 1 then
            return res
        end

        common.fmt(res, '', string.format('%dh %.2dm', toggl/(60*60), toggl/60%60), COLOR)
        return res
    end,

    event = function(t)
        if t.button == 1 then -- left
        end
        if t.button == 2 then -- middle
            assert(os.execute(string.format('env TOKEN=%s toggl_dmenu', TOKEN)))
            refresh()
        end
        if t.button == 3 then -- right
            refresh()
        end
    end,
}

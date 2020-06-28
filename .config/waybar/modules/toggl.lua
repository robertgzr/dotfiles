#!/usr/bin/env luajit

TOKEN = os.getenv("TOGGL_TOKEN")
if not TOKEN then
    io.stderr:write("need TOGGL_TOKEN\n")
    os.exit(1)
end

function timer_duration()
    cmd = string.format('toggl -t %s -j timer ls | jq -r ".[0].duration"', TOKEN)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if not (s == '') then
        return tonumber(s)
    end
end

unix_time = os.time()

diff = timer_duration()
if not diff then
    os.exit(0)
end

d = unix_time + diff

print(string.format(' %dh %.2dm', d/(60*60), d/60%60))

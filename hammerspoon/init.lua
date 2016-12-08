conf = {
    super = {"cmd", "alt", "ctrl", "shift"},
    hotkeyAlterDuration = 0.5,
    windowAnimationDuration = 0.01,
    windowHotkeyModal = false
}

hs.window.animationDuration = conf.windowAnimationDuration
hs.hotkey.alertDuration = conf.hotkeyAlterDuration
local super = conf.super

hs.hotkey.bind(super, "R", function()
    hs.reload()
end)

function iterm_applescript (title, command)
    local mpv = hs.application.find('mpv')
    local osa = ""
    title = "mpvp"
    if mpv ~= nil then
        -- use the old terminal
        osa = [[
tell application "iTerm2"
    activate
    repeat with w in windows
    tell w
        if name is "]] .. title .. [[" then
            tell current session
                write text "]] .. command .. [["
            end tell
        end if
    end tell
    end repeat
end tell
]]
    else
        osa = [[
tell application "iTerm2"
    activate
    set term to (create window with default profile)
    tell term
        tell current session
            set rows to 15
            set columns to 100
            set name to "]] .. title ..[["
            write text "]] .. command .. [["
        end tell
    end tell
end tell
]]
    end
    hs.osascript.applescript(osa)
end

function launch_mpvp ()
    local pb = hs.pasteboard.readString()
    hs.notify.new({
        title = 'mpvp',
        informativeText = pb,
        contentImage = hs.image.imageFromAppBundle('io.mpv'),
    }):send()

    iterm_applescript('mpvp', 'mpvp')
end
function launch_mpvpa ()
    local pb = hs.pasteboard.readString()
    hs.notify.new({
        title = 'mpvp',
        informativeText = pb,
        contentImage = hs.image.imageFromAppBundle('io.mpv'),
    }):send()

    iterm_applescript('mpvp', 'mpvp -a')
end

function resizeLeftHalf ()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w /2
    f.h = max.h
    win:setFrameInScreenBounds(f)
end
function resizeRightHalf ()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w /2)
    f.y = max.y
    f.w = max.w /2
    f.h = max.h
    win:setFrameInScreenBounds(f)
end
function resizeTopHalf ()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h /2
    win:setFrameInScreenBounds(f)
end
function resizeBottomHalf ()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y + (max.h /2)
    f.w = max.w
    f.h = max.h /2
    win:setFrameInScreenBounds(f)
end
function resizeFullscreen ()
    local win = hs.window.focusedWindow()
    win:maximize()
end
function resizeCenter ()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.w = max.w *0.8
    f.h = max.h *0.8
    win:setFrameInScreenBounds(f)
    win:centerOnScreen(nil, true)
end
function floatingVideo (pos)
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.w = max.w * 0.3
    f.h = max.h * 0.3

    if pos == "topleft" then
        f.x = 0
        f.y = 0
    elseif pos == "bottomleft" then
        f.x = 0
        f.y = max.h - f.h + 50
    elseif pos == "topright" then
        f.x = max.w - f.w + 6
        f.y = 0
    elseif pos == "bottomright" then
        f.x = max.w - f.w + 6
        f.y = max.h - f.h + 50
    end

    win:setFrameInScreenBounds(f)
end

-- mpvp bind
local hot_mpv = hs.hotkey.modal.new(super, "M", "MPV Mode")
-- function hot_mpv:exited() hs.alert.show("Normal Mode") end
hot_mpv:bind('', 'escape', function () hot_mpv:exit() end)
hot_mpv:bind('', 'M', function ()
    launch_mpvp()
    hot_mpv:exit()
end)
hot_mpv:bind('', 'A', function ()
    launch_mpvpa()
    hot_mpv:exit()
end)
hot_mpv:bind('', 'K', function ()
    hs.application.find('mpv'):kill()
    hot_mpv:exit()
end)

-- hs.hotkey.bind(super, "M", launch_mpvp)

-- resize the current window to a small overlay
hs.hotkey.bind(super, 'T', function ()
    floatingVideo("topright")
end)

-- movement binds
if conf.windowHotkeyModal then
    local hot_win = hs.hotkey.modal.new(super, "W", "Window Mode")
    -- function hot_win:entered() hs.alert.show("Window Mode") end
    function hot_win:exited() hs.alert.show("Normal Mode") end
    hot_win:bind('', 'escape', function () hot_win:exit() end)
    hot_win:bind('', 'H', resizeLeftHalf)
    hot_win:bind('', 'K', resizeTopHalf)
    hot_win:bind('', 'J', resizeBottomHalf)
    hot_win:bind('', 'L', resizeRightHalf)
    hot_win:bind('', 'F', resizeFullscreen)
    hot_win:bind('', 'C', resizeCenter)
else
    hs.hotkey.bind(super, 'H', resizeLeftHalf)
    hs.hotkey.bind(super, 'K', resizeTopHalf)
    hs.hotkey.bind(super, 'J', resizeBottomHalf)
    hs.hotkey.bind(super, 'L', resizeRightHalf)
    hs.hotkey.bind(super, 'F', resizeFullscreen)
    hs.hotkey.bind(super, 'C', resizeCenter)
    -- move between screens
    hs.hotkey.bind(super, 'left', function()
        hs.window.focusedWindow():moveOneScreenWest()
    end)
    hs.hotkey.bind(super, 'up', function()
        hs.window.focusedWindow():moveOneScreenNorth()
    end)
    hs.hotkey.bind(super, 'down', function()
        hs.window.focusedWindow():moveOneScreenSouth()
    end)
    hs.hotkey.bind(super, 'right', function()
        hs.window.focusedWindow():moveOneScreenEast()
    end)
end

hs.hotkey.bind(super, 's', function()
    hs.caffeinate.lockScreen()
end)

require("hs.ipc")
hs.ipc.cliInstall()

conf = {
    hyper = {"cmd", "alt", "ctrl", "shift"},
    hotkeyAlterDuration = 0.5,
    windowAnimationDuration = 0.01,
}

hs.window.animationDuration = conf.windowAnimationDuration
hs.hotkey.alertDuration = conf.hotkeyAlterDuration
local hyper = conf.hyper

hs.hotkey.bind(hyper, "R", function()
    hs.reload()
end)
hs.hotkey.bind(hyper, "B", function()
    hs.application.launchOrFocusByBundleID("org.mozilla.nightly")
end)
hs.hotkey.bind(hyper, "F", function()
    hs.application.launchOrFocus("Finder")
end)
hs.hotkey.bind(hyper, "V", function()
    hs.application.launchOrFocusByBundleID("com.qvacua.VimR")
end)

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

-- movement binds
local hot_win = hs.hotkey.modal.new(hyper, "Q", "Window Mode")
-- function hot_win:entered() hs.alert.show("Window Mode") end
-- function hot_win:exited() hs.alert.show("Normal Mode") end
hot_win:bind('', 'escape', function()
    hot_win:exit() 
    hs.alert.show("Normal Mode")
end)
hot_win:bind('', 'H', function()
    resizeLeftHalf()
    hot_win:exit()
end)
hot_win:bind('', 'K', function()
    resizeTopHalf()
    hot_win:exit()
end)
hot_win:bind('', 'J', function()
    resizeBottomHalf()
    hot_win:exit()
end)
hot_win:bind('', 'L', function()
    resizeRightHalf()
    hot_win:exit()
end)
hot_win:bind('', 'F', function()
    resizeFullscreen()
    hot_win:exit()
end)
hot_win:bind('', 'C', function()
    resizeCenter()
    hot_win:exit()
end)
-- resize the current window to a small overlay
hot_win:bind('', 'T', function()
    floatingVideo("topright")
    hot_win:exit()
end)

-- move windows between screens
hot_win:bind('shift', 'H', function()
    hs.window.focusedWindow():moveOneScreenWest(true, true)
    hot_win:exit()
end)

hot_win:bind('shift', 'J', function()
    hs.window.focusedWindow():moveOneScreenSouth(true, true)
    hot_win:exit()
end)
hot_win:bind('shift', 'K', function()
    hs.window.focusedWindow():moveOneScreenNorth(true, true)
    hot_win:exit()
end)
hot_win:bind('shift', 'L', function()
    hs.window.focusedWindow():moveOneScreenEast(true, true)
    hot_win:exit()
end)

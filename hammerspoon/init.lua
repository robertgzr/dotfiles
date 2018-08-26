require("hs.ipc")
hs.ipc.cliInstall()

conf = {
    hyper = {"cmd", "alt", "ctrl", "shift"},
    hotkeyAlterDuration = 0.5,
    windowAnimationDuration = 0.01,
}

scr = hs.screen.primaryScreen()
hs.grid.setGrid('2x2', scr, scr:fullFrame()).setMargins(hs.geometry(nil,nil,0,0))
hs.grid.ui.fontName = 'Iosevka Term-Lig'

hs.window.animationDuration = conf.windowAnimationDuration
-- hs.window.setFrameCorrectness = true
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
hs.hotkey.bind(hyper, "Return", function()
    hs.application.launchOrFocusByBundleID("io.alacritty")
end)

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
hot_win:bind('', 'Q', function()
    hs.grid.show()
    hot_win:exit() 
end)
hot_win:bind('', 'escape', function()
    hot_win:exit() 
    hs.alert.show("Normal Mode")
end)
hot_win:bind('', 'H', function()
    hs.grid.pushWindowLeft()
    hot_win:exit()
end)
hot_win:bind('', 'K', function()
    hs.grid.pushWindowUp()
    hot_win:exit()
end)
hot_win:bind('', 'J', function()
    hs.grid.pushWindowDown()
    hot_win:exit()
end)
hot_win:bind('', 'L', function()
    hs.grid.pushWindowRight()
    hot_win:exit()
end)
hot_win:bind('', 'F', function()
    local win = hs.window.focusedWindow()
    hs.grid.maximizeWindow(win)
    r = win:size()
    r.w = r.w+4
    win:setSize(r)
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
    hs.grid.resizeWindowThinner()
    hot_win:exit()
end)

hot_win:bind('shift', 'J', function()
    hs.grid.resizeWindowShorter()
    hot_win:exit()
end)
hot_win:bind('shift', 'K', function()
    hs.grid.resizeWindowTaller()
    hot_win:exit()
end)
hot_win:bind('shift', 'L', function()
    hs.grid.resizeWindowWider()
    hot_win:exit()
end)

on run argv
    tell application "FirefoxNightly" to activate
    tell application "System Events"

        if (item 1 of argv is equal to "win") then
            keystroke "n" using {command down}
            delay 1
        else if (item 1 of argv is equal to "tab") then
            keystroke "t" using {command down}
        end if

        keystroke item 2 of argv & return
    end tell
end run

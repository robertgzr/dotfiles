front = hs.application.frontmostApplication()

hs.application.launchOrFocusByBundleID("org.mozilla.nightly")
hs.eventtap.keyStroke({"cmd"}, "R")
front:activate()

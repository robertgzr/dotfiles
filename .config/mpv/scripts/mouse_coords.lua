local msg = require('mp.msg')

-- local x, y = 0, 0

-- function set_marker()
--     x, y = mp.get_mouse_pos()
-- end

-- function measure()
--     x2, y2 = mp.get_mouse_pos()
--     w = x2-x
--     h = y2-y

--     pos = "x: " .. x .. ", y:" .. y
--     dimensions = "w: " .. h .. ", h:" .. h
--     output = pos .. " | " .. dimensions

--     mp.msg.warn(output)
--     mp.osd_message(output)
-- end

function print_pos()
    x, y = mp.get_mouse_pos()
    pos = "x: " .. x .. ", y: " .. y
    mp.msg.warn(pos)
    mp.osd_message(pos)
end

mp.add_key_binding("0", mp.get_script_name(), print_pos)
-- mp.add_key_binding("8", mp.get_script_name().."/set", set_marker)
-- mp.add_key_binding("9", mp.get_script_name().."/measure", measure)

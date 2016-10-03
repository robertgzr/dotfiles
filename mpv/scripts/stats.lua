-- Display some stats.
--
-- You can invoke the script with "i" by default or create a different key
-- binding in input.conf using "<yourkey> script_binding stats".
--
-- Default appearance: http://a.pomf.se/paphjk.png
-- The style is configurable through a config file named "lua-settings/stats.conf"
-- located in your mpv directory.
--
-- Please note: not every property is always available and therefore not always
-- visible.

local options = require 'mp.options'
local osd_state = false

-- Options
local o = {
    ass_formatting = true,
    duration = 60,
    -- debug = no,
    debug = yes,

    -- Text style
    -- font = "Source Sans Pro",
    -- font = ".HelveticaNeueDeskInterface-Regular",
    -- font = "SFNS Text",
    font="Iosevka",
    font_size = 9,
    font_color = "FFFFFF",
    border_size = 0.8,
    border_color = "262626",
    shadow_x_offset = 0.0,
    shadow_y_offset = 0.0,
    shadow_color = "000000",
    alpha = 20,
    valign=1,
    halign=-1,
    vidscale=no;

    -- Custom header for ASS tags to style the text output.
    -- Specifying this will ignore the text style values above and just
    -- use this string instead.
    custom_header = "",

    -- Text formatting
    -- With ASS
    nl = "\\N",
    prop_indent = "\\h\\h\\h\\h\\h",
    kv_sep = "\\h\\h",
    b1 = "{\\b1}",
    b0 = "{\\b0}",
    -- Without ASS
    no_ass_nl = "\n",
    no_ass_prop_indent = "\t",
    no_ass_kv_sep = " ",
    no_ass_b1 = "",
    no_ass_b0 = "",
}
read_options(o, "../lua-settings/stats.conf")


function main()
    local stats = {
        header = "",
        file = "",
        video = "",
        audio = "",
        playlist = ""
    }

    o.ass_formatting = o.ass_formatting and has_vo_window()
    if not o.ass_formatting then
        o.nl = o.no_ass_nl
        o.prop_indent = o.no_ass_prop_indent
        o.kv_sep = o.no_ass_kv_sep
        o.b1 = o.no_ass_b1
        o.b0 = o.no_ass_b0
    end

    add_header(stats)
    add_file(stats)
    add_video(stats)
    add_audio(stats)
    add_playlist(stats)

    -- toggle stats instead of just showing them for o.duration
    if not osd_state then
        mp.osd_message(join_stats(stats), o.duration)
        osd_state = true
    else
        mp.osd_message("")
        osd_state = false
    end
end


function add_file(s)
    local sec = "file"
    s[sec] = ""

    append_property(s, sec, "filename", {prefix="File:", nl="", indent=""})
    append_property(s, sec, "metadata/title", {prefix="Title:"})
    append_property(s, sec, "chapter", {prefix="Chapter:"})
    if append_property(s, sec, "cache-used", {prefix="Cache:"}) then
        append_property(s, sec, "demuxer-cache-duration",
                        {prefix="+", suffix=" sec", nl="", indent=o.kv_sep,
                         prefix_sep="", no_prefix_markup=true})
    end
end


function add_video(s)
    local sec = "video"
    s[sec] = ""
    if not has_video() then
        return
    end

    if append_property(s, sec, "video-codec", {prefix="Video:", nl="", indent=""}) then
        append_property(s, sec, "hwdec-active",
                        {prefix="(hwdec)", nl="", indent=" ",
                         no_prefix_markup=true, no_value=true},
                        {no=true})
    end
    append_property(s, sec, "avsync", {prefix="A-V:"})
    if append_property(s, sec, "drop-frame-count", {prefix="Dropped:"}) then
        append_property(s, sec, "vo-drop-frame-count", {prefix="VO:", nl=""})
    end
    if append_property(s, sec, "fps", {prefix="FPS:", suffix=" (specified)"}) then
        append_property(s, sec, "estimated-vf-fps",
                        {suffix=" (estimated)", nl="", indent=""})
    else
        append_property(s, sec, "estimated-vf-fps",
                        {prefix="FPS:", suffix=" (estimated)"})
    end
    if append_property(s, sec, "video-params/w", {prefix="Native Resolution:"}) then
        append_property(s, sec, "video-params/h",
                        {prefix="x", nl="", indent=" ", prefix_sep=" ", no_prefix_markup=true})
    end
    append_property(s, sec, "window-scale", {prefix="Window Scale:"})
    append_property(s, sec, "video-params/aspect", {prefix="Aspect Ratio:"})
    append_property(s, sec, "video-params/pixelformat", {prefix="Pixel format:"})
    append_property(s, sec, "video-params/colormatrix", {prefix="Colormatrix:"})
    append_property(s, sec, "video-params/primaries", {prefix="Primaries:"})
    append_property(s, sec, "video-params/colorlevels", {prefix="Levels:"})
    append_property(s, sec, "packet-video-bitrate", {prefix="Bitrate:", suffix=" kbps"})
end


function add_audio(s)
    local sec = "audio"
    s[sec] = ""
    if not has_audio() then
        return
    end

    append_property(s, sec, "audio-codec", {prefix="Audio:", nl="", indent=""})
    append_property(s, sec, "audio-params/samplerate", {prefix="Sample Rate:", suffix=" Hz"})
    append_property(s, sec, "audio-params/channel-count", {prefix="Channels:"})
    append_property(s, sec, "packet-audio-bitrate", {prefix="Bitrate:", suffix=" kbps"})
end


function add_header(s)
    if not o.ass_formatting then
        s.header = ""
        return
    end
    if o.custom_header and o.custom_header ~= "" then
        s.header = set_ASS(true) .. o.custom_header
    else
        s.header = string.format([[%s{\\fs%d}{\\fn%s}{\\bord%f}{\\3c&H%s&}{\\1c&H%s&}
                                 {\\alpha&H%s&}{\\xshad%f}{\\yshad%f}{\\4c&H%s&}]],
                        set_ASS(true), o.font_size, o.font, o.border_size,
                        o.border_color, o.font_color, o.alpha, o.shadow_x_offset,
                        o.shadow_y_offset, o.shadow_color)
    end
end

function add_playlist(s)
    local pl = mp.get_property_native("playlist", {})
    local sec = "playlist"
    s[sec] = ""
    if pl_is_empty(pl) then
        return
    end

    if not o.ass_formatting then
        s.playlist = string.format("\n\nPlaylist:\n%s", mp.get_property_osd("playlist"))
        return
    end

    s.playlist = string.format("\\N\\N{\\b1}Playlist:{\\b0}\\h\\h(%s/%s)\\N", pl_get_current(pl), #pl)
    for k,f in pairs(pl) do
        if f.current ~= nil then
            s.playlist = s.playlist .. string.format("\\h\\h\\h{\\b1\\3c&HFE25bF&}▶ %s{\\b0\\3c&H262626&}\\N", f.filename)
        else
            s.playlist = s.playlist .. string.format("\\h\\h\\h\\h∙ %s\\N", f.filename)
        end
    end
    -- append_property(s, sec, "playlist", {prefix="PL:", indent=""})
end

-- Format and append a property.
-- A property whose value is either `nil` or empty (hereafter called "invalid")
-- is skipped and not appended.
-- Returns `false` in case nothing was appended, otherwise `true`.
--
-- s       : Table containing key `sec`.
-- sec     : Existing key in table `s`, value treated as a string.
-- property: The property to query and format (based on its OSD representation).
-- attr    : Optional table to overwrite certain (formatting) attributes for
--           this property.
-- exclude : Optional table containing keys which are considered invalid values
--           for this property. Specifying this will replace empty string as
--           default invalid value (nil is always invalid).
function append_property(s, sec, prop, attr, excluded)
    excluded = excluded or {[""] = true}
    local ret = mp.get_property_osd(prop)
    if not ret or excluded[ret] then
        if o.debug then
            print("No value for property: " .. prop)
        end
        return false
    end

    attr.prefix_sep = attr.prefix_sep or o.kv_sep
    attr.indent = attr.indent or o.prop_indent
    attr.nl = attr.nl or o.nl
    attr.suffix = attr.suffix or ""
    attr.prefix = attr.prefix or ""
    attr.no_prefix_markup = attr.no_prefix_markup or false
    attr.prefix = attr.no_prefix_markup and attr.prefix or b(attr.prefix)
    ret = attr.no_value and "" or ret

    s[sec] = string.format("%s%s%s%s%s%s%s", s[sec], attr.nl, attr.indent,
                           attr.prefix, attr.prefix_sep, no_ASS(ret), attr.suffix)
    return true
end


function no_ASS(t)
    return set_ASS(false) .. t .. set_ASS(true)
end


function set_ASS(b)
    if not o.ass_formatting then
        return ""
    end
    return mp.get_property_osd("osd-ass-cc/" .. (b and "0" or "1"))
end


function join_stats(s)
    r = s.header .. s.file

    if s.video and s.video ~= "" then
        r = r .. o.nl .. o.nl .. s.video
    end
    if s.audio and s.audio ~= "" then
        r = r .. o.nl .. o.nl .. s.audio
    end

    r = r .. s.playlist

    return r
end


function has_vo_window()
    return mp.get_property("vo-configured") == "yes"
end


function has_video()
    local r = mp.get_property("video")
    return r and r ~= "no" and r ~= ""
end


function has_audio()
    local r = mp.get_property("audio")
    return r and r ~= "no" and r ~= ""
end

function pl_is_empty(pl)
    if pl[2] == nil then
        return true
    end
    return false
end

function pl_get_current(pl)
    for k,f in pairs(pl) do
        if f.current == true then return k end
    end
    return nil
end

function b(t)
    return o.b1 .. t .. o.b0
end



mp.add_key_binding("i", mp.get_script_name(), main, {repeatable=true})

package.path = package.path .. ";" .. os.getenv('HOME') .. '/.cache/wal/luastatus.lua'
local wal = require "luastatus"

local common = {}

common.colors = {
    normal = {
        black =  '#0C0C0C', -- ro
        red =    '#DB4D6D', -- nakabeni
        green =  '#227D51', -- midori
        yellow = '#F7C242', -- hanaba
        blue =   '#2EA9DF', -- tsuyukusa 
        magenta ='#66327C', -- fuji
        cyan =   '#1E88A8', -- hanaasagi
        white =  '#FCFAF2', -- shironeri
    },
    dim = {
        black =  '#1C1C1C', -- sumi
        red =    '#D05A6E', -- imayoh
        green =  '#2D6D4B', -- tokusa
        yellow = '#C18A26', -- kigaracha
        blue =   '#0B346E', -- rurikon
        magenta ='#533D5B', -- messhi
        cyan =   '#0C4842', -- onando
        white =  '#BDC0BA', -- shironezumi
    }
}

if wal.colors then
  common.colors = wal.colors
end

function common.fmt(res, symbol, text, fg, bg, instance)
  table.insert(res, {full_text = symbol, color = fg, background = bg, instance = instance})
  table.insert(res, {full_text = text, color = fg, background = bg, instance = instance, separator = true})
end

function common.execute_output(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

common.notify_level_low = 'low'
common.notify_level_normal = 'normal'
common.notify_level_critical = 'critical'

function common.notify(summary, body, lvl, expire_time)
  if not summary then summary = 'luastatus' end
  if not body then body = '' end
  if not lvl then lvl = common.notify_level_normal end
  if not expire_time then expire_time = 1500 end
  assert(os.execute(string.format(
        'notify-send --urgency=%s --expire-time=%d "%s" "%s"', lvl, expire_time, summary, body)))
end

-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
local function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))      
    else
      print(formatting .. v)
    end
  end
end

function common.dump (o)
  if type(o) == 'table' then
    tprint(o)
  else
    print(tostring(o))
  end
end

function common.split(input, at)
  local parsed = {}
  local m = '([^\n\r]+)'
  if at then
    m = string.format('([^%s]+)', at)
  end
  for f in input:gmatch(m) do
      table.insert(parsed, f)
  end
  return parsed
end

return common

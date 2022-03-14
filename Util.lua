local t = {}
local l = import("LrApplication")
local e = import("LrBinding")
local n = import("LrDate")
local p = import("LrDialogs")
local r = import("LrFileUtils")
local f = import("LrFunctionContext")
local m = import("LrHttp")
local e = import("LrPathUtils")
local o = import("LrProgressScope")
local s = import("LrTasks")
local i = import("LrLogger")
local a = import("LrUUID")
local o = import("LrView")
local o = import("LrErrors")
local o = import("LrPasswords")
local o = l.activeCatalog()
local c = e.child
local o = r.chooseUniqueFileName
local n = n.currentTime
local n = r.fileAttributes
local n = math.floor
local u = string.format
local n = a.generateUUID
local o = e.getStandardFilePath
local h = e.leafName
local d = s.pcall
local g = e.parent
local e = require("JSON")
local e = import("LrPrefs").prefsForPlugin()
local e = l.macAddressHash()
local n = i("Negative")
if _G.dev == true then
  n:enable("logfile")
else
  n:disable()
end
t.commandSeparator = WIN_ENV and " & " or " ; "
function t.safeExecute(e, i, u)
  return f.callWithContext("", function(f)
    local t, l
    f:addCleanupHandler(function()
      if t then
        r.delete(t)
      end
      if l then
        r.delete(l)
      end
    end)
    local a = a.generateUUID()
    if i == "error_only" then
      l = c(o("temp"), a .. ".err")
      e = e .. " 2>\"" .. l .. "\""
    elseif i then
      t = c(o("temp"), a .. ".out")
      e = e .. " > \"" .. t .. "\""
      if i == "separate" then
        l = c(o("temp"), a .. ".err")
        e = e .. " 2>\"" .. l .. "\""
      else
        e = e .. " 2>&1"
      end
    end
    if WIN_ENV then
      e = "\"" .. e .. "\""
    end
    n:trace("SAFE EXECUTE COMMAND: " .. e)
    local c = s.execute(e)
    local n, o, a = "", "", nil
    local function s(l, e)
      local e = string.format([[
Couldn't read output:
%s
%s]], l, e)
      if i == "separate" then
        return -1, "", e
      else
        return -1, e, ""
      end
    end
    if t then
      a, n = d(r.readFile, t)
      if not a then
        return s(t, n)
      end
    end
    if l then
      a, o = d(r.readFile, l)
      if not a then
        return s(l, o)
      end
    end
    if c ~= 0 then
      local l = 300
      local t = ""
      if l < #e then
        t = string.sub(e, 1, l) .. "..."
      else
        t = e
      end
      local e = ""
      if l < #n then
        e = string.sub(n, 1, l) .. "..."
      else
        e = n
      end
      p.message("Oops! Something went wrong...", "... as we were trying to " .. u .. [[


Command:
]] .. t .. [[


Error Message:
]] .. o .. [[

Exit Status: ]] .. c, "critical")
    end
    return c, n, o
  end)
end
function t.cdCommand(e)
  if MAC_ENV then
    return u("cd \"%s\"; ", e)
  end
  if e:sub(1, 2) == "\\\\" then
    error("Util.cdCommand: UNC paths not allowed: " .. e)
  end
  local e, l = e, ""
  while true do
    local t = g(e)
    if t == nil then
      break
    end
    l = "\\" .. h(e) .. l
    e = t
  end
  if e:sub(-1) == "\\" then
    e = e:sub(1, -2)
  end
  if l == "" then
    l = "\\"
  end
  return u("%s & cd \"%s\" & ", e, l)
end
function t.quote4Win(e)
  if WIN_ENV then
    return "\"" .. e .. "\""
  else
    return e
  end
end
function t.quote(e)
  return "\"" .. e .. "\""
end
function t.round(e)
  if 0 <= e then
    return math.floor(e + 0.5)
  else
    return math.ceil(e - 0.5)
  end
end
function t.postSerial(t, e)
  local e = e and "true" or "false"
  local l = "https://api.gumasdf.com/v2/licenses/verify"
  n:trace(l)
  local e = "product_permalink=asdf&license_key=" .. t .. "&increment_uses_count=" .. e
  n:trace(e)
  local t = {
    auth_header,
    {
      field = "Content-Type",
      value = "application/x-www-form-urlencoded"
    },
    {
      field = "User-Agent",
      value = "Lightroom Plugin"
    },
    {field = "Cookie", value = "GARBAGE"}
  }
  n:trace("added header")
  local l, e = m.post(l, e, t, "POST", 10)
  return l, e
end
return t
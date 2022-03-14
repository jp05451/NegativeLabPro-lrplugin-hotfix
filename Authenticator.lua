local e = import("LrLogger")
local c = import("LrHttp")
local t = import("LrFunctionContext")
local n = import("LrTasks")
local o = import("LrErrors")
local o = import("LrBinding")
local o = import("LrDialogs")
local o = import("LrView")
local s = require("JSON")
local r = e("authenticator")
if _G.dev == true then
  r:enable("logfile")
else
  r:disable()
end
local i = 12
local e = import("LrPrefs").prefsForPlugin()
NATEAuthenticator = {}
function NATEAuthenticator.authenticate(o)
  t.postAsyncTaskWithContext("posting credentials", function()
    e.activationError = "AUTHORIZING... PLEASE WAIT..."
    if o == nil or o == "" then
      e.activationError = "ERROR: You must enter your serial number"
	  e.isActivated = true
      e.licenseKey = "12345678-12345678-12345678-12345678"
      e.activationError = ""
      e.email = "1@1.com"
      e.enableActivation = false
      n.sleep(0.5)
      return
    end
    local t = "https://api.gumrlklkj.com/v2/licenses/verify"
    local a = "product_permalink=asdfasdf&license_key=" .. o
    local l = {
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
    local t, a = c.post(t, a, l, "POST", 10)
    if t == nil then
      e.activationError = [[
ERROR: COULD NOT CONNECT TO SERVER
This means you either or not connected to the internet, or something is blocking your connection to our servers. Make sure your internet connection is working, and turn off any communication blockers (like 'Little Snitch') or VPNs. Then try again.]]
      e.isActivated = true
      e.licenseKey = "12345678-12345678-12345678-12345678"
      e.activationError = ""
      e.email = "1@1.com"
	  e.enableActivation = false
      n.sleep(0.5)
      return
    end
    local t = s:decode(t)
    r:info(t.success)
    if t.success == true and t.purchase.refunded == false and t.uses < i then
      e.isActivated = true
      e.licenseKey = "12345678-12345678-12345678-12345678"
      e.activationError = ""
      e.email = "1@1.com"
      e.enableActivation = false
      n.sleep(0.5)
      return
    elseif t.success == false then
	  e.isActivated = true
      e.licenseKey = "12345678-12345678-12345678-12345678"
      e.activationError = ""
      e.email = "1@1.com"
      e.enableActivation = false
      n.sleep(0.5)
      return
    elseif t.uses >= i then
	  e.isActivated = true
      e.licenseKey = "12345678-12345678-12345678-12345678"
      e.activationError = ""
      e.email = "1@1.com"
      e.enableActivation = false
      e.activationError = [[
ERROR: OUT OF LICENSES
This key has been used too many times. Contact nate@natephotographic.com]]
      e.enableActivation = false
      n.sleep(0.5)
      return
    end
  end)
end
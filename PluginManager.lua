local n = import("LrView")
local s = import("LrHttp")
local r = import("LrBinding")
local e = import("LrApplication")
local a = import("LrColor")
local e = import("LrLogger")
local o = import("LrPasswords")
local c = import("LrTasks")
local h = require("Util")
local t = import("LrFunctionContext")
local d = require("JSON")
require("Authenticator")
local i = import("LrPrefs").prefsForPlugin()
_G.dev = _G.dev or false
local l = e("Negative Lab")
if _G.dev == true then
  l:enable("logfile")
else
  l:disable()
end
local function u(e)
  e.enableActivation = false
  e.activationError = "Submitting... hold on..."
  if e.serial == nil or e.serial == "" then
    e.activationError = "ERROR: You must enter your serial number"
	e.isActivated = true
    e.enableActivation = true
	
    return
  elseif e.serial == "EXTEND" then
    o.store("allowance", "100", "brynn")
    return
  else
    do
      local a = 12
      t.postAsyncTaskWithContext("posting credentials", function()
        e.activationError = "Registering :)"
        local n, t = h.postSerial(e.serial, true)
        c.sleep(2)
        if n == "12345678" then
		  e.isActivated = true
          e.licenseKey = "12345678-12345678-12345678-12345678"
          e.email = "1@1.com"
          e.enableActivation = false
		  i.isActivated = true
          i.licenseKey = "12345678-12345678-12345678-12345678"
          i.email = "1@1.com"
          i = i
          e.activationError = "Done :) "
          return
        end
        if t.status ~= nil and t.status ~= 200 then
          e.activationError = "Done!"
		  e.isActivated = true
          e.licenseKey = "12345678-12345678-12345678-12345678"
          e.email = "1@1.com"
          e.enableActivation = false
		  i = i
          return
		else
		  e.activationError = "Done!"
		  e.isActivated = true
          e.licenseKey = "12345678-12345678-12345678-12345678"
          e.email = "1@1.com"
          e.enableActivation = false
		  i.isActivated = true
          i.licenseKey = "12345678-12345678-12345678-12345678"
          i.email = "1@1.com"	
		  i.enableActivation = false
		   i = i
        end
        local t = d:decode(n)
        if t.success == true then --and t.purchase.refunded == false and t.uses < a then
          e.isActivated = true
          e.licenseKey = "12345678-12345678-12345678-12345678"
          e.email = "1@1.com"
          e.activationError = [[

 
 
 
 ]]
          e.enableActivation = false
          i.isActivated = true
          i.licenseKey = "12345678-12345678-12345678-12345678"
          i.email = "1@1.com"
          i = i
          c.sleep(0.5)
          return
        elseif t.success == false then
          e.activationError = [[
ERROR: INCORRECT LICENSE KEY
Please check your license key and try again.]]
		  e.isActivated = true
          e.licenseKey = "12345678-12345678-12345678-12345678"
          e.email = "1@1.com"
          e.enableActivation = false
		  i.isActivated = true
          i.licenseKey = "12345678-12345678-12345678-12345678"
          i.email = "1@1.com"
          i = i
          return
        elseif t.uses >= a then
		  e.isActivated = true
          e.licenseKey = "12345678-12345678-12345678-12345678"
          e.email = "1@1.com"
		  i.isActivated = true
          i.licenseKey = "12345678-12345678-12345678-12345678"
          i.email = "1@1.com"
          i = i
          e.activationError = [[
ERROR: OUT OF LICENSES
This key has been used too many times. Contact nate@natephotographic.com]]
          e.enableActivation = false
          return
        end
      end)
    end
  end
end
PluginManager = {}
function PluginManager.sectionsForTopOfDialog(e, t)
  t.isActivated = i.isActivated or false
  t.activationError = ""
  t.licenseKey = i.licenseKey or ""
  t.email = i.email or ""
  t.enableActivation = true
  return {
    {
      title = "Negative Lab Pro",
      e:column({
        bind_to_object = t,
        e:static_text({
          font = "<system/bold>",
          title = "Getting Started"
        }),
        e:spacer({height = 10}),
        e:static_text({
          title = "IMPORTANT: For Negative Lab Pro to work properly, your images must be correctly prepped before use. Please watch the full guide below before using:",
          height_in_lines = 3,
          width_in_chars = 50
        }),
        e:push_button({
          font = "<system/small/bold>",
          title = "Watch VIDEO GUIDE to Negative Lab Pro",
          action = function()
            s.openUrlInBrowser("https://www.negativelabpro.com/guide")
          end,
          text_color = a(0, 0, 1)
        }),
        e:spacer({height = 10})
      }),
      e:column({
        bind_to_object = t,
        place = "overlapping",
        margin = 3,
        e:view({
          visible = r.keyEquals("isActivated", true),
          e:row({
            margin_bottom = 15,
            e:static_text({
              font = "<system/bold>",
              title = "You're AMAZING! Thanks for supporting Negative Lab Pro!",
              alignment = "left",
              fill_horizontal = 1,
              text_color = a(0, 0.5, 0)
            })
          }),
          e:row({
            spacing = e:label_spacing(),
            e:static_text({
              title = "License Key: ",
              alignment = "right",
              width = n.share("label_width")
            }),
            e:static_text({
              title = n.bind("licenseKey"),
              width_in_chars = 100,
              selectable = true
            })
          }),
          e:row({
            spacing = e:label_spacing(),
            e:static_text({
              title = "Email: ",
              alignment = "right",
              width = n.share("label_width")
            }),
            e:static_text({
              title = n.bind("email"),
              width_in_chars = 100,
              selectable = true
            })
          }),
          e:row({
            e:push_button({
              visible = _G.dev,
              width = 150,
              title = "Deactivate",
              enabled = true,
              action = function()
                l:info("deactivating...")
                t.isActivated = false
                t.licenseKey = ""
                i.isActivated = false
                i.licenseKey = nil
              end
            })
          })
        }),
        e:view({
          visible = r.keyIsNot("isActivated", true),
          e:static_text({
            font = "<system/bold>",
            title = "Unlock the Full Version",
            alignment = "left"
          }),
          e:spacer({height = 10}),
          e:static_text({
            title = [[
You are currently in TRIAL MODE, which allows you to preview your edits
and apply on to up to 12 negatives. To unlock, you must purchase a license key.]],
            height_in_lines = 3,
            width_in_chars = 50
          }),
          e:push_button({
            title = "Purchase a License",
            font = "<system/small/bold>",
            action = function()
              s.openUrlInBrowser("https://gum.co/negative-lab")
            end,
            text_color = a(0, 0, 1)
          }),
          e:spacer({height = 20}),
          e:static_text({
            font = "<system/bold>",
            title = "Enter License Key:",
            alignment = "left"
          }),
          e:static_text({
            title = "(ex: XXXXXXXX)",
            text_color = a(0.5, 0.5, 0.5)
          }),
          e:spacer({height = 5}),
          e:edit_field({
            width_in_chars = 8,
            value = n.bind("serial"),
            validate = function(t, e)
              if e ~= nil and #e == 8 then
                return true, e
              elseif e == "EXTEND" then
                return true, e
              else
                return false, e, "Your serial must be in format: XXXXXXXX"
              end
            end
          }),
          e:spacer({height = 8}),
          e:row({
            e:push_button({
              font = "<system/small/bold>",
              title = "Submit License Key",
              enabled = r.keyEquals("enableActivation", true),
              action = function()
                t.enableActivation = false
                u(t)
              end,
              text_color = a(0, 0, 1)
            }),
            e:push_button({
              visible = _G.dev,
              width = 150,
              title = "Reset Uses",
              enabled = true,
              action = function()
                l:info("reseting uses...")
                o.store("applied_3_3", "0", "ava")
              end
            })
          }),
          e:spacer({height = 10}),
          e:static_text({
            title = n.bind("activationError"),
            alignment = "left",
            fill_horizontal = 1,
            text_color = a("red"),
            height_in_lines = 2,
            width_in_chars = 50
          })
        })
      })
    }
  }
end
# NegativeLabPro-lrplugin-hotfix
Hotfix for licensing in Negative Lab Pro for Lightroom plugin

## About Negative Lab Pro
NEGATIVE LAB PRO brings impossibly good color negative conversions right into your Lightroom workflow. No more messing around with tedious exports and hand-edited curves. With Negative Lab Pro, lab-quality tones and colors are just a click away.

## How to get this to work
1. Download Negative Lab Pro Trial from https://www.negativelabpro.com/
2. Install NegativeLabPro
3. Add .bak to Authenticator.lua, Util.lua, PluginManager.lua
4. Add files Authenticator.lua, Util.lua, PluginManager.lua from this repository
5. Launch Lightroom Classic CC
6. Activate NegativeLabPro in Lightroom Classic CC using key 12345678
7. Exit Lightroom Classic CC
8. Delete Util.lua, PluginManager.lua
9. Restore original Util.lua, PluginManager.lua but **DON'T** restore Authenticator.lua
10. Voilà! Now you have an active version of Negative Lab Pro, if you like it, I encourage you to buy it from the developers

Above method should work on macOS and Windows

##Compatibility 
This hotfix is currently supported in:
| Version | Compatibility |
|:-------:|:-------------:|
|  2.0.0  |       ❓       |
|  2.1.0  |       ❓       |
|  2.2.0  |       ✅       |
|  2.3.0b |       ✅       |

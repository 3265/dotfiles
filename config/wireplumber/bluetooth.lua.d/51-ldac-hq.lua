-- WirePlumber 0.4 (Lua config). Pin LDAC to 990kbps instead of the
-- default "auto" (adaptive 330-990kbps). auto / hq=990 / sq=660 / mq=330.
-- Drop back to "auto" if audio stutters at distance.
table.insert(bluez_monitor.rules, {
  matches = { { { "device.name", "matches", "bluez_card.*" } } },
  apply_properties = {
    ["bluez5.a2dp.ldac.quality"] = "hq",
  },
})

local nt = require "luci.sys".net

m = Map("packet-armour", "Packet Armour", "Here you can set the Packet Armour Configuration")
s = m:section(TypedSection, "packet-armour", "Packet Armour Settings")
s.anonymous = true

e = s:option(Flag, "hosts", "Enable Device Verification")
e.disabled = 0
e.rmempty = false

d = m:section(TypedSection, "packet-armour", "Device Settings")
d.anonymous = true
d:tab("hosts", "Allowed Devices")
ml = d:taboption("hosts", DynamicList, "host")
ml.datatype = "macaddr"
nt.mac_hints(function(mac, name) ml:value(mac, "%s (%s)" %{ mac, name }) end)

return m

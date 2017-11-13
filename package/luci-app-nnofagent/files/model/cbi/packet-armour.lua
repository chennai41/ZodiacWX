m = Map("packet-armour", "Control", "Here you can set the Network Control configuration.")
s = m:section(TypedSection, "packet-armour", "Packet Armour Settings")
s.anonymous = true

e = s:option(Flag, "hosts", "Enable Host Verification")
e.disabled = 0
e.rmempty = false

return m

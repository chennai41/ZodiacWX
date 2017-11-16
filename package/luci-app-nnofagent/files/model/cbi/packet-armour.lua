m = Map("packet-armour", "Packet Armour", "Here you can set the Packet Armour configuration.")
s = m:section(TypedSection, "packet-armour", "Packet Armour Settings")
s.anonymous = true

e = s:option(Flag, "hosts", "Enable Host Verification")
e.disabled = 0
e.rmempty = false

return m

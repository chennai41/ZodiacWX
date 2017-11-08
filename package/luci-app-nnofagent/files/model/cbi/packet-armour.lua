m = Map("nnofagent", "Control", "Here you can set the Network Control configuration.")
s = m:section(TypedSection, "nnofagent", "Packet Armour Settings")
s.anonymous = true

e = s:option(Flag, "hosts", "Enable Host Verification")
e.disabled = 0
e.rmempty = false

return m

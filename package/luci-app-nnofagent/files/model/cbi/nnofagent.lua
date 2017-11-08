m = Map("nnofagent", "Control", "Here you can set the Network Control configuration.")
g = m:section(TypedSection, "nnofagent", "Settings")
g.anonymous = true
e = g:option(ListValue, "enabled", "Controller")
e.default = "0"
e:value("0", "Off")
e:value("1", "OpenFlow")
e:value("2", "Packet Armour")
e.disabled = 0
e.rmempty = false


s = m:section(TypedSection, "nnofagent", "OpenFlow")
s.anonymous = true

e = s:option(Flag, "auth_bypass", "Auth Bypass")
e.disabled = 0
e.rmempty = false

e = s:option(Flag, "secure", "Secure Disconnect")
e.disabled = 0
e.rmempty = false

s:option(Value, "controller_ip", "IP Address")
s:option(Value, "controller_port", "Port")

return m

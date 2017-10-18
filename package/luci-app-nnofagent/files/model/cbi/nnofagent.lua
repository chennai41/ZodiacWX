m = Map("nnofagent", "OpenFlow", "Here you can set the OpenFlow controller configuration.")
g = m:section(TypedSection, "nnofagent", "General Settings")
g.anonymous = true
e = g:option(Flag, "enabled", "OpenFlow Enabled")
e.disabled = 0
e.rmempty = false

e = g:option(Flag, "auth_bypass", "Auth Bypass")
e.disabled = 0
e.rmempty = false

e = g:option(Flag, "secure", "Secure Disconnect")
e.disabled = 0
e.rmempty = false

s = m:section(TypedSection, "nnofagent", "Controller Settings")
s.anonymous = true
s:option(Value, "controller_ip", "IP Address")
s:option(Value, "controller_port", "Port")


return m

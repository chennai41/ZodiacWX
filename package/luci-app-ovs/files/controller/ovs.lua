module("luci.controller.ovs", package.seeall)

function index()

	entry({"admin", "OpenFlow"}, firstchild(), "OpenFlow", 60).dependent=false
	entry({"admin", "OpenFlow", "flows"}, call("action_flows"), _("Flows"), 3)
	entry({"admin", "OpenFlow", "groups"}, call("action_groups"), _("Groups"), 4)
	entry({"admin", "OpenFlow", "ports"}, call("action_ports"), _("Ports"), 5)
	entry({"admin", "OpenFlow", "tables"}, call("action_tables"), _("Tables"), 6)

end

-- Get flow output
function action_flows()
	local flows = luci.sys.exec("ovs-ofctl -O OpenFlow13 dump-flows ovslan")
	luci.template.render("flows", {flows=flows})
end

-- Get groups output
function action_groups()
	local groups = luci.sys.exec("ovs-ofctl -O OpenFlow13 dump-groups ovslan")
	luci.template.render("groups", {groups=groups})
end

-- Get ports output
function action_ports()
	local ports = luci.sys.exec("ovs-ofctl -O OpenFlow13 dump-ports ovslan")
	luci.template.render("ports", {ports=ports})
end

-- Get table output
function action_tables()
	local tables = luci.sys.exec("ovs-ofctl -O OpenFlow13 dump-tables ovslan")
	luci.template.render("tables", {tables=tables})
end
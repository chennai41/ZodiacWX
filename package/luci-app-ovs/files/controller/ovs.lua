module("luci.controller.ovs", package.seeall)

function index()

	entry({"admin", "OpenFlow"}, firstchild(), "OpenFlow", 60).dependent=false
	entry({"admin", "OpenFlow", "flowtable"}, call("action_flowtable"), _("Flow Table"), 3)
	entry({"admin", "OpenFlow", "groups"}, call("action_groups"), _("Groups"), 4)
	entry({"admin", "OpenFlow", "meters"}, call("action_meters"), _("Meters"), 5)

end

-- Get flow table output
function action_flowtable()
	local flowtable = luci.sys.exec("ovs-ofctl dump-flows ovslan")
	luci.template.render("flowtable", {flowtable=flowtable})
end

-- Get groups output
function action_groups()
	local groups = luci.sys.exec("ovs-ofctl dump-groups ovslan")
	luci.template.render("groups", {groups=groups})
end

-- Get meters output
function action_meters()
	local meters = luci.sys.exec("ovs-ofctl dump-meters ovslan")
	luci.template.render("meters", {meters=meters})
end

module("luci.controller.nnofagent", package.seeall)

function index()
    -- dont show unless nnofagent package is installed
    --
    if not nixio.fs.access("/etc/config/nnofagent") then
       return
    end

	entry({"admin", "openflow"}, firstchild(), "OpenFlow", 60).dependent=false
	entry({"admin", "openflow", "nnofagent"}, cbi("nnofagent"), _("Controller"), 1)
	entry({"admin", "openflow", "flowtable"}, call("action_flowtable"), _("Flow Table"), 2)
	entry({"admin", "openflow", "groups"}, call("action_groups"), _("Groups"), 3)
	entry({"admin", "openflow", "meters"}, call("action_meters"), _("Meters"), 4)

end

-- Get flow table output
function action_flowtable()
	local flowtable = luci.sys.exec("nnofagent -f")
	luci.template.render("flowtable", {flowtable=flowtable})
end

-- Get groups output
function action_groups()
	local groups = luci.sys.exec("nnofagent -g")
	luci.template.render("groups", {groups=groups})
end

-- Get meters output
function action_meters()
	local meters = luci.sys.exec("nnofagent -m")
	luci.template.render("meters", {meters=meters})
end

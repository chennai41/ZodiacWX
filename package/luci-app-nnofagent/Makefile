#
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-nnofagent
PKG_VERSION:=1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-nnofagent
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=OpenFlow LuCI module
	PKGARCH:=all
	DEPENDS:=+nnofagent
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-nnofagent/install
		$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
		$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view
		$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
		$(INSTALL_DIR) $(1)/etc/uci-defaults
		$(CP) ./files/controller/nnofagent.lua \
		$(1)/usr/lib/lua/luci/controller/
		$(CP) ./files/model/cbi/nnofagent.lua \
		$(1)/usr/lib/lua/luci/model/cbi/
		$(CP) ./files/model/cbi/packet-armour.lua \
		$(1)/usr/lib/lua/luci/model/cbi/
		$(CP) ./files/view/flowtable.htm \
		$(1)/usr/lib/lua/luci/view/
		$(CP) ./files/view/groups.htm \
		$(1)/usr/lib/lua/luci/view/
		$(CP) ./files/view/meters.htm \
		$(1)/usr/lib/lua/luci/view/
endef

define Package/luci-app-nnofagent/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	if [ -f /etc/uci-defaults/nnofagent ]; then
	( . /etc/uci-defaults/nnofagent ) && rm -f /etc/uci-defaults/nnofagent
	fi
	if [ -f /etc/uci-defaults/packet-armour ]; then
	( . /etc/uci-defaults/packet-armour ) && rm -f /etc/uci-defaults/packet-armour
	fi
}
endef

$(eval $(call BuildPackage,luci-app-nnofagent))

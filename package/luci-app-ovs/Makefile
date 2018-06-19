#
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ovs
PKG_VERSION:=1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-ovs
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=Open vSwitch LuCI module
	PKGARCH:=all
	DEPENDS:=
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-ovs/install
		$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
		$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view
		$(CP) ./files/controller/ovs.lua \
		$(1)/usr/lib/lua/luci/controller/
		$(CP) ./files/view/flowtable.htm \
		$(1)/usr/lib/lua/luci/view/
		$(CP) ./files/view/groups.htm \
		$(1)/usr/lib/lua/luci/view/
		$(CP) ./files/view/meters.htm \
		$(1)/usr/lib/lua/luci/view/
endef

$(eval $(call BuildPackage,luci-app-ovs))

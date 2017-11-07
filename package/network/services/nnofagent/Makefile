#
# Copyright (C) 2017 Northbound Networks
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

#TARGET_CFLAGS += -ggdb3

PKG_NAME:=nnofagent
PKG_VERSION:=20171107_1
PKG_RELEASE=1

PKG_LICENSE:=GPL-3.0
PKG_SOURCE_URL:=https://github.com/NorthboundNetworks/nnofagent.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2017-11-07
PKG_SOURCE_VERSION:=1869c70b8152f45fa1bb5625afb05adbe39db0b2
PKG_MAINTAINER:=Paul Zanna <paul@northboundnetworks.com>

include $(INCLUDE_DIR)/package.mk

define Package/nnofagent
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE:=Northbound Networks OpenFlow agent
  DEPENDS:=
endef

define Package/nnofagent/description
	Used by nnopenflow to talk to an external OpenFlow controller.
endef

define Package/nnofagent/conffiles
	/etc/config/nnofagent
endef

define Package/nnofagent/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/nnofagent $(1)/usr/sbin/nnofagent
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/nnofagent.config $(1)/etc/config/nnofagent
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/nnofagent.init $(1)/etc/init.d/nnofagent
endef

$(eval $(call BuildPackage,nnofagent))

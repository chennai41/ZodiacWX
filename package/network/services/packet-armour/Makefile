#
# Copyright (C) 2017 Northbound Networks
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

#TARGET_CFLAGS += -ggdb3

PKG_NAME:=packet-armour
PKG_VERSION:=20171107_1
PKG_RELEASE=1

PKG_LICENSE:=GPL-3.0
PKG_SOURCE_URL:=https://github.com/NorthboundNetworks/packet-armour.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2017-11-07
PKG_SOURCE_VERSION:=1869c70b8152f45fa1bb5625afb05adbe39db0b2
PKG_MAINTAINER:=Paul Zanna <paul@northboundnetworks.com>

include $(INCLUDE_DIR)/package.mk

define Package/packet-armour
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE:=Northbound Networks Packet Armour
  DEPENDS:=+nnofagent
endef

define Package/packet-armour/description
	Protects wireless network devices.
endef

define Package/packet-armour/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/packet-armour $(1)/usr/sbin/packet-armour
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/packet-armour.config $(1)/etc/config/packet-armour
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/packet-armour.init $(1)/etc/init.d/packet-armour
endef

$(eval $(call BuildPackage,packet-armour))

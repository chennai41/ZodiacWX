#
# Copyright (C) 2017 Northbound Networks
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nn-openflow
PKG_VERSION:=20171010_4
PKG_RELEASE=1

PKG_LICENSE:=GPL-3.0
PKG_SOURCE_URL:=https://github.com/NorthboundNetworks/nn-openflow.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2017-10-10
PKG_SOURCE_VERSION:=67b137a93d8d70e4edd543fb2791c79bf0f84444
PKG_MAINTAINER:=Paul Zanna <paul@northboundnetworks.com>


include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/nn-openflow
  SUBMENU:=Wireless Drivers
  TITLE:=Northbound Networks OpenFlow driver
  URL:=https://github.com/pzanna/nn-openflow
  DEPENDS:=
  FILES:=$(PKG_BUILD_DIR)/nn-openflow.ko
  AUTOLOAD:=$(call AutoLoad,41,nn-openflow,1)
endef

define KernelPackage/nn-openflow/description
  Driver for the Northbound Networks OpenFlow Engine
endef

MAKE_OPTS:= \
	ARCH="$(LINUX_KARCH)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	SUBDIRS="$(PKG_BUILD_DIR)" \
	$(EXTRA_KCONFIG)

define Build/Compile
	 $(MAKE) -C "$(LINUX_DIR)" \
		$(MAKE_OPTS) \
		modules
endef

$(eval $(call KernelPackage,nn-openflow))

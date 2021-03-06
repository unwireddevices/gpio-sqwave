#
# Copyright (C) 2008-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=gpio-meander
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define KernelPackage/gpio-sqwave
  SUBMENU:=Other modules
  DEPENDS:=@!LINUX_3_3
  TITLE:=Timer IRQ handler
  FILES:=$(PKG_BUILD_DIR)/gpio-sqwave.ko
  AUTOLOAD:=$(call AutoLoad,30,gpio-sqwave,1)
  KCONFIG:=
endef

define KernelPackage/gpio-sqwave/description
 This is GPIO square wave generator for AR9331 devices.
endef

MAKE_OPTS:= \
	ARCH="$(LINUX_KARCH)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	SUBDIRS="$(PKG_BUILD_DIR)"

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		$(MAKE_OPTS) \
		modules
endef

$(eval $(call KernelPackage,gpio-sqwave))

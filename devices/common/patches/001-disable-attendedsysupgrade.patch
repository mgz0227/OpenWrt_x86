From 0f08e0731b2d50435be03628eb516c1545cd4881 Mon Sep 17 00:00:00 2001
From: gongzi miao <miaogongzi0227@gmail.com>
Date: Sun, 14 Dec 2025 03:17:23 +0800
Subject: [PATCH] Revert "collections: Add luci-app-attendedsysupgrade as
 default"

This reverts commit dcf699c569cb34f895f9f00432268d83c9d2a206.
---
 collections/luci-nginx/Makefile       | 1 -
 collections/luci-ssl-openssl/Makefile | 3 +--
 collections/luci-ssl/Makefile         | 3 +--
 collections/luci/Makefile             | 3 +--
 4 files changed, 3 insertions(+), 7 deletions(-)

--- a/feeds/luci/collections/luci-nginx/Makefile
+++ b/feeds/luci/collections/luci-nginx/Makefile
@@ -15,7 +15,6 @@ LUCI_DEPENDS:= \
 	+IPV6:luci-proto-ipv6 \
 	+luci-app-firewall \
 	+luci-app-package-manager \
-	+luci-app-attendedsysupgrade \
 	+luci-mod-admin-full \
 	+luci-proto-ppp \
 	+luci-theme-bootstrap \

--- a/feeds/luci/collections/luci-ssl-openssl/Makefile
+++ b/feeds/luci/collections/luci-ssl-openssl/Makefile
@@ -17,8 +17,7 @@ LUCI_DESCRIPTION:=LuCI with OpenSSL as the SSL backend (libustream-openssl). \
 LUCI_DEPENDS:=+luci-light \
 	+libustream-openssl \
 	+openssl-util \
-	+luci-app-package-manager \
-	+luci-app-attendedsysupgrade
+	+luci-app-package-manager
 
 PKG_LICENSE:=Apache-2.0
 

--- a/feeds/luci/collections/luci-ssl/Makefile
+++ b/feeds/luci/collections/luci-ssl/Makefile
@@ -13,8 +13,7 @@ LUCI_TITLE:=LuCI with HTTPS support (mbedtls as SSL backend)
 LUCI_DEPENDS:=+luci-light \
 	+libustream-mbedtls \
 	+px5g-mbedtls \
-	+luci-app-package-manager \
-	+luci-app-attendedsysupgrade
+	+luci-app-package-manager
 
 PKG_LICENSE:=Apache-2.0
 

--- a/feeds/luci/collections/luci/Makefile
+++ b/feeds/luci/collections/luci/Makefile
@@ -13,8 +13,7 @@ LUCI_TITLE:=LuCI interface with Uhttpd as Webserver (default)
 LUCI_DESCRIPTION:=Standard OpenWrt set including package management and attended sysupgrades support
 LUCI_DEPENDS:= \
 	+luci-light \
-	+luci-app-package-manager \
-	+luci-app-attendedsysupgrade
+	+luci-app-package-manager
 
 PKG_LICENSE:=Apache-2.0


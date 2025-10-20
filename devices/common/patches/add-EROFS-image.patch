--- a/include/image.mk
+++ b/include/image.mk
@@ -86,6 +86,8 @@
 SQUASHFSOPT := -b $(SQUASHFS_BLOCKSIZE)
 SQUASHFSOPT += -p '/dev d 755 0 0' -p '/dev/console c 600 0 0 5 1'
 SQUASHFSOPT += $(if $(CONFIG_SELINUX),-xattrs,-no-xattrs)
+SQUASHFSOPT += -block-readers $(CONFIG_TARGET_SQUASHFS_BLOCK_READERS)
+SQUASHFSOPT += -small-readers $(CONFIG_TARGET_SQUASHFS_SMALL_READERS)
 SQUASHFSCOMP := gzip
 LZMA_XZ_OPTIONS := -Xpreset 9 -Xe -Xlc 0 -Xlp 2 -Xpb 2
 ifeq ($(CONFIG_SQUASHFS_XZ),y)
@@ -97,11 +99,22 @@
 
 JFFS2_BLOCKSIZE ?= 64k 128k
 
+EROFS_PCLUSTERSIZE := $(shell echo $$(($(CONFIG_TARGET_EROFS_PCLUSTER_SIZE)*1024)))
+EROFSOPT := -C$(EROFS_PCLUSTERSIZE)
+EROFSOPT += -Efragments,dedupe,ztailpacking -Uclear --all-root
+EROFSOPT += $(if $(SOURCE_DATE_EPOCH),-T$(SOURCE_DATE_EPOCH) --ignore-mtime)
+EROFSOPT += $(if $(CONFIG_SELINUX),,-x-1)
+EROFSCOMP := lz4hc,12
+ifeq ($(CONFIG_EROFS_FS_ZIP_LZMA),y)
+EROFSCOMP := lzma,109
+endif
+
 fs-types-$(CONFIG_TARGET_ROOTFS_SQUASHFS) += squashfs
 fs-types-$(CONFIG_TARGET_ROOTFS_JFFS2) += $(addprefix jffs2-,$(JFFS2_BLOCKSIZE))
 fs-types-$(CONFIG_TARGET_ROOTFS_JFFS2_NAND) += $(addprefix jffs2-nand-,$(NAND_BLOCKSIZE))
 fs-types-$(CONFIG_TARGET_ROOTFS_EXT4FS) += ext4
 fs-types-$(CONFIG_TARGET_ROOTFS_UBIFS) += ubifs
+fs-types-$(CONFIG_TARGET_ROOTFS_EROFS) += erofs
 fs-subtypes-$(CONFIG_TARGET_ROOTFS_JFFS2) += $(addsuffix -raw,$(addprefix jffs2-,$(JFFS2_BLOCKSIZE)))
 
 TARGET_FILESYSTEMS := $(fs-types-y)
@@ -307,10 +320,16 @@
 		$@ $(call mkfs_target_dir,$(1))/
 endef
 
+# Don't use the mkfs.erofs builtin $SOURCE_DATE_EPOCH behavior
+define Image/mkfs/erofs
+	env -u SOURCE_DATE_EPOCH $(STAGING_DIR_HOST)/bin/mkfs.erofs -z$(EROFSCOMP) $(EROFSOPT) \
+		$@ $(call mkfs_target_dir,$(1))
+endef
+
 define Image/Manifest
 	$(if $(CONFIG_USE_APK), \
 		$(call apk,$(TARGET_DIR_ORIG)) list --quiet --manifest --no-network \
-			--repositories-file /dev/zero | sort | sed 's/ / - /'  > \
+			--repositories-file /dev/null | sort | sed 's/ / - /'  > \
 			$(BIN_DIR)/$(IMG_PREFIX)$(if $(PROFILE_SANITIZED),-$(PROFILE_SANITIZED)).manifest, \
 		$(call opkg,$(TARGET_DIR_ORIG)) list-installed > \
 			$(BIN_DIR)/$(IMG_PREFIX)$(if $(PROFILE_SANITIZED),-$(PROFILE_SANITIZED)).manifest \
@@ -365,19 +384,17 @@
 
 apk_target = \
 	$(call apk,$(mkfs_cur_target_dir)) --no-scripts \
-		--repositories-file /dev/zero --repository file://$(PACKAGE_DIR_ALL)/packages.adb
+		--repositories-file /dev/null --repository file://$(PACKAGE_DIR_ALL)/packages.adb
 
 
 target-dir-%: FORCE
 ifneq ($(CONFIG_USE_APK),)
 	rm -rf $(mkfs_cur_target_dir)
 	$(CP) $(TARGET_DIR_ORIG) $(mkfs_cur_target_dir)
-	mv $(mkfs_cur_target_dir)/etc/apk/repositories $(mkfs_cur_target_dir).repositories
 	$(if $(mkfs_packages_remove), \
-		$(apk_target) del $(mkfs_packages_remove))
+		-$(apk_target) del $(mkfs_packages_remove))
 	$(if $(mkfs_packages_add), \
 		$(apk_target) add $(mkfs_packages_add))
-	mv $(mkfs_cur_target_dir).repositories $(mkfs_cur_target_dir)/etc/apk/repositories
 else
 	rm -rf $(mkfs_cur_target_dir) $(mkfs_cur_target_dir).opkg
 	$(CP) $(TARGET_DIR_ORIG) $(mkfs_cur_target_dir)
@@ -658,6 +675,8 @@
 	VERSION_NUMBER="$(VERSION_NUMBER)" \
 	VERSION_CODE="$(VERSION_CODE)" \
 	SUPPORTED_DEVICES="$$(SUPPORTED_DEVICES)" \
+	KERNEL_SIZE="$$(KERNEL_SIZE)" \
+	IMAGE_SIZE="$$(IMAGE_SIZE)" \
 	$(TOPDIR)/scripts/json_add_image_info.py $$@
 endef
 endif
@@ -792,6 +811,8 @@
 	VERSION_NUMBER="$(VERSION_NUMBER)" \
 	VERSION_CODE="$(VERSION_CODE)" \
 	SUPPORTED_DEVICES="$(SUPPORTED_DEVICES)" \
+	KERNEL_SIZE="$(KERNEL_SIZE)" \
+	IMAGE_SIZE="$(IMAGE_SIZE)" \
 	$(TOPDIR)/scripts/json_add_image_info.py $$@
 
 endef
@@ -846,6 +867,8 @@
 	VERSION_NUMBER="$(VERSION_NUMBER)" \
 	VERSION_CODE="$(VERSION_CODE)" \
 	SUPPORTED_DEVICES="$(SUPPORTED_DEVICES)" \
+	KERNEL_SIZE="$(KERNEL_SIZE)" \
+	IMAGE_SIZE="$(IMAGE_SIZE)" \
 	$(TOPDIR)/scripts/json_add_image_info.py $$@
 
 endef

--- a/scripts/target-metadata.pl
+++ b/scripts/target-metadata.pl
@@ -18,6 +18,7 @@
 		/^dt$/ and $ret .= "\tselect USES_DEVICETREE\n";
 		/^dt-overlay$/ and $ret .= "\tselect HAS_DT_OVERLAY_SUPPORT\n";
 		/^emmc$/ and $ret .= "\tselect EMMC_SUPPORT\n";
+		/^erofs$/ and $ret .= "\tselect USES_EROFS\n";
 		/^ext4$/ and $ret .= "\tselect USES_EXT4\n";
 		/^fpu$/ and $ret .= "\tselect HAS_FPU\n";
 		/^gpio$/ and $ret .= "\tselect GPIO_SUPPORT\n";

--- a/target/Config.in
+++ b/target/Config.in
@@ -69,6 +69,9 @@
 config USES_EXT4
 	bool
 
+config USES_EROFS
+	bool
+
 config USES_TARGZ
 	bool
 

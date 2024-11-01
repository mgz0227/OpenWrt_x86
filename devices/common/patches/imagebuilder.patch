--- a/include/image.mk
+++ b/include/image.mk
@@ -504,7 +504,6 @@ define Device/Check
   endif
 endef
 
-ifndef IB
 define Device/Build/initramfs
   $(call Device/Export,$(KDIR)/tmp/$$(KERNEL_INITRAMFS_IMAGE),$(1))
   $$(_TARGET): $$(if $$(KERNEL_INITRAMFS),$(BIN_DIR)/$$(KERNEL_INITRAMFS_IMAGE) \
@@ -557,7 +556,6 @@ define Device/Build/initramfs
 	SUPPORTED_DEVICES="$$(SUPPORTED_DEVICES)" \
 	$(TOPDIR)/scripts/json_add_image_info.py $$@
 endef
-endif
 
 define Device/Build/compile
   $$(_COMPILE_TARGET): $(KDIR)/$(1)
@@ -623,7 +621,7 @@ define Device/Build/kernel
 endef
 
 define Device/Build/image
-  GZ_SUFFIX := $(if $(filter %dtb %gz,$(2)),,$(if $(and $(findstring ext4,$(1)),$(CONFIG_TARGET_IMAGES_GZIP)),.gz))
+  GZ_SUFFIX := $(if $(filter %dtb %gz,$(2)),,$(if $(and $(findstring ext4,$(1)),$(findstring img,$(2)),$(CONFIG_TARGET_IMAGES_GZIP)),.gz))
   $$(_TARGET): $(if $(CONFIG_JSON_OVERVIEW_IMAGE_INFO), \
 	  $(BUILD_DIR)/json_info_files/$(call DEVICE_IMG_NAME,$(1),$(2)).json, \
 	  $(BIN_DIR)/$(call DEVICE_IMG_NAME,$(1),$(2))$$(GZ_SUFFIX))
@@ -761,6 +761,7 @@ define Device/DumpInfo
 Target-Profile: DEVICE_$(1)
 Target-Profile-Name: $(DEVICE_DISPLAY)
 Target-Profile-Packages: $(DEVICE_PACKAGES)
+Target-Profile-ImageSize: $(IMAGE_SIZE)
 Target-Profile-hasImageMetadata: $(if $(foreach image,$(IMAGES),$(findstring append-metadata,$(IMAGE/$(image)))),1,0)
 Target-Profile-SupportedDevices: $(SUPPORTED_DEVICES)
 $(if $(BROKEN),Target-Profile-Broken: $(BROKEN))

--- a/scripts/metadata.pm
+++ b/scripts/metadata.pm
@@ -150,6 +150,7 @@ sub parse_target_metadata($) {
 			push @{$target->{profiles}}, $profile;
 		};
 		/^Target-Profile-Name:\s*(.+)\s*$/ and $profile->{name} = $1;
+		/^Target-Profile-ImageSize:\s*(.*)\s*/ and $profile->{image_size} = $1;
 		/^Target-Profile-hasImageMetadata:\s*(\d+)\s*$/ and $profile->{has_image_metadata} = $1;
 		/^Target-Profile-SupportedDevices:\s*(.+)\s*$/ and $profile->{supported_devices} = [ split(/\s+/, $1) ];
 		/^Target-Profile-Priority:\s*(\d+)\s*$/ and do {

--- a/target/imagebuilder/Makefile
+++ b/target/imagebuilder/Makefile
@@ -26,10 +26,10 @@
 
 all: compile
 
-$(BIN_DIR)/$(IB_NAME).tar.zst: clean
+$(BIN_DIR)/$(IB_NAME).tar.xz: clean
 	rm -rf $(PKG_BUILD_DIR)
 	mkdir -p $(IB_KDIR) $(IB_LDIR) $(PKG_BUILD_DIR)/staging_dir/host/lib \
-		$(PKG_BUILD_DIR)/target/linux $(PKG_BUILD_DIR)/scripts $(IB_DTSDIR)
+		$(PKG_BUILD_DIR)/target $(PKG_BUILD_DIR)/scripts $(IB_DTSDIR)
 	-cp $(TOPDIR)/.config $(PKG_BUILD_DIR)/.config
 	$(SED) 's/^CONFIG_BINARY_FOLDER=.*/# CONFIG_BINARY_FOLDER is not set/' $(PKG_BUILD_DIR)/.config
 	$(SED) 's/^CONFIG_DOWNLOAD_FOLDER=.*/# CONFIG_DOWNLOAD_FOLDER is not set/' $(PKG_BUILD_DIR)/.config
@@ -37,9 +37,11 @@
 		$(INCLUDE_DIR) $(SCRIPT_DIR) \
 		$(TOPDIR)/rules.mk \
 		./files/Makefile \
+		./files/repositories.conf \
 		$(TMP_DIR)/.targetinfo \
 		$(TMP_DIR)/.packageinfo \
-		$(PKG_BUILD_DIR)/
+		$(TOPDIR)/files \
+		$(PKG_BUILD_DIR)/ || true
 
 	$(INSTALL_DIR) $(PKG_BUILD_DIR)/packages
 
@@ -52,12 +54,13 @@
 
 	$(INSTALL_DATA) ./files/README.apk.md $(PKG_BUILD_DIR)/packages/README.md
 else
-  ifeq ($(CONFIG_IB_STANDALONE),)
+
 	echo '## Remote package repositories' >> $(PKG_BUILD_DIR)/repositories.conf
 	$(call FeedSourcesAppendOPKG,$(PKG_BUILD_DIR)/repositories.conf)
 	$(VERSION_SED_SCRIPT) $(PKG_BUILD_DIR)/repositories.conf
-
-  endif
+	$(SED) 's/^src\/gz \(.*\) https.*ai\/\(.*packages.*\)/src \1 file:\/\/www\/wwwroot\/op.miaogongzi.cc\/\2/' $(PKG_BUILD_DIR)/repositories.conf
+	$(SED) 's/^src\/gz \(.*\) https.*ai\/\(.*targets.*\)/src \1 file:\/\/www\/wwwroot\/op.miaogongzi.cc\/\2/' $(PKG_BUILD_DIR)/repositories.conf
+	$(SED) '/openwrt_core/d' $(PKG_BUILD_DIR)/repositories.conf
 
 	# create an empty package index so `opkg` doesn't report an error
 	touch $(PKG_BUILD_DIR)/packages/Packages


--- a/target/imagebuilder/files/Makefile
+++ b/target/imagebuilder/files/Makefile
@@ -131,6 +131,26 @@ BUILD_PACKAGES:=$(sort $(DEFAULT_PACKAGES) $($(USER_PROFILE)_PACKAGES) kernel)
 # "-pkgname" in the package list means remove "pkgname" from the package list
 BUILD_PACKAGES:=$(filter-out $(filter -%,$(BUILD_PACKAGES)) $(patsubst -%,%,$(filter -%,$(BUILD_PACKAGES))),$(BUILD_PACKAGES))
 BUILD_PACKAGES:=$(USER_PACKAGES) $(BUILD_PACKAGES)
+IMAGE_SIZE_VALUE := $(shell echo $($(USER_PROFILE)_IMAGE_SIZE) | sed 's/k$$//')
+ifdef IMAGE_SIZE_VALUE
+  ifeq ($(shell test $(IMAGE_SIZE_VALUE) -lt 20480 && echo true),true)
+    SMALL_FLASH := true
+  endif
+endif
+ifneq ($(findstring usb,$(BUILD_PACKAGES)),)
+    BUILD_PACKAGES += automount luci-app-diskman
+endif
+ifeq ($(SMALL_FLASH),true)
+    BUILD_PACKAGES += -coremark -htop -bash -openssh-sftp-server -luci-app-diskman
+	ifeq ($(shell grep -q small_flash $(TOPDIR)/repositories.conf || echo "not_found"),not_found)
+        $(shell echo "`grep meowwrt_miaogongzi $(TOPDIR)/repositories.conf | sed -e 's/miaogongzi/small_flash/g'`" >>$(TOPDIR)/repositories.conf)
+    endif
+else
+    $(shell sed -i "/small_flash/d" $(TOPDIR)/repositories.conf)
+endif
+define add_zh_cn_packages
+$(eval BUILD_PACKAGES += $(foreach pkg,$(BUILD_PACKAGES),$(if $(and $(filter luci-app-%,$(pkg)),$(shell $(OPKG) list | grep -q "^luci-i18n-$(patsubst luci-app-%,%,$(pkg))-zh-cn" && echo 1)),luci-i18n-$(patsubst luci-app-%,%,$(pkg))-zh-cn)))
+endef
 BUILD_PACKAGES:=$(filter-out $(filter -%,$(BUILD_PACKAGES)) $(patsubst -%,%,$(filter -%,$(BUILD_PACKAGES))),$(BUILD_PACKAGES))
 PACKAGES:=
 
@@ -146,6 +166,8 @@ _call_image: staging_dir/host/.prereq-build
 	$(MAKE) -s build_image
 	$(MAKE) -s json_overview_image_info
 	$(MAKE) -s checksum
+	rm -rf $(KERNEL_BUILD_DIR)/tmp
+	rm -rf $(KERNEL_BUILD_DIR)/root.*
 
 _call_manifest: FORCE
 	rm -rf $(TARGET_DIR)
@@ -223,10 +223,18 @@
 package_install: FORCE
 	@echo
 	@echo Installing packages...
+	$(eval $(call add_zh_cn_packages))
 ifeq ($(CONFIG_USE_APK),)
 	$(OPKG) install $(firstword $(wildcard $(LINUX_DIR)/libc_*.ipk $(PACKAGE_DIR)/libc_*.ipk))
 	$(OPKG) install $(firstword $(wildcard $(LINUX_DIR)/kernel_*.ipk $(PACKAGE_DIR)/kernel_*.ipk))
-	$(OPKG) install $(BUILD_PACKAGES)
+    $(OPKG) install $(BUILD_PACKAGES) luci-i18n-base-zh-cn || true
+	$(if $(USER_FILES), \
+	find $(USER_FILES) -name "*.ipk" -print0 | \
+	while IFS= read -r -d '' ipk; do \
+  $(OPKG) install "$$ipk" && rm -f "$$ipk" || true; \
+	done; \
+	)
+	$(OPKG) install --force-maintainer --force-reinstall my-default-settings
 else
 	$(APK) add --no-scripts $(firstword $(wildcard $(LINUX_DIR)/libc-*.apk $(PACKAGE_DIR)/libc-*.apk))
 	$(APK) add --no-scripts $(firstword $(wildcard $(LINUX_DIR)/kernel-*.apk $(PACKAGE_DIR)/kernel-*.apk))
@@ -254,6 +262,9 @@
 	)
 endif
 	$(call prepare_rootfs,$(TARGET_DIR),$(USER_FILES),$(DISABLED_SERVICES))
+	$(if $(SMALL_FLASH), \
+	        $(shell echo "`grep meowwrt_miaogongzi $(TOPDIR)/repositories.conf | sed -e 's/miaogongzi/small_flash/g'`" >>$(BUILD_DIR)/root-*/etc/opkg/distfeeds.conf) \
+	)
 
 build_image: FORCE
 	@echo
@@ -263,7 +274,7 @@
 		$(NO_TRACE_MAKE) -C target/linux/feeds/$(BOARD)/image install TARGET_BUILD=1 IB=1 EXTRA_IMAGE_NAME="$(EXTRA_IMAGE_NAME)" \
 			$(if $(USER_PROFILE),PROFILE="$(USER_PROFILE)"); \
 	else \
-		$(NO_TRACE_MAKE) -C target/linux/$(BOARD)/image install TARGET_BUILD=1 IB=1 EXTRA_IMAGE_NAME="$(EXTRA_IMAGE_NAME)" \
+		nice -n 19 $(NO_TRACE_MAKE) -C target/linux/$(BOARD)/image install TARGET_BUILD=1 IB=1 EXTRA_IMAGE_NAME="$(EXTRA_IMAGE_NAME)" \
 			$(if $(USER_PROFILE),PROFILE="$(USER_PROFILE)"); \
 	fi
 

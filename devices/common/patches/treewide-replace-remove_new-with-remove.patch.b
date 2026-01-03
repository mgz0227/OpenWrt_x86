From 0495522cb43f1c23f7f8f1365b5a2d6ff0d4305e Mon Sep 17 00:00:00 2001
From: gongzi miao <miaogongzi0227@gmail.com>
Date: Thu, 1 Jan 2026 01:39:24 +0800
Subject: [PATCH] treewide: replace remove_new with remove

---
 package/kernel/lantiq/ltq-adsl-mei/src/drv_mei_cpe.c     | 2 +-
 .../kernel/lantiq/ltq-adsl/patches/120-platform.patch    | 2 +-
 package/kernel/lantiq/ltq-atm/src/ltq_atm.c              | 2 +-
 package/kernel/lantiq/ltq-deu/src/ifxmips_deu.c          | 2 +-
 package/kernel/lantiq/ltq-ptm/src/ifxmips_ptm_adsl.c     | 2 +-
 package/kernel/lantiq/ltq-ptm/src/ifxmips_ptm_vdsl.c     | 2 +-
 ...-convert-platform-driver-.remove-to-.remove_new.patch | 9 ---------
 ...-convert-platform-driver-.remove-to-.remove_new.patch | 9 ---------
 package/kernel/ubootenv-nvram/src/ubootenv-nvram.c       | 2 +-
 .../linux/ath79/files/drivers/mtd/nand/raw/ar934x_nand.c | 2 +-
 .../linux/ath79/files/drivers/mtd/nand/raw/nand_rb4xx.c  | 2 +-
 .../linux/ath79/files/drivers/mtd/nand/raw/rb91x_nand.c  | 2 +-
 .../net/ethernet/atheros/ag71xx/ag71xx_legacy_mdio.c     | 2 +-
 .../drivers/net/ethernet/atheros/ag71xx/ag71xx_main.c    | 2 +-
 .../files/drivers/net/ethernet/broadcom/bcm6348-enet.c   | 2 +-
 .../files/drivers/net/ethernet/broadcom/bcm6368-enetsw.c | 2 +-
 .../mediatek/files/drivers/net/phy/rtk/rtl8367s_mdio.c   | 2 +-
 .../ramips/files/drivers/dma/mediatek/hsdma-mt7621.c     | 2 +-
 target/linux/ramips/files/drivers/dma/ralink-gdma.c      | 2 +-
 target/linux/ramips/files/drivers/mmc/host/mtk-mmc/sd.c  | 2 +-
 .../ramips/files/drivers/mtd/nand/raw/mt7621_nand.c      | 2 +-
 21 files changed, 19 insertions(+), 37 deletions(-)

diff --git a/package/kernel/lantiq/ltq-adsl-mei/src/drv_mei_cpe.c b/package/kernel/lantiq/ltq-adsl-mei/src/drv_mei_cpe.c
index 024d45d62c4405..0593c4f9fb33a1 100644
--- a/package/kernel/lantiq/ltq-adsl-mei/src/drv_mei_cpe.c
+++ b/package/kernel/lantiq/ltq-adsl-mei/src/drv_mei_cpe.c
@@ -2809,7 +2809,7 @@ static const struct of_device_id ltq_mei_match[] = {
 
 static struct platform_driver ltq_mei_driver = {
 	.probe = ltq_mei_probe,
-	.remove_new = ltq_mei_remove,
+	.remove = ltq_mei_remove,
 	.driver = {
 		.name = "lantiq,mei-xway",
 		.of_match_table = ltq_mei_match,
diff --git a/package/kernel/lantiq/ltq-adsl/patches/120-platform.patch b/package/kernel/lantiq/ltq-adsl/patches/120-platform.patch
index 48ffa8cb83a8cd..2534c8096e03fb 100644
--- a/package/kernel/lantiq/ltq-adsl/patches/120-platform.patch
+++ b/package/kernel/lantiq/ltq-adsl/patches/120-platform.patch
@@ -56,7 +56,7 @@
 +
 +static struct platform_driver ltq_adsl_driver = {
 +	.probe = ltq_adsl_probe,
-+	.remove_new = ltq_adsl_remove,
++	.remove = ltq_adsl_remove,
 +	.driver = {
 +		.name = "adsl",
 +		.of_match_table = ltq_adsl_match,
diff --git a/package/kernel/lantiq/ltq-atm/src/ltq_atm.c b/package/kernel/lantiq/ltq-atm/src/ltq_atm.c
index d97dadba685dea..923eb70d431d4e 100644
--- a/package/kernel/lantiq/ltq-atm/src/ltq_atm.c
+++ b/package/kernel/lantiq/ltq-atm/src/ltq_atm.c
@@ -1885,7 +1885,7 @@ static void ltq_atm_remove(struct platform_device *pdev)
 
 static struct platform_driver ltq_atm_driver = {
 	.probe = ltq_atm_probe,
-	.remove_new = ltq_atm_remove,
+	.remove = ltq_atm_remove,
 	.driver = {
 		.name = "atm",
 		.of_match_table = ltq_atm_match,
diff --git a/package/kernel/lantiq/ltq-deu/src/ifxmips_deu.c b/package/kernel/lantiq/ltq-deu/src/ifxmips_deu.c
index 33157f89423965..84107884af1be2 100644
--- a/package/kernel/lantiq/ltq-deu/src/ifxmips_deu.c
+++ b/package/kernel/lantiq/ltq-deu/src/ifxmips_deu.c
@@ -191,7 +191,7 @@ MODULE_DEVICE_TABLE(of, ltq_deu_match);
 
 static struct platform_driver ltq_deu_driver = {
 	.probe = ltq_deu_probe,
-	.remove_new = ltq_deu_remove,
+	.remove = ltq_deu_remove,
 	.driver = {
 		.name = "deu",
 		.of_match_table = ltq_deu_match,
diff --git a/package/kernel/lantiq/ltq-ptm/src/ifxmips_ptm_adsl.c b/package/kernel/lantiq/ltq-ptm/src/ifxmips_ptm_adsl.c
index 527066f54fa56b..b4a4dfc774ed59 100644
--- a/package/kernel/lantiq/ltq-ptm/src/ifxmips_ptm_adsl.c
+++ b/package/kernel/lantiq/ltq-ptm/src/ifxmips_ptm_adsl.c
@@ -1633,7 +1633,7 @@ static void ltq_ptm_remove(struct platform_device *pdev)
 
 static struct platform_driver ltq_ptm_driver = {
        .probe = ltq_ptm_probe,
-       .remove_new = ltq_ptm_remove,
+       .remove = ltq_ptm_remove,
        .driver = {
                .name = "ptm",
                .of_match_table = ltq_ptm_match,
diff --git a/package/kernel/lantiq/ltq-ptm/src/ifxmips_ptm_vdsl.c b/package/kernel/lantiq/ltq-ptm/src/ifxmips_ptm_vdsl.c
index faa4ed6938b7e6..3d76a2e7d02542 100644
--- a/package/kernel/lantiq/ltq-ptm/src/ifxmips_ptm_vdsl.c
+++ b/package/kernel/lantiq/ltq-ptm/src/ifxmips_ptm_vdsl.c
@@ -1167,7 +1167,7 @@ static int __init queue_gamma_map_setup(char *line)
 #endif
 static struct platform_driver ltq_ptm_driver = {
 	.probe = ltq_ptm_probe,
-	.remove_new = ltq_ptm_remove,
+	.remove = ltq_ptm_remove,
 	.driver = {
 		.name = "ptm",
 		.of_match_table = ltq_ptm_match,
diff --git a/package/kernel/lantiq/ltq-vdsl-vr11-mei/patches/133-convert-platform-driver-.remove-to-.remove_new.patch b/package/kernel/lantiq/ltq-vdsl-vr11-mei/patches/133-convert-platform-driver-.remove-to-.remove_new.patch
index 0ad2ab72b0b2e2..bd34a645a2ecb1 100644
--- a/package/kernel/lantiq/ltq-vdsl-vr11-mei/patches/133-convert-platform-driver-.remove-to-.remove_new.patch
+++ b/package/kernel/lantiq/ltq-vdsl-vr11-mei/patches/133-convert-platform-driver-.remove-to-.remove_new.patch
@@ -32,12 +32,3 @@ Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
  }
  
  static const struct of_device_id ltq_dsl_cpe_mei_match[] = {
-@@ -2267,7 +2266,7 @@ static struct platform_driver ltq_dsl_cp
-       .owner          = THIS_MODULE,
-       .of_match_table = ltq_dsl_cpe_mei_match,
-    },
--   .remove = ltq_dsl_cpe_mei_remove,
-+   .remove_new = ltq_dsl_cpe_mei_remove,
- };
- 
- static int ltq_dsl_cpe_mei_reboot_notifier(struct notifier_block *nb,
diff --git a/package/kernel/lantiq/ltq-vdsl-vr9-mei/patches/405-convert-platform-driver-.remove-to-.remove_new.patch b/package/kernel/lantiq/ltq-vdsl-vr9-mei/patches/405-convert-platform-driver-.remove-to-.remove_new.patch
index 9e64e689b61e18..186fdbaeb7dcb3 100644
--- a/package/kernel/lantiq/ltq-vdsl-vr9-mei/patches/405-convert-platform-driver-.remove-to-.remove_new.patch
+++ b/package/kernel/lantiq/ltq-vdsl-vr9-mei/patches/405-convert-platform-driver-.remove-to-.remove_new.patch
@@ -30,12 +30,3 @@ Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
  }
  
  static const struct of_device_id ltq_dsl_cpe_mei_match[] = {
-@@ -2070,7 +2069,7 @@ static struct platform_driver ltq_dsl_cp
-       .owner          = THIS_MODULE,
-       .of_match_table = ltq_dsl_cpe_mei_match,
-    },
--   .remove = __exit_p(ltq_dsl_cpe_mei_remove),
-+   .remove_new = __exit_p(ltq_dsl_cpe_mei_remove),
- };
- 
- static int __init ltq_dsl_cpe_mei_probe(struct platform_device *pdev)
diff --git a/package/kernel/ubootenv-nvram/src/ubootenv-nvram.c b/package/kernel/ubootenv-nvram/src/ubootenv-nvram.c
index ba1d7973f18105..b9652064a85fc6 100644
--- a/package/kernel/ubootenv-nvram/src/ubootenv-nvram.c
+++ b/package/kernel/ubootenv-nvram/src/ubootenv-nvram.c
@@ -142,7 +142,7 @@ static void ubootenv_remove(struct platform_device *pdev)
 
 static struct platform_driver ubootenv_driver = {
 	.probe = ubootenv_probe,
-	.remove_new = ubootenv_remove,
+	.remove = ubootenv_remove,
 	.driver = {
 		.name           = NAME,
 		.of_match_table = of_ubootenv_match,
diff --git a/target/linux/ath79/files/drivers/mtd/nand/raw/ar934x_nand.c b/target/linux/ath79/files/drivers/mtd/nand/raw/ar934x_nand.c
index 9b40706cdd64d1..732e71cde815bc 100644
--- a/target/linux/ath79/files/drivers/mtd/nand/raw/ar934x_nand.c
+++ b/target/linux/ath79/files/drivers/mtd/nand/raw/ar934x_nand.c
@@ -1471,7 +1471,7 @@ MODULE_DEVICE_TABLE(of, ar934x_nfc_match);
 
 static struct platform_driver ar934x_nfc_driver = {
 	.probe		= ar934x_nfc_probe,
-	.remove_new	= ar934x_nfc_remove,
+	.remove	= ar934x_nfc_remove,
 	.driver = {
 		.name	= AR934X_NFC_DRIVER_NAME,
 		.of_match_table = ar934x_nfc_match,
diff --git a/target/linux/ath79/files/drivers/mtd/nand/raw/nand_rb4xx.c b/target/linux/ath79/files/drivers/mtd/nand/raw/nand_rb4xx.c
index e475105170960a..ebbf7ffbc7c9c2 100644
--- a/target/linux/ath79/files/drivers/mtd/nand/raw/nand_rb4xx.c
+++ b/target/linux/ath79/files/drivers/mtd/nand/raw/nand_rb4xx.c
@@ -224,7 +224,7 @@ static void rb4xx_nand_remove(struct platform_device *pdev)
 
 static struct platform_driver rb4xx_nand_driver = {
 	.probe = rb4xx_nand_probe,
-	.remove_new = rb4xx_nand_remove,
+	.remove = rb4xx_nand_remove,
 	.driver = {
 		.name = "rb4xx-nand",
 	},
diff --git a/target/linux/ath79/files/drivers/mtd/nand/raw/rb91x_nand.c b/target/linux/ath79/files/drivers/mtd/nand/raw/rb91x_nand.c
index 8a154c351463e9..801cb89778f63c 100644
--- a/target/linux/ath79/files/drivers/mtd/nand/raw/rb91x_nand.c
+++ b/target/linux/ath79/files/drivers/mtd/nand/raw/rb91x_nand.c
@@ -351,7 +351,7 @@ MODULE_DEVICE_TABLE(of, rb91x_nand_match);
 
 static struct platform_driver rb91x_nand_driver = {
 	.probe	= rb91x_nand_probe,
-	.remove_new	= rb91x_nand_remove,
+	.remove	= rb91x_nand_remove,
 	.driver	= {
 		.name	= "rb91x-nand",
 		.of_match_table = rb91x_nand_match,
diff --git a/target/linux/ath79/files/drivers/net/ethernet/atheros/ag71xx/ag71xx_legacy_mdio.c b/target/linux/ath79/files/drivers/net/ethernet/atheros/ag71xx/ag71xx_legacy_mdio.c
index 9ccba7472078a2..74c28b9277af25 100644
--- a/target/linux/ath79/files/drivers/net/ethernet/atheros/ag71xx/ag71xx_legacy_mdio.c
+++ b/target/linux/ath79/files/drivers/net/ethernet/atheros/ag71xx/ag71xx_legacy_mdio.c
@@ -238,7 +238,7 @@ static const struct of_device_id ag71xx_mdio_match[] = {
 
 static struct platform_driver ag71xx_mdio_driver = {
 	.probe		= ag71xx_mdio_probe,
-	.remove_new	= ag71xx_mdio_remove,
+	.remove	= ag71xx_mdio_remove,
 	.driver = {
 		.name	 = "ag71xx-legacy-mdio",
 		.of_match_table = ag71xx_mdio_match,
diff --git a/target/linux/ath79/files/drivers/net/ethernet/atheros/ag71xx/ag71xx_main.c b/target/linux/ath79/files/drivers/net/ethernet/atheros/ag71xx/ag71xx_main.c
index f2d1e3582879e0..7b66edb9af7763 100644
--- a/target/linux/ath79/files/drivers/net/ethernet/atheros/ag71xx/ag71xx_main.c
+++ b/target/linux/ath79/files/drivers/net/ethernet/atheros/ag71xx/ag71xx_main.c
@@ -1763,7 +1763,7 @@ static const struct of_device_id ag71xx_match[] = {
 
 static struct platform_driver ag71xx_driver = {
 	.probe		= ag71xx_probe,
-	.remove_new	= ag71xx_remove,
+	.remove	= ag71xx_remove,
 	.driver = {
 		.name	= AG71XX_DRV_NAME,
 		.of_match_table = ag71xx_match,
diff --git a/target/linux/bmips/files/drivers/net/ethernet/broadcom/bcm6348-enet.c b/target/linux/bmips/files/drivers/net/ethernet/broadcom/bcm6348-enet.c
index 85105f591e4f5c..fbab6b68b4dcc8 100644
--- a/target/linux/bmips/files/drivers/net/ethernet/broadcom/bcm6348-enet.c
+++ b/target/linux/bmips/files/drivers/net/ethernet/broadcom/bcm6348-enet.c
@@ -1704,7 +1704,7 @@ static struct platform_driver bcm6348_emac_driver = {
 		.of_match_table = bcm6348_emac_of_match,
 	},
 	.probe	= bcm6348_emac_probe,
-	.remove_new	= bcm6348_emac_remove,
+	.remove	= bcm6348_emac_remove,
 };
 
 int bcm6348_iudma_drivers_register(struct platform_device *pdev)
diff --git a/target/linux/bmips/files/drivers/net/ethernet/broadcom/bcm6368-enetsw.c b/target/linux/bmips/files/drivers/net/ethernet/broadcom/bcm6368-enetsw.c
index 97ca6a81d84da7..8f5b702edf088b 100644
--- a/target/linux/bmips/files/drivers/net/ethernet/broadcom/bcm6368-enetsw.c
+++ b/target/linux/bmips/files/drivers/net/ethernet/broadcom/bcm6368-enetsw.c
@@ -1136,7 +1136,7 @@ static struct platform_driver bcm6368_enetsw_driver = {
 		.of_match_table = bcm6368_enetsw_of_match,
 	},
 	.probe	= bcm6368_enetsw_probe,
-	.remove_new	= bcm6368_enetsw_remove,
+	.remove	= bcm6368_enetsw_remove,
 };
 module_platform_driver(bcm6368_enetsw_driver);
 
diff --git a/target/linux/mediatek/files/drivers/net/phy/rtk/rtl8367s_mdio.c b/target/linux/mediatek/files/drivers/net/phy/rtk/rtl8367s_mdio.c
index 537e226a19369c..87cb3ca097436f 100644
--- a/target/linux/mediatek/files/drivers/net/phy/rtk/rtl8367s_mdio.c
+++ b/target/linux/mediatek/files/drivers/net/phy/rtk/rtl8367s_mdio.c
@@ -282,7 +282,7 @@ static void rtk_gsw_remove(struct platform_device *pdev)
 
 static struct platform_driver gsw_driver = {
 	.probe = rtk_gsw_probe,
-	.remove_new = rtk_gsw_remove,
+	.remove = rtk_gsw_remove,
 	.driver = {
 		.name = "rtk-gsw",
 		.of_match_table = rtk_gsw_match,
diff --git a/target/linux/ramips/files/drivers/dma/mediatek/hsdma-mt7621.c b/target/linux/ramips/files/drivers/dma/mediatek/hsdma-mt7621.c
index b99b4a920f3fdf..2d023286b049b3 100644
--- a/target/linux/ramips/files/drivers/dma/mediatek/hsdma-mt7621.c
+++ b/target/linux/ramips/files/drivers/dma/mediatek/hsdma-mt7621.c
@@ -745,7 +745,7 @@ static void mtk_hsdma_remove(struct platform_device *pdev)
 
 static struct platform_driver mtk_hsdma_driver = {
 	.probe = mtk_hsdma_probe,
-	.remove_new = mtk_hsdma_remove,
+	.remove = mtk_hsdma_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = mtk_hsdma_of_match,
diff --git a/target/linux/ramips/files/drivers/dma/ralink-gdma.c b/target/linux/ramips/files/drivers/dma/ralink-gdma.c
index 41220d83dd30ca..124785c0f0109d 100644
--- a/target/linux/ramips/files/drivers/dma/ralink-gdma.c
+++ b/target/linux/ramips/files/drivers/dma/ralink-gdma.c
@@ -901,7 +901,7 @@ static void gdma_dma_remove(struct platform_device *pdev)
 
 static struct platform_driver gdma_dma_driver = {
 	.probe = gdma_dma_probe,
-	.remove_new = gdma_dma_remove,
+	.remove = gdma_dma_remove,
 	.driver = {
 		.name = "gdma-rt2880",
 		.of_match_table = gdma_of_match_table,
diff --git a/target/linux/ramips/files/drivers/mmc/host/mtk-mmc/sd.c b/target/linux/ramips/files/drivers/mmc/host/mtk-mmc/sd.c
index 5a52dd6310489f..bf39349afabf91 100644
--- a/target/linux/ramips/files/drivers/mmc/host/mtk-mmc/sd.c
+++ b/target/linux/ramips/files/drivers/mmc/host/mtk-mmc/sd.c
@@ -2410,7 +2410,7 @@ MODULE_DEVICE_TABLE(of, mt7620_sdhci_match);
 
 static struct platform_driver mt_msdc_driver = {
 	.probe   = msdc_drv_probe,
-	.remove_new  = msdc_drv_remove,
+	.remove  = msdc_drv_remove,
 #ifdef CONFIG_PM
 	.suspend = msdc_drv_suspend,
 	.resume  = msdc_drv_resume,
diff --git a/target/linux/ramips/files/drivers/mtd/nand/raw/mt7621_nand.c b/target/linux/ramips/files/drivers/mtd/nand/raw/mt7621_nand.c
index bd071c9ec32787..427a3f03777659 100644
--- a/target/linux/ramips/files/drivers/mtd/nand/raw/mt7621_nand.c
+++ b/target/linux/ramips/files/drivers/mtd/nand/raw/mt7621_nand.c
@@ -1331,7 +1331,7 @@ MODULE_DEVICE_TABLE(of, match);
 
 static struct platform_driver mt7621_nfc_driver = {
 	.probe = mt7621_nfc_probe,
-	.remove_new = mt7621_nfc_remove,
+	.remove = mt7621_nfc_remove,
 	.driver = {
 		.name = MT7621_NFC_NAME,
 		.of_match_table = mt7621_nfc_id_table,

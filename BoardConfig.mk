# inherit from the proprietary version
-include vendor/lge/p920/BoardConfigVendor.mk

TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := omap4
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_BOOTLOADER_BOARD_NAME := p920
TARGET_CPU_SMP := true
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_ARCH_VARIANT_CPU := cortex-a9
TARGET_ARCH_VARIANT_FPU := neon
TARGET_CPU_VARIANT  := $(TARGET_ARCH_VARIANT_CPU)
ARCH_ARM_HAVE_TLS_REGISTER := true
NEEDS_ARM_ERRATA_754319_754320 := true
BOARD_GLOBAL_CFLAGS += -DNEEDS_ARM_ERRATA_754319_754320

#############################BOOT##################################
BOARD_USES_UBOOT_MULTIIMAGE := true
BOARD_UBOOT_ENTRY := 0x80008000
BOARD_UBOOT_LOAD := 0x80008000
TARGET_BOOTLOADER_BOARD_NAME := p920
BOARD_CUSTOM_BOOTIMG_MK := device/lge/p920/uboot-bootimg.mk
SKIP_SET_METADATA := true
BOARD_KERNEL_CMDLINE := androidboot.selinux=permissive
###################################################################

#####################Kernel##############################
# Try to build the kernel
TARGET_KERNEL_CONFIG := cyanogenmod_p920_defconfig
TARGET_KERNEL_SOURCE := kernel/lge/omap4-common

KERNEL_WL12XX_MODULES:
	make -C hardware/ti/wlan/mac80211/compat_wl12xx/ KLIB_BUILD=$(KERNEL_OUT) ARCH="arm" $(ARM_CROSS_COMPILE) KERNEL_CROSS_COMPILE=$(ARM_CROSS_COMPILE)
	-mv hardware/ti/wlan/mac80211/compat_wl12xx/compat/compat.ko $(KERNEL_MODULES_OUT)
	-mv hardware/ti/wlan/mac80211/compat_wl12xx/net/wireless/cfg80211.ko $(KERNEL_MODULES_OUT)
	-mv hardware/ti/wlan/mac80211/compat_wl12xx/net/mac80211/mac80211.ko $(KERNEL_MODULES_OUT)
	-mv hardware/ti/wlan/mac80211/compat_wl12xx/drivers/net/wireless/wl12xx/wl12xx.ko $(KERNEL_MODULES_OUT)
	-mv hardware/ti/wlan/mac80211/compat_wl12xx/drivers/net/wireless/wl12xx/wl12xx_sdio.ko $(KERNEL_MODULES_OUT)
	make -C hardware/ti/wlan/mac80211/compat_wl12xx/ KLIB_BUILD=$(KERNEL_OUT) ARCH="arm" $(ARM_CROSS_COMPILE) KERNEL_CROSS_COMPILE=$(ARM_CROSS_COMPILE) clean
	-rm hardware/ti/wlan/mac80211/compat_wl12xx/drivers/net/wireless/wl12xx/version.h
	-rm hardware/ti/wlan/mac80211/compat_wl12xx/include/linux/compat_autoconf.h

KERNEL_SGX_MODULES:
	make -C device/lge/p920/sgx-module/eurasia_km/eurasiacon/build/linux2/omap4430_android/ O=$(KERNEL_OUT) KERNELDIR=$(ANDROID_BUILD_TOP)/$(KERNEL_SRC) ARCH="arm" $(ARM_CROSS_COMPILE) KERNEL_CROSS_COMPILE=$(ARM_CROSS_COMPILE) TARGET_PRODUCT="blaze_tablet" BUILD=release TARGET_SGX=540 PLATFORM_VERSION=4.0 
	mkdir -p $(TARGET_OUT)/modules/
	mv $(OUT)/target/*sgx540_120.ko $(TARGET_OUT)/modules/

TARGET_KERNEL_MODULES := KERNEL_SGX_MODULES KERNEL_WL12XX_MODULES
###############################################################################

###########################BOARDSTUFF######################################
BOARD_HAVE_BLUETOOTH := true
BOARD_WPAN_DEVICE := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/lge/p920/bluetooth
BOARD_NEEDS_CUTILS_LOG := true
BOARD_USES_AUDIO_LEGACY := true
### Kitkat Specific
# Disable SELinux
PRODUCT_PROPERTY_OVERRIDES += \
ro.boot.selinux=disabled
###GL
TARGET_USES_GL_VENDOR_EXTENSIONS := false
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := device/lge/p920/egl.cfg
###
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wl12xx
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_wl12xx
BOARD_WLAN_DEVICE                := wl12xx_mac80211
BOARD_SOFTAP_DEVICE              := wl12xx_mac80211
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wl12xx_sdio.ko"
WIFI_DRIVER_MODULE_NAME          := "wl12xx_sdio"
WIFI_FIRMWARE_LOADER             := ""
USES_TI_MAC80211		 := true
###FileSystem####
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 619249664
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_VOLD_MAX_PARTITIONS := 16
BOARD_HAS_NO_MISC_PARTITION := true
####Camera####
USE_CAMERA_STUB := false
BOARD_USES_TI_CAMERA_HAL := true
TI_OMAP4_CAMERAHAL_VARIANT := DONOTBUILDIT
####Omap####
HARDWARE_OMX := true
ifdef HARDWARE_OMX
OMX_VENDOR := ti
OMX_VENDOR_WRAPPER := TI_OMX_Wrapper
BOARD_OPENCORE_LIBRARIES := libOMX_Core
BOARD_OPENCORE_FLAGS := -DHARDWARE_OMX=1
endif

OMAP_ENHANCEMENT := true
OMAP_ENHANCEMENT_CPCAM := true
ifdef OMAP_ENHANCEMENT
COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT -DTARGET_OMAP4 -DOMAP_ENHANCEMENT_CPCAM -DOMAP_ENHANCEMENT_VTC
endif
ENHANCED_DOMX := true

BOARD_RIL_CLASS := ../../../device/lge/p920/ril/
BOARD_HAS_VIBRATOR_IMPLEMENTATION := ../../device/lge/p920/vibrator.c
############################################################################

################RECOVERY####################################
## Ignore --wipe_data sent by the bootloader
BOARD_RECOVERY_ALWAYS_WIPES := true
#TARGET_RECOVERY_PRE_COMMAND := "/system/bin/setup-recovery"
#BOARD_TOUCH_RECOVERY := true
#TARGET_RECOVERY_FSTAB = device/lge/p920/fstab.cosmo
#RECOVERY_FSTAB_VERSION = 2 
DEVICE_RESOLUTION := 480x800
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
BOARD_RECOVERY_SWIPE := true
#BOARD_UMS_LUNFILE := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun%d/file"
#TWRP
#TW_NO_REBOOT_BOOTLOADER := true
############################################################
BOARD_HAVE_PRE_KITKAT_AUDIO_BLOB := true
COMMON_GLOBAL_CFLAGS += -DBOARD_HAVE_PRE_KITKAT_AUDIO_BLOB -DICS_CAMERA_BLOB
TARGET_SPECIFIC_HEADER_PATH := device/lge/p920/src-headers
PRODUCT_VENDOR_KERNEL_HEADERS := device/lge/p920/kernel-headers

COMMON_GLOBAL_CFLAGS += -DBOARD_CHARGING_CMDLINE_NAME='"chg"' -DBOARD_CHARGING_CMDLINE_VALUE='"4"'

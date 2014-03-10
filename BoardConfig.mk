USE_CAMERA_STUB := false
BOARD_USES_TI_CAMERA_HAL := true

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

#BOARD_CUSTOM_BOOTIMG_MK := device/common/uboot-bootimg.mk
BOARD_USES_UBOOT_MULTIIMAGE := true
BOARD_UBOOT_ENTRY := 0x80008000
BOARD_UBOOT_LOAD := 0x80008000

# Try to build the kernel
TARGET_KERNEL_CONFIG := cyanogenmod_p920_defconfig
TARGET_KERNEL_SOURCE := kernel/lge/omap4-common
# Keep this as a fallback
#TARGET_PREBUILT_KERNEL := device/lge/p920/kernel

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

## Ignore --wipe_data sent by the bootloader
BOARD_RECOVERY_ALWAYS_WIPES := true
BOARD_HAS_NO_SELECT_BUTTON := true

# Use this flag if the board has a ext4 partition larger than 2gb
#BOARD_HAS_LARGE_FILESYSTEM := true

BOARD_HAVE_BLUETOOTH := true
BOARD_WPAN_DEVICE := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/lge/p920/bluetooth

BOARD_HAS_NO_MISC_PARTITION := true

#TARGET_RECOVERY_PRE_COMMAND := "/system/bin/setup-recovery"
TARGET_RECOVERY_FSTAB = device/lge/p920/fstab.cosmo
RECOVERY_FSTAB_VERSION = 2 

TARGET_BOOTLOADER_BOARD_NAME := p920

BOARD_USES_AUDIO_LEGACY := true

BOARD_EGL_CFG := device/lge/p920/egl.cfg

BOARD_VOLD_MAX_PARTITIONS := 16

TARGET_USES_GL_VENDOR_EXTENSIONS := false

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

OMAP_ENHANCEMENT := true
OMAP_ENHANCEMENT_CPCAM := true

ifdef OMAP_ENHANCEMENT
COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT -DTARGET_OMAP4 -DOMAP_ENHANCEMENT_CPCAM -DOMAP_ENHANCEMENT_VTC
endif

## Radio fixes
BOARD_RIL_CLASS := ../../../device/lge/p920/ril/

BOARD_USES_TI_CAMERA_HAL := true
TI_OMAP4_CAMERAHAL_VARIANT := DONOTBUILDIT
HARDWARE_OMX := true
#FW3A := true
#ICAP := true
#IMAGE_PROCESSING_PIPELINE := true
ifdef HARDWARE_OMX
OMX_VENDOR := ti
OMX_VENDOR_WRAPPER := TI_OMX_Wrapper
BOARD_OPENCORE_LIBRARIES := libOMX_Core
BOARD_OPENCORE_FLAGS := -DHARDWARE_OMX=1
endif

BOARD_NEEDS_CUTILS_LOG := true

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 619249664
BOARD_FLASH_BLOCK_SIZE := 131072
USE_OPENGL_RENDERER := true
#BOARD_TOUCH_RECOVERY := true
BOARD_CUSTOM_BOOTIMG_MK := device/lge/p920/uboot-bootimg.mk
ENHANCED_DOMX := true


BOARD_HAS_VIBRATOR_IMPLEMENTATION := ../../device/lge/p920/vibrator.c

COMMON_GLOBAL_CFLAGS += -ICS_AUDIO_BLOB -DICS_CAMERA_BLOB
TARGET_SPECIFIC_HEADER_PATH := device/lge/p920/src-headers
PRODUCT_VENDOR_KERNEL_HEADERS := device/lge/p920/kernel-headers

COMMON_GLOBAL_CFLAGS += -DBOARD_CHARGING_CMDLINE_NAME='"chg"' -DBOARD_CHARGING_CMDLINE_VALUE='"4"'

# Recovery: set depending on recovery being built for. (CWM or TWRP)
# both init scripts can be found in the recovery folder
TARGET_RECOVERY_INITRC := device/lge/p920/init.cosmo.rc

# TWRP specific build flags
#BOARD_USE_CUSTOM_RECOVERY_FONT:= \"roboto_15x24.h\"
DEVICE_RESOLUTION := 480x800
TW_INTERNAL_STORAGE_PATH := "/sdcard"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/sdcard/_ExternalSD"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sdcard"
#RECOVERY_SDCARD_ON_DATA := false
#BOARD_HAS_NO_REAL_SDCARD := false
#PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
#TW_NO_USB_STORAGE := true
#TWRP_EVENT_LOGGING := false

#TW_INCLUDE_CRYPTO := true
#TW_INCLUDE_CRYPTO_SAMSUNG := true
#TW_CRYPTO_FS_TYPE := "ext4"
#TW_CRYPTO_REAL_BLKDEV := "/dev/block/mmcblk0p16"
#TW_CRYPTO_MNT_POINT := "/data"
#TW_CRYPTO_FS_OPTIONS := "noatime,nosuid,nodev,discard,noauto_da_alloc,journal_async_commit,errors=panic wait,check,encryptable=footer"
#TW_CRYPTO_FS_FLAGS := "0x00000406"
#TW_CRYPTO_KEY_LOC := "footer"
#TW_BRIGHTNESS_PATH := "/sys/devices/platform/s5p-dsim.0/s6evr02/backlight/panel/brightness"
#TW_MAX_BRIGHTNESS := 255
#TARGET_USERIMAGES_USE_EXT4 := true
#TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/virtual/android_usb/android0/f_mass_storage/lun0/file
#TW_INCLUDE_FB2PNG := true
TW_FLASH_FROM_STORAGE := true

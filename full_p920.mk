$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

$(call inherit-product-if-exists, vendor/lge/p920/p920-vendor.mk)

$(call inherit-product, device/common/gps/gps_eu.mk)

DEVICE_PACKAGE_OVERLAYS += device/lge/p920/overlay

$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh

## Scripts and confs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/66swap:system/etc/init.d/66swap \
    $(LOCAL_PATH)/prebuilt/setup-recovery:system/bin/setup-recovery \
    $(LOCAL_PATH)/prebuilt/enable-tiwlink:system/bin/enable-tiwlink \
    $(LOCAL_PATH)/prebuilt/lgcpversion:system/bin/lgcpversion \
    $(LOCAL_PATH)/init.dummy.rc:root/init.p920.rc \
    $(LOCAL_PATH)/init.cosmo.rc:root/init.lgep920board.rc \
    $(LOCAL_PATH)/init.p920.usb.rc:root/init.p920.usb.rc \
    $(LOCAL_PATH)/ueventd.lgep920board.rc:root/ueventd.lgep920board.rc \
    $(LOCAL_PATH)/fstab.cosmo:root/fstab.lgep920board \
	$(LOCAL_PATH)/init.storage.rc:root/init.storage.rc \
	$(LOCAL_PATH)/prebuilt/TIInit_7.2.31.bts:system/etc/firmware/TIInit_7.2.31.bts \
	$(LOCAL_PATH)/init.wifi.bt.rc:root/init.wifi.bt.rc

## Wifi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifimac/wlan-precheck:system/bin/wlan-precheck \
    $(LOCAL_PATH)/wifimac/wifical.sh:system/bin/wifical.sh \
    $(LOCAL_PATH)/configs/RFMD_S_3.5.ini:system/etc/wifi/RFMD_S_3.5.ini \
    $(LOCAL_PATH)/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    $(LOCAL_PATH)/configs/hostapd.conf:system/etc/wifi/softap/hostapd.conf \
    $(LOCAL_PATH)/configs/hostapd.conf:system/etc/wifi/hostapd.conf \
    $(LOCAL_PATH)/configs/touch_dev.idc:system/usr/idc/touch_dev.idc \
	$(LOCAL_PATH)/configs/p2p_supplicant.conf:system/etc/wifi/p2p_supplicant.conf \
    $(LOCAL_PATH)/configs/touch_dev.kl:system/usr/keylayout/touch_dev.kl

# stagefright confs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/audio_policy.conf:system/etc/audio_policy.conf

# RIL stuffs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/ipc_channels.config:system/etc/ipc_channels.config

# Permission files
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml

## GPS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps_brcm_conf.xml:system/etc/gps_brcm_conf.xml

## Camera
#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/prebuilt/libcameraservice.so:system/lib/libcameraservice.so

$(call inherit-product, build/target/product/full.mk)

PRODUCT_AAPT_CONFIG := normal hdpi

PRODUCT_PACKAGES += \
    wlan_loader \
    wlan_cu \
    tiap_loader \
    tiap_cu \
    libaudioutils \
    audio.a2dp.default \
    audio_policy.default

# Graphics
# Newer libs are b0rked, use original props
#PRODUCT_PACKAGES += \
#    gfx-libs

PRODUCT_PACKAGES += \
    OMXCore \
    libOMX_Core \
    libdomx \
    libOMX.TI.DUCATI1.VIDEO.H264E \
    libOMX.TI.DUCATI1.VIDEO.MPEG4E \
    libOMX.TI.DUCATI1.VIDEO.CAMERA \
    libOMX.TI.DUCATI1.MISC.SAMPLE \
    libOMX.TI.DUCATI1.VIDEO.DECODER.secure \
    libOMX.TI.DUCATI1.VIDEO.DECODER
#
PRODUCT_PACKAGES += \
    libtiutils \
    libipcutils \
    libipc \
    libnotify \
    syslink_trace_daemon.out \
    librcm \
    libsysmgr \
    syslink_daemon.out \
    dmm_daemontest.out \
    event_listener.out \
    interm3.out \
    gateMPApp.out \
    heapBufMPApp.out \
    heapMemMPApp.out \
    listMPApp.out \
    messageQApp.out \
    nameServerApp.out \
    sharedRegionApp.out \
    memmgrserver.out \
    notifyping.out \
    ducati_load.out \
    procMgrApp.out \
    slpmresources.out \
    slpmtransport.out \
    utilsApp.out \
    libd2cmap \
    libomap_mm_library_jni \
    libtimemmgr

FRAMEWORKS_BASE_SUBDIRS += \
	$(addsuffix /java, omapmmlib )

PRODUCT_PROPERTY_OVERRIDES += \
	ro.boot.selinux=disabled \
	dalvik.vm.jit.codecachesize=0 \
	ro.config.low_ram=true \
	ro.bq.gpu_to_cpu_unsupported=1 \
	wifi.interface=wlan0 \
	ro.bt.bdaddr_path=/sys/devices/platform/bd_address/bdaddr_if

#FRAMEWORKS_BASE_SUBDIRS += \
#	../../$(LOCAL_PATH)/framework-addons/

PRODUCT_PACKAGES += \
    libskiahwdec \
    libskiahwenc

## To set the Wifi MAC address from NV, and the softap stuff
PRODUCT_PACKAGES += \
    calibrator \
    hostap \
    libhostapdcli \
    wifimac

# Charger mode
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# Wifi Direct and WPAN
PRODUCT_PACKAGES += \
ti_wfd_libs \
ti-wpan-fw

# Bluetooth
PRODUCT_PACKAGES += \
uim-sysfs \
libbt-vendor

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_p920
PRODUCT_DEVICE := p920
PRODUCT_MODEL := LG-P920
PRODUCT_MANUFACTURER := LGE

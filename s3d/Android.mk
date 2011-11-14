ifeq ($(MAKECMDGOALS), sdk_addon)
ifeq ($(TARGET_PRODUCT), s3d)
include_s3d_makefiles = yes
endif
endif

ifdef OMAP_ENHANCEMENT_S3D
include_s3d_makefiles = yes
endif

ifdef include_s3d_makefiles
include $(call all-subdir-makefiles)
endif

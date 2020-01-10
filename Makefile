INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ZenithDark

ZenithDark_FILES = Tweak.x
ZenithDark_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

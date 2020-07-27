INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ZenithDark

ZenithDark_FILES = ZenithDark.xm
ZenithDark_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += zenithdarkprefs
include $(THEOS_MAKE_PATH)/aggregate.mk

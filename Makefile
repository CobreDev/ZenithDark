ARCHS = arm64 arm64e
SDK = iPhoneOS12.4
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ZenithDark

ZenithDark_FILES = Tweak.xm
ZenithDark_CFLAGS = -fobjc-arc
ZenithDark_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"

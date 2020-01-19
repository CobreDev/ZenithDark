ARCHS = arm64 arm64e
SDK = iPhoneOS13.0
FINALPACKAGE = 1
export TARGET = iphone:clang:13.0:latest

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ZenithDark

ZenithDark_FILES = Tweak.xm
ZenithDark_CFLAGS = -fobjc-arc
ZenithDark_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"
SUBPROJECTS += zenithdarkprefs
include $(THEOS_MAKE_PATH)/aggregate.mk

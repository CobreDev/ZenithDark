ARCHS = arm64 arm64e
SDK = iPhoneOS12.2
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ZenithDark

ZenithDark_FILES = Tweak.xm
ZenithDark_FRAMEWORKS = UIKit CoreGraphics
ZenithDark_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += zenithdarkprefs
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "sbreload"

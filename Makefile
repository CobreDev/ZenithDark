ARCHS = arm64 arm64e
SDK = iPhoneOS12.2
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ZenithDark

$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_FRAMEWORKS = UIKit CoreGraphics
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += zenithdarkprefs
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "sbreload"

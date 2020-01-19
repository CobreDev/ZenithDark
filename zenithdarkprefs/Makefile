include $(THEOS)/makefiles/common.mk

ARCHS = arm64 arm64e
export TARGET = iphone:clang:13.0:latest
BUNDLE_NAME = ZenithDarkPrefs

ZenithDarkPrefs_FILES = ZnthDrkRootListController.m
ZenithDarkPrefs_INSTALL_PATH = /Library/PreferenceBundles
ZenithDarkPrefs_FRAMEWORKS = UIKit
ZenithDarkPrefs_PRIVATE_FRAMEWORKS = Preferences
ZenithDarkPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ZenithDarkPrefs.plist$(ECHO_END)

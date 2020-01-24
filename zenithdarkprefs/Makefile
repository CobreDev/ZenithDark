ARCHS = arm64 arm64e
SDK = iPhoneOS12.2
FINALPACKAGE = 1
TARGET = iphone:12.2:13.0


include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ZenithDarkPrefs
ZenithDarkPrefs_FILES = ZNDarkPrefsRootListController.m
ZenithDarkPrefs_INSTALL_PATH = /Library/PreferenceBundles
ZenithDarkPrefs_FRAMEWORKS = UIKit
ZenithDarkPrefs_PRIVATE_FRAMEWORKS = Preferences
ZenithDarkPrefs_EXTRA_FRAMEWORKS = Cephei CepheiPrefs


include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ZenithDarkPrefs.plist$(ECHO_END)

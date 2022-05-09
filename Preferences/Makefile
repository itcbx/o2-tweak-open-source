ARCHS = arm64 arm64e
TARGET = ::13.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = o2Prefs

o2Prefs_FILES = $(wildcard *.m) $(wildcard *.mm) $(wildcard SkittyPrefs/*.m) $(wildcard libappearancecell/AppearanceCell/*.m) ../Welcome.m ../DuoTwitterCell.m ../KRTableCell.m ../KRLinkCell.m
o2Prefs_FRAMEWORKS = UIKit AppSupport
o2Prefs_PRIVATE_FRAMEWORKS = Preferences SpringBoardUIServices SpringBoardServices OnBoardingKit SpringBoardFoundation

o2Prefs_INSTALL_PATH = /Library/PreferenceBundles
o2Prefs_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unguarded-availability-new
o2Prefs_LIBRARIES += rocketbootstrap applist CSPreferences

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
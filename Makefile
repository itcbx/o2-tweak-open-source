ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
DEBUG = 0
FINALPACKAGE = 1
export COPYFILE_DISABLE = 1
include $(THEOS)/makefiles/common.mk
INSTALL_TARGET_PROCESSES = backboardd SpringBoard
TWEAK_NAME =  o2SpringBoard
o2SpringBoard_LDFLAGS = ./IOKit.tbd
o2SpringBoard_FILES = Applist.x Welcome.m HBPreferences+Helpers.m Tweak.xm
o2SpringBoard_CFLAGS = -fobjc-arc -Wno-unguarded-availability-new -Iheaders -Wno-deprecated-declarations -Wno-unused-value -Wno-logical-op-parentheses -DTHEOS_LEAN_AND_MEAN -Wno-incompatible-pointer-types
o2SpringBoard_EXTRA_FRAMEWORKS += Cephei
o2SpringBoard_LIBRARIES += rocketbootstrap applist  MobileGestalt  h2splitview
o2SpringBoard_FRAMEWORKS = LocalAuthentication MediaAccessibility UIKit CFNetwork CoreTelephony CoreGraphics Foundation
o2SpringBoard_PRIVATE_FRAMEWORKS += OnBoardingKit UIKit TelephonyUtilities SpringBoardUIServices AppSupport BulletinBoard CoreDuet MediaRemote  ControlCenterUIKit AccessibilityUtilities SpringBoardUIServices
SUBPROJECTS += o2 Preferences
include $(THEOS)/makefiles/bundle.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
after-install::
	install.exec "killall -9 SpringBoard"
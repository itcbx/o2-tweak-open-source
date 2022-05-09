INSTALL_TARGET_PROCESSES = SpringBoard
include $(THEOS)/makefiles/common.mk
TWEAK_NAME =  o2Split
export ARCHS= arm64 arm64e

o2Split_FILES = $(wildcard *.m) $(wildcard *.mm)
o2Split_CFLAGS = -fobjc-arc -DTHEOS_LEAN_AND_MEAN -Wno-deprecated-declarations -Wno-everything
o2Split_EXTRA_FRAMEWORKS += Cephei
o2Split_PRIVATE_FRAMEWORKS += MediaRemote
o2Split_LIBRARIES += MobileGestalt applist
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

RED=\033[0;31m
CYAN=\033[0;36m
NC=\033[0m
BOLD=\033[1m

ifneq (,$(filter x86_64 i386,$(ARCHS)))
setup:: clean all
	@rm -f /opt/simject/$(TWEAK_NAME).dylib
	@cp -v $(THEOS_OBJ_DIR)/$(TWEAK_NAME).dylib /opt/simject/$(TWEAK_NAME).dylib
	@codesign -f -s - /opt/simject/$(TWEAK_NAME).dylib
	@cp -v $(PWD)/$(TWEAK_NAME).plist /opt/simject
	@resim
	@echo 
	@echo -e "${BOLD}Finished Compiling:${NC} ${RED}$(TWEAK_NAME)${NC} ~ ${CYAN}Chr1s${NC}"
endif
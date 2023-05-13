ROOTLESS ?= 0

ARCHS = arm64 arm64e
THEOS_DEVICE_IP = localhost -p 2222
INSTALL_TARGET_PROCESSES = SpringBoard
TARGET = iphone:clang:16.4:14.5
PACKAGE_VERSION = 2.0.0

# Rootless / Rootful settings
ifeq ($(ROOTLESS),1)
	export THEOS_PACKAGE_SCHEME = rootless
	# Control
	PKG_NAME_SUFFIX = (Rootless)
endif

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DualClock2

DualClock2_PRIVATE_FRAMEWORKS = SpringBoard
DualClock2_FILES = $(shell find Sources/DualClock2 -name '*.swift') $(shell find Sources/DualClock2C -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
DualClock2_SWIFTFLAGS = -ISources/DualClock2C/include
DualClock2_CFLAGS = -fobjc-arc -ISources/DualClock2C/include

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += dualclock2
include $(THEOS_MAKE_PATH)/aggregate.mk

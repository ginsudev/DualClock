ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:14.5

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = dualclock2

dualclock2_EXTRA_FRAMEWORKS = Comet
dualclock2_FRAMEWORKS = SwiftUI
dualclock2_FILES = $(shell find Sources/dualclock2 -name '*.swift') $(shell find Sources/dualclock2C -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
dualclock2_SWIFTFLAGS = -ISources/dualclock2C/include
dualclock2_INSTALL_PATH = /Library/PreferenceBundles
dualclock2_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

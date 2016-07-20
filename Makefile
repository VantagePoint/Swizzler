# =====================================================
# Swizzler for iOS
# Created by Vincent Tan (vincent@vantagepoint.sg)
#
# File Description:
#	Makefile for Swizzler
# =====================================================

# Make for the different iOS architectures
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

CFLAGS+= -Iinclude/
LDFLAGS+= -lxml2 -lz CocoaLumberjack/CocoaLumberjack.a CocoaHTTPServer/CocoaHTTPServer.a -mios-version-min=7.0


TWEAK_NAME = swizzler
swizzler_FILES = Tweak.xmi \
				CocoaHTTPServer/swizzler.HTTPConnection.xm \
				CocoaHTTPServer/swizzler.HTTPSConnection.xm \
				swizzler.common.xm \
				hooks/C/C_function_hooks_section2.xm \
				hooks/C/C_function_hooks_section3.xm \
				hooks/C/CommonCrypto_function_hooks.xm \
				hooks/CoreFoundation/CFData_function_hooks.xm \
				hooks/CoreFoundation/CFReadStream_function_hooks.xm \
				hooks/CoreFoundation/CFSocket_function_hooks.xm \
				hooks/CoreFoundation/CFString_function_hooks.xm \
				hooks/CoreFoundation/CFWriteStream_function_hooks.xm \
				hooks/OpenSSL/OpenSSL_Crypto_function_hooks.xm \
				hooks/OpenSSL/OpenSSL_SSL_function_hooks.xm \
				hooks/sqlite3/sqlite3_sqlcipher_function_hooks.xm \
				hooks/GoodDynamics/GD/Headers/sqlite3enc.xm


swizzler_LIBRARIES = substrate
swizzler_FRAMEWORKS = CFNetwork, Security, UIKit, CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk


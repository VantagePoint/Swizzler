#!/bin/bash
# =====================================================
# File Description:
# 	Build script for CocoaLumberjack
# =====================================================

SDKPATH=`xcrun -sdk iphoneos --show-sdk-path`


# remove object files to build nice n clean
echo '[+] Removing old files ...'
rm *.o *.a

echo '[+] Compiling Objective-C files ...'
#**********************************
# Compiling for armv7
#**********************************
echo '[+] Creating CocoaHTTPServer_armv7.a archive'
clang -c *.m CLI/*.m -arch armv7 -isysroot $SDKPATH -fobjc-arc -mios-version-min=7.0
ar -r CocoaLumberjack_armv7.a *.o >/dev/null 2>&1
rm *.o 

#**********************************
# Compiling for armv7s
#**********************************
echo '[+] Creating CocoaHTTPServer_armv7.a archive'
clang -c *.m CLI/*.m -arch armv7s -isysroot $SDKPATH -fobjc-arc -mios-version-min=7.0
ar -r CocoaLumberjack_armv7s.a *.o >/dev/null 2>&1
rm *.o 

#**********************************
# Compiling for arm64
#**********************************
echo '[+] Creating CocoaHTTPServer_arm64.a archive'
clang -c *.m CLI/*.m -arch arm64 -isysroot $SDKPATH -fobjc-arc -mios-version-min=7.0
ar -r CocoaLumberjack_arm64.a *.o >/dev/null 2>&1

#**********************************
# Create archive
#**********************************
echo '[+] Building multiplatform archive'
lipo -output CocoaLumberjack.a -create CocoaLumberjack_armv7.a CocoaLumberjack_armv7s.a CocoaLumberjack_arm64.a

echo '[+] Cleaning up ...'
rm *.o
echo '[+] The CocoaLumberjack built!'




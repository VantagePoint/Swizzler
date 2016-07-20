#!/bin/bash
# =====================================================
# File Description:
#	We are not building CocoaLumber in this project because we are building it as a separate library.
# =====================================================

SDKPATH=`xcrun -sdk iphoneos --show-sdk-path`


echo '[+] Removing old files ...'
rm *.o *.a

echo '[+] Compiling Objective-C files ...'
#**********************************
# Compiling for armv7
#**********************************
echo '[+] Creating CocoaHTTPServer_armv7.a archive'
clang -c *.m Categories/*.m Responses/*.m Mime/*.m Vendor/CocoaAsyncSocket/*.m -arch armv7 -isysroot $SDKPATH -Wno-arc-bridge-casts-disallowed-in-nonarc -Wno-trigraphs -fobjc-arc -I /usr/include/libxml2 -mios-version-min=7.0
ar -r CocoaHTTPServer_armv7.a *.o >/dev/null 2>&1
rm *.o 

#**********************************
# Compiling for armv7s
#**********************************
echo '[+] Creating CocoaHTTPServer_armv7s.a archive'
clang -c *.m Categories/*.m Responses/*.m Mime/*.m Vendor/CocoaAsyncSocket/*.m -arch armv7s -isysroot $SDKPATH -Wno-arc-bridge-casts-disallowed-in-nonarc -Wno-trigraphs -fobjc-arc -I /usr/include/libxml2 -mios-version-min=7.0
ar -r CocoaHTTPServer_armv7s.a *.o >/dev/null 2>&1
rm *.o 

#**********************************
# Compiling for arm64
#**********************************
echo '[+] Creating CocoaHTTPServer_arm64.a archive'
clang -c *.m Categories/*.m Responses/*.m Mime/*.m Vendor/CocoaAsyncSocket/*.m -arch arm64 -isysroot $SDKPATH -Wno-arc-bridge-casts-disallowed-in-nonarc -Wno-trigraphs -fobjc-arc -I /usr/include/libxml2 -mios-version-min=7.0
ar -r CocoaHTTPServer_arm64.a *.o >/dev/null 2>&1

#**********************************
# Create archive
#**********************************
echo '[+] Building multiplatform archive'
lipo -output CocoaHTTPServer.a -create CocoaHTTPServer_armv7.a CocoaHTTPServer_armv7s.a CocoaHTTPServer_arm64.a

echo '[+] Cleaning up ...'
rm *.o
echo '[+] The CocoaHTTPServer built!'

#!/bin/bash
# =====================================================
# File Description:
#	This file sets up the THEOS environment by setting
#	the THEOS_DEVICE_IP and THEOS_DEVICE_PORT
# =====================================================

echo "[+] Key in device IP followed by [ENTER]:"
read ip

echo "[+] Key in device SSH port followed by [ENTER]:"
read port

echo "[+] Setting THEOS with the following: $ip $port"
export THEOS_DEVICE_IP=$ip
export THEOS_DEVICE_PORT=$port

echo "[+] Environment setup complete! Enjoy!"

# Swizzler for iOS

Everything here is in a beta stage and stuff maybe unstable.


## License
GNU GPLv3


## Installation

### Binary Installation
1. Download the latest binary release from https://github.com/vtky/Swizzler/releases
2. Upload to iOS device and run the following command: `dpkg -i me.vtky.swizzler_0.1.0-1_iphoneos-arm.deb`

### Self Compilation

#### Requirements

* X Code
* Theos Framework (https://github.com/rpetrich/theos)

1. Symlink theos to the swizzler directory
2. Port forward iOS device SSH to local port
	* ./tcprelay.py -t 22:2222
3. `source setup.sh`
4. make package install

## Usage
Please refer to the Usage document (https://github.com/vtky/Swizzler/USAGE.md)
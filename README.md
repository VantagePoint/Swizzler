# Swizzler for iOS

Everything here is in a beta stage and stuff maybe unstable.


## License
GNU GPLv3


## Installation

### Requirements

* X Code
* Theos Framework (https://github.com/rpetrich/theos)

### Steps

1. Symlink theos to the swizzler directory
2. Port forward iOS device SSH to local port
	* ./tcprelay.py -t 22:2222
3. `> source setup.sh`
4. make package install
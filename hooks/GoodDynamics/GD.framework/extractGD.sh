#!/bin/bash

lipo -thin armv7 GD -output GD.armv7
lipo -thin armv7s GD -output GD.armv7s
lipo -thin arm64 GD -output GD.arm64

#mkdir armv7
#mkdir armv7s
#mkdir arm64

#cd armv7
#ar x ../GD.armv7
#cd ..

#cd armv7s
#ar x ../GD.armv7s
#cd ..

#cd arm64
#ar x ../GD.arm64
#cd ..




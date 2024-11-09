#!/bin/bash

set -euxo pipefail

# Install the current package with verbose output
python -m pip install . -vv \
    --global-option=build_ext \
    --global-option=--cmake-args='
        -DMOMENTUM_BUILD_IO_FBX=OFF
        -DMOMENTUM_BUILD_EXAMPLES=OFF
        -DMOMENTUM_BUILD_TESTING=ON
        -DMOMENTUM_ENABLE_SIMD=$MOMENTUM_ENABLE_SIMD
        -DMOMENTUM_USE_SYSTEM_GOOGLETEST=ON
        -DMOMENTUM_USE_SYSTEM_PYBIND11=OFF
        -DMOMENTUM_USE_SYSTEM_RERUN_CPP_SDK=ON
    '

# Copy all .so files to the target directory except those containing 'test' in the filename
mkdir -p "$SP_DIR/pymomentum"
find pymomentum -name "*.so" ! -name "*test*" -exec cp {} "$SP_DIR/pymomentum" \;
ls "$SP_DIR/pymomentum"

#!/bin/bash
set -e

git submodule update --init --recursive

pip install --upgrade pip
pip install cython

# Build TVM first
cd 3rdparty/tvm
mkdir -p build && cd build
cmake .. -DUSE_CUDA=OFF -DUSE_VULKAN=OFF
cmake --build . --parallel $(nproc)
cd ../../

# Now build the main project, ensuring correct TVM path
export TVM_HOME="$(pwd)/3rdparty/tvm"
mkdir -p build && cd build
cmake .. \
  -DTVM_HOME="$TVM_HOME" \
  -DUSE_CUDA=OFF \
  -DUSE_VULKAN=OFF
cmake --build . --parallel $(nproc)

echo "✅ Build complete"

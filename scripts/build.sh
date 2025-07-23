#!/bin/bash
set -e
git submodule update --init --recursive

cd 3rdparty/tvm
mkdir -p build && cd build
cmake .. -DUSE_CUDA=OFF -DUSE_VULKAN=OFF
cmake --build . --parallel $(nproc)
cd ../../

mkdir -p build && cd build
cmake .. -DUSE_CUDA=OFF -DUSE_VULKAN=OFF
cmake --build . --parallel $(nproc)

echo "✅ Build complete"

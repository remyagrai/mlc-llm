#!/bin/bash
set -e
mode=${1:-dev}

if [ "$mode" = "build" ]; then
  ./scripts/build.sh
elif [ "$mode" = "test" ]; then
  ./scripts/build.sh
  cd build && ctest --parallel $(nproc)
else
  exec /bin/bash
fi

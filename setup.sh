#!/bin/bash

cmake -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_PYTHON_WRAPPER=ON \
    -DPython3_EXECUTABLE=$(which python)
sudo cmake --build build --target install
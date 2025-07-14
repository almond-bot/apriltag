#!/bin/bash

cmake -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_PYTHON_WRAPPER=ON \
    -DPython3_EXECUTABLE=$(which python)
sudo cmake --build build --target install

if [ ! -f /etc/ld.so.conf.d/usr-local.conf ] || ! grep -q "/usr/local/lib" /etc/ld.so.conf.d/usr-local.conf; then
    echo "/usr/local/lib" | sudo tee /etc/ld.so.conf.d/usr-local.conf
fi
sudo ldconfig
ldconfig -p | grep libapriltag
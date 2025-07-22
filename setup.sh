#!/bin/bash

# Explicitly get NumPy include path and version
NUMPY_INCLUDE=$(python -c "import numpy; print(numpy.get_include())")
NUMPY_VERSION=$(python -c "import numpy; print(numpy.__version__)")

echo "Using NumPy version: $NUMPY_VERSION"
echo "NumPy include path: $NUMPY_INCLUDE"

cmake -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_PYTHON_WRAPPER=ON \
    -DPython3_EXECUTABLE=$(which python) \
    -DCMAKE_C_FLAGS="-I$NUMPY_INCLUDE -DNPY_NO_DEPRECATED_API=NPY_1_7_API_VERSION" \
    -DCMAKE_CXX_FLAGS="-I$NUMPY_INCLUDE -DNPY_NO_DEPRECATED_API=NPY_1_7_API_VERSION"

sudo cmake --build build --target install

if [ ! -f /etc/ld.so.conf.d/usr-local.conf ] || ! grep -q "/usr/local/lib" /etc/ld.so.conf.d/usr-local.conf; then
    echo "/usr/local/lib" | sudo tee /etc/ld.so.conf.d/usr-local.conf
fi
sudo ldconfig
ldconfig -p | grep libapriltag
#!/bin/bash

echo "Change to to source folder"

cd /src/MPD

echo "Build MPD"

meson setup . output/release --buildtype=debugoptimized -Db_ndebug=true
meson configure output/release -Dsysconfdir='/etc'

ninja -C output/release

if [ $? -eq 0 ]; then
    echo "Build OK" | figlet
fi

echo "Install MPD"

ninja -C output/release install

if [ $? -eq 0 ]; then
    echo "Install OK" | figlet
fi

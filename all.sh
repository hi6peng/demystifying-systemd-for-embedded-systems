#!/bin/bash

set -xe

./fetch.sh
./extract.sh
./prepare.sh
./compile-kernel.sh
./compile-systemd.sh
./systemd-minimal-strip.sh
./systemd-initramfs-all.sh
./busybox-initramfs.sh
./report.sh

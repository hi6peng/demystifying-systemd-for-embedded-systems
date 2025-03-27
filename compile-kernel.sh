#!/bin/bash

. versions.sh

BASEDIR=$PWD

rm -fr kernel
mkdir kernel
pushd kernel

set -xe

mkdir -p kernel/x86_64_defconfig
pushd ${BASEDIR}/src/linux-${KERNEL_VERSION}

make x86_64_defconfig

make -j$(nproc)
cp -a `make -s image_name` ${BASEDIR}/kernel/x86_64_defconfig
popd


mkdir -p kernel/minimal
pushd ${BASEDIR}/src/linux-${KERNEL_VERSION}

make allnoconfig
scripts/kconfig/merge_config.sh -m .config ${BASEDIR}/kernel-minimal-x86_64.config
yes "" | make oldconfig

make -j$(nproc)
cp -a `make -s image_name` ${BASEDIR}/kernel/minimal
popd


mkdir -p kernel/systemd
pushd ${BASEDIR}/src/linux-${KERNEL_VERSION}

make allnoconfig
scripts/kconfig/merge_config.sh -m .config ${BASEDIR}/kernel-minimal-x86_64.config
scripts/kconfig/merge_config.sh -m .config ${BASEDIR}/kernel-systemd-x86_64.config
yes "" | make oldconfig

make -j$(nproc)
cp -a `make -s image_name` ${BASEDIR}/kernel/systemd
popd

mkdir -p kernel/systemd-minimal
pushd ${BASEDIR}/src/linux-${KERNEL_VERSION}

make allnoconfig
scripts/kconfig/merge_config.sh -m .config ${BASEDIR}/kernel-minimal-x86_64.config
scripts/kconfig/merge_config.sh -m .config ${BASEDIR}/kernel-systemd-minimal-x86_64.config
yes "" | make oldconfig

make -j$(nproc)
cp -a `make -s image_name` ${BASEDIR}/kernel/systemd-minimal
popd


popd

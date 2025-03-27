#!/bin/bash

. versions.sh

BASEDIR=$PWD

rm -fr systemd
mkdir systemd
pushd systemd

set -xe

mkdir -p vanilla/build
pushd vanilla/build
CFLAGS="-O2 -ftrapv" meson setup ${BASEDIR}/src/systemd-${SYSTEMD_VERSION}/ \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --libdir=/usr/lib \
    -Dman=false \
    -Dldconfig=false \
    -Dtests=false
meson compile -j$(nproc) --verbose
meson install --no-rebuild --destdir $PWD/../install
${BASEDIR}/systemd-install-strip.sh $PWD/../install
popd

mkdir -p easy-diet/build
pushd easy-diet/build
CFLAGS="-Os -ftrapv" meson setup ${BASEDIR}/src/systemd-${SYSTEMD_VERSION}/ \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --libdir=/usr/lib \
    -Dman=false \
    -Dldconfig=false \
    -Dtests=false \
    -Ddbus=false \
    -Dutmp=false \
    -Dkmod=false \
    -Dxkbcommon=false \
    -Dblkid=false \
    -Dseccomp=false \
    -Dima=false \
    -Dselinux=false \
    -Dapparmor=false \
    -Dadm-group=false \
    -Dwheel-group=false \
    -Dbzip2=false \
    -Dxz=false \
    -Dzlib=false \
    -Dlz4=false \
    -Dpam=false \
    -Dacl=false \
    -Dsmack=false \
    -Dgcrypt=false \
    -Daudit=false \
    -Delfutils=false \
    -Dlibcryptsetup=false \
    -Dqrencode=false \
    -Dgnutls=false \
    -Dmicrohttpd=false \
    -Dlibcurl=false \
    -Dlibidn=false \
    -Dlibidn2=false \
    -Didn=false \
    -Dnss-systemd=false \
    -Dresolve=false \
    -Dnss-myhostname=false \
    -Dgshadow=false \
    -Denvironment-d=false \
    -Dglib=false \
    -Dlibiptc=false \
    -Dbinfmt=false \
    -Dvconsole=false \
    -Dquotacheck=false \
    -Dtmpfiles=false \
    -Dsysusers=false \
    -Dfirstboot=false \
    -Drandomseed=false \
    -Dbacklight=false \
    -Drfkill=false \
    -Dlogind=false \
    -Dmachined=false \
    -Dimportd=false \
    -Dhostnamed=false \
    -Dtimedated=false \
    -Dtimesyncd=false \
    -Dlocaled=false \
    -Dcoredump=false \
    -Dpolkit=false \
    -Dnetworkd=false \
    -Defi=false \
    -Dtpm=false \
    -Dhwdb=false \
    -Dhibernate=false \
    -Dsysvrcnd-path=  \
    -Dsysvinit-path=
meson compile -j$(nproc) --verbose
meson install --no-rebuild --destdir $PWD/../install
${BASEDIR}/systemd-install-strip.sh $PWD/../install
popd

popd

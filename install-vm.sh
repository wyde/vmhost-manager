#!/bin/bash
if [ -z "$1" ]; then
    echo " Please input the domain name of vm as the 1st argument"
    exit 101
fi

if [ -z "$2" ]; then
    echo " Please input the size of image as the 2nd argument"
    exit 102
fi

NAME=$1
KSNAME=$NAME.cfg
KSPATH=/home/ops/vmhost-manager/kickstart/$KSNAME
DISKSIZE=$2
DISKPATH=/image/qcow2/$NAME.qcow2
ISOPATH=/image/iso/CentOS-7-x86_64-Everything-1708.iso 

if [ -f "$DISKPATH" ]
then
    echo "$DISKPATH already exists"
else
    qemu-img create -f qcow2 $DISKPATH $DISKSIZE"G"
    echo "$DISKPATH created"
fi

if [ -f "$KSPATH" ]
then
    echo " $KSPATH already exists...virt-intsallation begin"
else
    echo " $KSPATH could not been found"
    exit 103
fi

virt-install \
    --name $NAME \
    --vcpus 1 \
    --ram 1024 \
    --disk path=$DISKPATH,size=$DISKSIZE \
    --os-variant rhel7 \
    --network=bridge:br3 \
    --nographics \
    --initrd-inject $KSPATH \
    --extra-args "ks=file:/$KSNAME console=tty0 console=ttyS0,115200n8" \
    --location=$ISOPATH \
    --autostart \
    --noautoconsole \
    --debug

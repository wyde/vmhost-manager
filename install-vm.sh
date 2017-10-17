#!/bin/bash
if [ -z "$1" ]; then
        echo "Please input the domain name of vm as the first argument"
fi

if [ -z "$2" ]; then
        echo "Please input the size of image as the second argument"
fi

NAME=$1
KSNAME=$NAME.cfg
KSPATH=/home/ops/vmhost-manager/kickstart/$KSNAME
DISKSIZE=$2"G"
DISKPATH=/image/qcow2/$NAME.qcow2

if [ -f "$DISKPATH" ]
then
    echo "$DISKPATH already exists...virt-intsallation begin"
else
    qemu-img create -f qcow2 $DISKPATH $DISKSIZE
fi


virt-install \
    --name $NAME \
    --vcpus 1 \
    --ram 1024 \
    --disk path=/image/qcow2/$NAME.qcow2 \
    --disk size=DISKSIZE \
    --os-variant rhel7 \
    --network=bridge:br1 \
    --network=bridge:br2 \
    --nographics \
    --initrd-inject $KSPATH \
    --extra-args "ks=file:/$KSNAME console=tty0 console=ttyS0,115200n8" \
    --location=/image/iso/CentOS-7-x86_64-Everything-1708.iso \
    --noautoconsole

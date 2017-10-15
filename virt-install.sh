NAME=vm-testing
KSNAME=$NAME.cfg
ISONAME=CentOS-7-x86_64-Everything-1708.iso
DISKSIZE=50G

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
    --initrd-inject /home/ops/hostmanager/kickstart/$KSNAME \
    --extra-args "ks=file:/$KSNAME console=tty0 console=ttyS0,115200n8" \
    --location=/image/iso/$ISONAME \
    --noautoconsole

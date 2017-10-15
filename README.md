vmhost-manager
===

## Category:
- System Administration

## Overview
- create customize scripts on stand alone virtualization platform on physical machine
- 這個 repo 的目的是在個別的實體機上客制化管理 KVM 虛擬化平台的 scripts，雖然有 virsh ，python 也有 libvirt module，但是不是很符合需求，希望用 yaml 檔管理單一實體機上所有 vm 的簡單配置，從 create 、 resize 、 backup... 之類的，目標像是 vagrant ，但不用那麼複雜

## Developement Env
### OS
- Virtualization Host: CentOS 7
- Guest VM: CentOS 7

### Developing Language
- shell script

### Tools
- kickstart file

## Changelog
- 0.0.20171015

## License
MIT

#!/usr/bin/env bash

echo "PACKER_BUILD_NAME is ${PACKER_BUILD_NAME}"
echo "PACKER_BUILDER_TYPE is ${PACKER_BUILDER_TYPE}"
echo "PACKER_HTTP_ADDR is ${PACKER_HTTP_ADDR}"

if [ "${PACKER_BUILDER_TYPE}" == "vmware-vmx" ]
then
    echo "VMWare no longer supported"
    exit 69
else
    echo "Installing VirtualBox Guest Additions"
    until sudo apt-get --yes update; do echo "Waiting for apt lock"; sleep 5; done
    sudo apt-get update
    until sudo apt-get --yes update; do echo "Waiting for apt lock"; sleep 5; done
    sudo apt-get --yes install gcc make perl

    VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
    VBOX_ISO=VBoxGuestAdditions_$VBOX_VERSION.iso
    sudo mount -o loop ${VBOX_ISO} /mnt
    sudo /mnt/VBoxLinuxAdditions.run
    sudo umount /mnt
    sudo rm -rf /home/vagrant/${VBOX_ISO}
fi


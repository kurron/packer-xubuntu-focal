# Overview
This project creates an Xubuntu 20.04 box with software development tools installed.

# Prerequisites
* a working [Packer](https://www.packer.io/) installation
* a working [Vagrant](https://www.vagrantup.com/) installation
* a working [Hyper-V](https://en.wikipedia.org/wiki/Hyper-V) installation

## Hyper-V Installation
The video [How to Setup Hyper V on Windows](https://youtu.be/FCIA4YQHx9U) is a great place to start. His use of toolbox for installation works well on Windows 10 and [can be found here](https://github.com/ChrisTitusTech/win10script). Some highlights:
* disable `Enhanced Session Mode Policy`
* when creating the external virtual switch, name it `LAN` as this is what Packer is expecting to find

## Base Xubuntu VM
Packer uses an existing VM as its source when creating the Vagrant box.  This base VM should only have enough software installed to allow Packer to do its job.

### Hyper V Settings
* Select Generation 2
* 4096 of RAM (disable dynamic memory)
* Select the external switched (LAN)
* 128 GB of disk space is sufficient
* Select the [Xubuntu ISO](https://xubuntu.org/) downloaded from the website. The current LTS is recommended.
* **Before** starting the VM, make a few additional configuration changes
* Disable `Enable Secure Boot`
* Set `Number of virtual processors` to 2
* In `Integration Services` disable `Guest services` and `Backup`
* Disable `Enable checkpounts`
* In `Automatic Start Action`, select `Nothing`
* In `Automatic Stop Action`, select `Shut down the guest operating system` 

### Xubuntu Installation
* Allow downloading of updates during the install
* Username and password **must** be `vagrant`/`vagrant` or Packer and Ansible won't work
* Reboot the VM and log in
* `sudo vi /etc/sudoers.d/passwordless` with the following contents to enable passwordless `sudo`
* `sudo chmod 0400 /etc/sudoers.d/passwordless`
* `sudo apt update`
* `sudo apt install curl openssh-server linux-tools-$(uname -r) linux-cloud-tools-$(uname -r) linux-cloud-tools-common`. See [this ticket](https://github.com/hashicorp/packer/issues/5049) for details
* reboot the VM
* log in and obtain the VM's ip adderess: `ip address`
* verify that the host machine can ssh into that address
* shutdown the VM

```
%sudo    ALL=(ALL)  NOPASSWD:ALL
%wheel   ALL=(ALL)  NOPASSWD:ALL
Defaults !requiretty
```

# Building
Type `./build.sh` to build the server box.

# Installation
The scripts will automatically install the newly built box into Vagrant's cache. Publication to [Hashicorp's Cloud Platform](https://app.vagrantup.com/) must be done manually.

# Tips and Tricks

## Testing The Box
`vagrant up` will launch the server VM. Once you are satisfied that the box built correctly, use `vagrant destroy` to remove it.

# Troubleshooting

## Why is the display resolution of my VM so small?
You need to tell Hyper-V that you want to start your VM at a specified resolution. One way to do that is to open a Powershell with administrative rights and run `Set-VMVideo -VMName 'my vm name' -HorizontalResolution 1920 -VerticalResolution 1080 -ResolutionType Single`, replacing the VM name and resolution values. This cannot be done until **after** the Vagrant box has been created. Use the Hyper-V Manager to obtain the name of the VM. The VM must be *off* for this operation to succeed.

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).

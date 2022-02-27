#!/usr/bin/env bash

# improve the RDP experience that Hyper-V uses to connect to the VM
# see https://c-nergy.be/blog/?p=17175 for details
# cd /tmp && wget https://raw.githubusercontent.com/ChrisTitusTech/win10script/master/HyperV%20Tools/deb.sh && chmod +x deb.sh && ./deb.sh

cd /tmp && wget https://www.c-nergy.be/downloads/xRDP/xrdp-installer-1.3.zip && unzip xrdp-installer-1.3.zip && chmod +x xrdp-installer-1.3.sh && ./xrdp-installer-1.3.sh 
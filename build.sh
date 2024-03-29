#!/usr/bin/env bash

PROGNAME=$(basename $0)
error_exit()
{
	  echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	  exit 1
}

SLEEP=${1:-1}
echo "Sleeping for ${SLEEP} seconds..."
sleep ${SLEEP} || error_exit "Unable to sleep..."

export PACKER_LOG=activate
export PACKER_LOG_PATH=packer-log.txt

# use this a the version tag
UNIXTIME=$(date +%s)

PACKER_FILE=${2:-packer.json}

VALIDATE="packer validate ${PACKER_FILE}"
echo ${VALIDATE}
${VALIDATE} || error_exit "Unable to validate Packer file."

# build all platforms
BUILD="packer build --force ${PACKER_FILE}"
echo ${BUILD}
${BUILD} || error_exit "Unable to execute build."

vagrant box add --clean --force --name focal-xubuntu --provider hyperv vagrant/xubuntu-focal-hyperv.box || error_exit "Unable to add Hyper-V box."

vagrant box list || error_exit "Unable to list Vagrant boxes." || error_exit "Unable to list newly built files."

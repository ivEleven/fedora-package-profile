#!/bin/bash
HOME=/home/iv/temp/fedora-package-profile
source var.sh

PROFILE_NAME=profile
while getopts ":f:" opt; do
  case $opt in
    f)
      PROFILE_NAME=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done


#prepare
mkdir $PROFILE
mkdir $PROFILE/$REPOS

#get package list
rpm -qa --qf "%{NAME}\n" > $PACKAGE_LIST_FILE

#get yum repositories
cp -rf $YUM_REPO_PATH/** $REPOS_DIR/

#archive file
tar -zcf $PROFILE_NAME.tar.gz $PROFILE

#clean up
rm -rf $PROFILE

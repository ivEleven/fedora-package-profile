#!/bin/bash
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
mkdir $PROFILE_DIR
mkdir $PROFILE_DIR/$REPOS_DIR

#get package list
rpm -qa --qf "%{NAME}\n" > ./$PROFILE_DIR/$PACKAGE_LIST_FILE

#get yum repositories
cp -rf $YUM_REPO_PATH/** ./$PROFILE_DIR/$REPOS_DIR/

#archive file
tar -zcf $PROFILE_NAME.tar.gz $PROFILE_DIR

#clean up
rm -rf $PROFILE_DIR

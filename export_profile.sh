#!/bin/bash
source var.sh

mkdir $PROFILE_DIR
mkdir $PROFILE_DIR/$REPOS_DIR
rpm -qa --qf "%{NAME}\n" > ./$PROFILE_DIR/$PACKAGE_LIST_FILE
cp -rf /etc/yum.repos.d/** ./$PROFILE_DIR/$REPOS_DIR/
tar -zcf $PROFILE_DIR.tar.gz $PROFILE_DIR
rm -rf $PROFILE_DIR

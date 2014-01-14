#!/bin/bash
source var.sh

#get the profile file
#curl something

tar -xzvf $PROFILE_DIR.tar.gz
#copy the repositories of the profile
cp -rf $PROFILE_DIR/$REPOS_DIR/** $YUM_REPO_PATH

#install the packages specified in insalled_packages
while read -r line
do
    name=$line
    echo ""
    echo "Install package "$name
    eval yum install -y $name
done < "$PACKAGE_LIST_FILE"

#remove the packages mentioned in remove_packges
filename=remove_packages
while read -r line
do
    name=$line
    echo ""
    echo "Remove package "$name
    eval yum remove -y $name
done < "$REMOVE_PACKAGE_LIST_FILE"

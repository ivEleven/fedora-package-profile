#!/bin/bash
HOME=/home/iv/temp/fedora-package-profile

source $HOME/var.sh

#check if it's executed as root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
fi

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

tar -xzvf $HOME/$PROFILE_NAME.tar.gz -C $HOME

#copy the repositories of the profile
cp -rf $REPOS_DIR/** $YUM_REPO_PATH

#install the packages specified in insalled_packages
if [ -f $PACKAGE_LIST_FILE ]
then
   while read -r line
   do
     name=$line
     echo ""
     echo "Install package "$name
     eval yum install -y $name
   done < "$PACKAGE_LIST_FILE"
fi


#remove the packages mentioned in remove_packges
if [ -f $REMOVE_PACKAGE_LIST_FILE ]
then
  while read -r line
  do
    name=$line
    echo ""
    echo "Remove package "$name
    eval yum remove -y $name
  done < "$REMOVE_PACKAGE_LIST_FILE"
fi

echo "Done"

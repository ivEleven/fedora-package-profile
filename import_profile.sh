#!/bin/bash
source var.sh

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

tar -xzvf $PROFILE_NAME.tar.gz

#copy the repositories of the profile
cp -rf $PROFILE_DIR/$REPOS_DIR/** $YUM_REPO_PATH

#install the packages specified in insalled_packages
if [ -f $PROFILE_DIR/$PACKAGE_LIST_FILE ]
then
   while read -r line
   do
     name=$line
     echo ""
     echo "Install package "$name
     eval yum install -y $name
   done < "$PROFILE_DIR/$PACKAGE_LIST_FILE"
fi


#remove the packages mentioned in remove_packges
if [ -f $PROFILE_DIR/$REMOVE_PACKAGE_LIST_FILE ]
then
  while read -r line
  do
    name=$line
    echo ""
    echo "Remove package "$name
    eval yum remove -y $name
  done < "$PROFILE_DIR/$REMOVE_PACKAGE_LIST_FILE"
fi

echo "Done"

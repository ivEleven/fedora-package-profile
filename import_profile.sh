#!/bin/bash

#copy the repositories of the profile
cp -rf repos/** /etc/yum.repos.d/

#install the packages specified in insalled_packages
filename=installed_packages
while read -r line
do
    name=$line
    echo ""
    echo "Install package "$name
    eval yum install -y $name
done < "$filename"

#remove the packages mentioned in remove_packges
filename=remove_packages
while read -r line
do
    name=$line
    echo ""
    echo "Remove package "$name
    eval yum remove -y $name
done < "$filename"

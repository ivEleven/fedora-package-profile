#!/bin/bash
rpm -qa --qf "%{NAME}\n" > installed_packages
mkdir repos
cp -rf /etc/yum.repos.d/** ./repos/

#!/bin/bash
dnf update -y
dnf clean all
nohup killall -u centos; sleep 2; usermod -d /home/centos centos & userdel -r centos; shutdown
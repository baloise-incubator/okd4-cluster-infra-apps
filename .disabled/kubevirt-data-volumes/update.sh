#!/bin/bash
dnf update -y
dnf clean all
rm -f /var/log/cloud-init.log && rm -Rf /var/lib/cloud/*
nohup killall -u centos; sleep 2; usermod -d /home/centos centos & userdel -r centos;
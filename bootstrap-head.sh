#!/usr/bin/env bash

yum makecache
yum -y install epel-release
yum -y install ansible

echo "*** yippie ***"

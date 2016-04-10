#!/bin/bash -xe

# Copyright (C) 2014 OpenStack Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
#
# See the License for the specific language governing permissions and
# limitations under the License.

#modify the DNS
sudo cat > /etc/resolv.conf <<EOF
namespace 114.114.114.114
EOF

#modify the pip resource
if [ ! -f /etc/pip.conf ]; then
    sudo touch /etc/pip.conf
fi

sudo cat > /etc/pip.conf <<EOF
[global]
trusted-host = pypi.douban.com
index-url = http://pypi.douban.com/simple
timeout = 6000
[install]
use-mirrors = true
mirrors =http://pypi.douban.com
EOF

#copy the squid.crt file
if [ -f /usr/local/share/ca-certificates/squid.crt ]; then
    sudo rm /usr/local/share/ca-certificates/squid.crt
fi
sudo cp ./squid.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates

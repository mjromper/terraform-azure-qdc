#!/bin/bash
echo 'Running Bootstrap'

sudo yum -y install git socat nfs-utils unzip  jq wget vim  bzip2   perl 
echo 'Updates installed'

sudo systemctl enable firewalld
sudo systemctl start firewalld

echo 'Bootstap completed'
#sleep 20
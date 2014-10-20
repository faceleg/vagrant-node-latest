#!/bin/sh
export DEBIAN_FRONTEND=noninteractive

APT_GET=/usr/bin/apt-get
$APT_GET -q -y install git puppet ruby

if [ `gem query --local | grep r10k | wc -l` -eq 0 ]; then
  sudo gem install r10k
fi

PUPPET_DIR='/vagrant/puppet'

cd $PUPPET_DIR
sudo r10k puppetfile install
sudo -E puppet apply -vv --modulepath=$PUPPET_DIR/modules/ $PUPPET_DIR/manifests/main.pp


#!/bin/sh
sudo puppet apply /opt/ning/gitpuppet/puppetest/puppet/manifests/site.pp  --modulepath=/opt/ning/gitpuppet/puppetest/puppet/modules $*


VAGRANT_REGISTRY?=fr123k/ubuntu21-rust
VERSION?=1.0.0
BOX_FILE?=package.box
PROVIDER?=virtualbox

build:
	vagrant up

clean:
	rm -f ${BOX_FILE}
	vagrant destroy -f

shell:
	vagrant ssh

package: build compress
	# ensure that gcc compiler is installed it will be removed uring the lib*-dev cleanup. Its needed for the rust compiler.
	vagrant package --output ${BOX_FILE}

# Remove everything that is not needed to srink the vagrant base box size
compress:
	vagrant ssh -c "sudo apt-get purge -y locate"
	vagrant ssh -c "sudo apt-get purge -y lib*-dev"
	vagrant ssh -c "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install gcc"
	vagrant ssh -c "sudo apt-get -y autoclean"
	vagrant ssh -c "sudo apt-get -y clean"
	vagrant ssh -c "sudo apt-get -y autoremove"
	vagrant ssh -c "df -h"
	# for easier virtual machine image comnpression just fill in the empty disk space with zero bits
	vagrant ssh -c "dd if=/dev/zero of=/tmp/EMPTY bs=1M; rm -f /tmp/EMPTY"

# Upload vagrant box to Vagrant Cloud (need )
publish: clean package
	vagrant cloud auth login
	vagrant cloud publish -f ${VAGRANT_REGISTRY} ${VERSION} ${PROVIDER} ${BOX_FILE}

import:
	vagrant box add --provider ${PROVIDER} ${VAGRANT_REGISTRY} ${BOX_FILE}

remove:
	vagrant box remove --all ${VAGRANT_REGISTRY}
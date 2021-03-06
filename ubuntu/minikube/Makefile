VAGRANT_REGISTRY?=fr123k/ubuntu21-minikube
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
	vagrant package --output ${BOX_FILE}

# Remove all docker images/containers/volumes created from minikube to save disk space
compress-minikube:
	# remove all the extracted minikube containers
	vagrant ssh -c "docker system df"
	vagrant ssh -c "docker builder -f prune"
	vagrant ssh -c "docker system prune -a -f"
	vagrant ssh -c "docker image prune --all -f"
	vagrant ssh -c "docker volume rm \$(docker volume ls -qf dangling=true) || true"
	# download the kicbase docker image for minikube
	# it contains the whole k8s control plane images
	vagrant ssh -c "docker system df"
	vagrant ssh -c "docker pull gcr.io/k8s-minikube/kicbase:v0.0.20"

# Remove everything that is not needed to srink the vagrant base box size
compress: compress-minikube
	vagrant ssh -c "sudo apt-get purge -y locate"
	vagrant ssh -c "sudo apt-get purge -y lib*-dev"
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
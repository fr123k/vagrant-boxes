# minikube

This box provides a minikube installation. The size of the base box is roughly 2 GB. 

# Vagrant Box

[ubuntu21-minikube](https://app.vagrantup.com/fr123k/boxes/ubuntu21-minikube)

# Usage

Use one of the following examples to use this minikube vagrant base box. After the vagrant virtual machine is started just use `vagrant ssh` to start a interactive user session.

```
  vagrant ssh
```

The current folder from where the vagrant machine was started is mounted at `/vagrant` folder.

## Vagrantfile

```
  Vagrant.configure("2") do |config|
    config.vm.box = "fr123k/ubuntu21-minikube"
    config.vm.box_version = "1.0.0"
  end
```

If you want to start your session in the `/vagrant` folder then use the following.

```
  Vagrant.configure("2") do |config|
    config.vm.box = "fr123k/ubuntu21-minikube"
    config.vm.box_version = "1.0.0"
    config.ssh.extra_args = ["-t", "cd /vagrant; bash --login"]
  end
```

You can change `cd /vagrant` to any folder you like to start you `vagrant ssh` session from.


## Vagrant Command line

```
  vagrant init fr123k/ubuntu21-minikube --box-version 1.0.0
  vagrant up
```

# Run Minikube

The minikube cluster has to be started 

```
  minikube start ${MINIKUBE_ARGS}
```

# Packages

Installation with `apt-get`
* VirtualBox Guest Additions (latest)
* curl (latest)
* git (latest)
* docker (latest)
* docker-compose (latest)
* helm (latest)

Download binaries
* minikube (latest)
* kubectl 1.21.0
* cri-tools 1.21.0

# Configuration

The following configuration is backed into the base box.
* vagrant user (non root)
* vm-driver docker

This can be changed of course check the `/home/vagrant/.bashrc` file.

To check the minikube configuration run the following command.
```
  cat $HOME/.bashrc 
```

The minikube configuration section is at the bottom of the `/home/vagrant/.bashrc` file.
And should look something like this.
```
  ...
  # Minikube configuration 
alias docker-env='source <(minikube -p minikube docker-env)'
export MINIKUBE_WANTUPDATENOTIFICATION=false
export MINIKUBE_ARGS='--vm-driver docker --kubernetes-version v1.21.0 --bootstrapper kubeadm'
export MINIKUBE_WANTREPORTERRORPROMPT=false
export MINIKUBE_HOME=/home/vagrant
export CHANGE_MINIKUBE_NONE_USER=true
export KUBECONFIG=/home/vagrant/.kube/config
export KUBERNETES_VERSION=1.21.0
export CHANGE_MINIKUBE_NONE_USER=vagrant
export SUDO_USER=vagrant
source <(kubectl completion bash)
echo 'This box definition is part of the following github repository. 
https://github.com/fr123k/vagrant-boxes'
cat << EOF
Run the following commands: 
 * to start minikube: minikube start ${MINIKUBE_ARGS}
 * setup minikube docker-env: docker-env
EOF
```

# Development

Prerequisites:
* [vagrant](https://www.vagrantup.com/)
* [virtualbox](https://www.virtualbox.org/)
* [make](https://www.gnu.org/software/make/)

## Build

To build the ubuntu minikube vagrant box local run the following command.
```
 make build
```
After this build you have a running version of this minikube vagrant box. The build time is roughly around 5 minutes.

## Package

> **:information_source:  INFO: The package make target takes a long time roughly 20 minutes to finish.**
>
> It's builds the vagrant box from scratch and performs couple of cleanup task to shrink the final base box size by running the compress make target.

To package the ubuntu minikube vagrant box run the following command.
```
 make package
```
This run the make build target to build a fresh vagrant machine and export the vagrant box from it.

## Publish

> **:information_source:  INFO: The publish make target needs an authenticated connection to the Vagrant Cloud to upload the vagrant box properly.**
>
> The default picked Vagrant Cloud registry is fr123k this can be configured check the Makefile. If you want to upload this or a customized version to your own Vagrant Cloud account.

```
 make publish
```
This will remove any previous build artifacts and run the make `package` target to build a fresh vagrant machine and export the vagrant box from it. After this it runs the make `compress` target to remove unnecessary files and software packages to reduce the vagrant box over all size. That reduces the size almost from 2 GB down to 1.5 GB.

The last step is to upload this packaged box then to the Vagrant Cloud registry (authentication has to be provided).

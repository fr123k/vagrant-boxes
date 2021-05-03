# minikube

This box provides a minikube installation. The size of the base box is roughly 2 GB. 

# Usage

```
  Vagrant.configure("2") do |config|
    config.vm.box = "fr123k/ubuntu21-minikube"
    config.vm.box_version = "1.0.0"
  end
```

Or

```
vagrant init fr123k/ubuntu21-minikube \
  --box-version 1.0.0
vagrant up
```

# Run Minikube

The minikube cluster has to be started 

```
  minikube start ${MINIKUBE_ARGS}
```

[ubuntu21-minikube](https://app.vagrantup.com/fr123k/boxes/ubuntu21-minikube)

# Packages

Installation with `apt-get`
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
  export MINIKUBE_WANTUPDATENOTIFICATION=false
  export MINIKUBE_WANTREPORTERRORPROMPT=false
  export MINIKUBE_HOME=/home/vagrant
  export CHANGE_MINIKUBE_NONE_USER=true
  export KUBECONFIG=/home/vagrant/.kube/config
  export KUBERNETES_VERSION=1.21.0
  export CHANGE_MINIKUBE_NONE_USER=vagrant
  export SUDO_USER=vagrant
  echo 'Run the following command to start minikube: minikube start \${MINIKUBE_ARGS}'
  source <(minikube docker-env)
  source <(kubectl completion bash)
# 

## Build

To build the ubuntu minikue vagrant box local.
```
 make build
```

## Package

To package the ubuntu minikue vagrant box local.
```
 make package
```

## Package

```
 make package
```
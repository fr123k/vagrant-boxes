# pulumi

This box provides a pulumi and golang installation. The size of the base box is roughly 1 GB. 

# Vagrant Box

[ubuntu21-pulumi](https://app.vagrantup.com/fr123k/boxes/ubuntu21-pulumi)

# Usage

Use one of the following examples to use this pulumi vagrant base box. After the vagrant virtual machine is started just use `vagrant ssh` to start a interactive user session.

```
  vagrant ssh
```

The current folder from where the vagrant machine was started is mounted at `/vagrant` folder.

## Vagrantfile

```
  Vagrant.configure("2") do |config|
    config.vm.box = "fr123k/ubuntu21-pulumi"
  end
```

If you want to start your session in the `/vagrant` folder then use the following.

```
  Vagrant.configure("2") do |config|
    config.vm.box = "fr123k/ubuntu21-pulumi"
    config.ssh.extra_args = ["-t", "cd /vagrant; bash --login"]
  end
```

You can change `cd /vagrant` to any folder you like to start you `vagrant ssh` session from.


## Vagrant Command line

```
  vagrant init fr123k/ubuntu21-pulumi --box-version 1.0.0
  vagrant up
```

# Packages

Installation with `apt-get`
* VirtualBox Guest Additions (latest)
* curl (latest)
* wget (latest)
* git (latest)
* docker (latest)
* wireguard (latest)
* wireguard-tools (latest)

Download binaries
* golang (1.16.7)
* pulumi latest

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

> **:information_source:&nbsp; INFO: The package make target takes a long time roughly 20 minutes to finish.**
>
> It's builds the vagrant box from scratch and performs couple of cleanup task to shrink the final base box size by running the compress make target.

To package the ubuntu minikube vagrant box run the following command.
```
 make package
```
This run the make build target to build a fresh vagrant machine and export the vagrant box from it.

## Publish

> **:information_source:&nbsp; INFO: The publish make target needs an authenticated connection to the Vagrant Cloud to upload the vagrant box properly.**
>
> The default picked Vagrant Cloud registry is fr123k this can be configured check the Makefile. If you want to upload this or a customized version to your own Vagrant Cloud account.

```
 make publish
```
This will remove any previous build artifacts and run the make `package` target to build a fresh vagrant machine and export the vagrant box from it. After this it runs the make `compress` target to remove unnecessary files and software packages to reduce the vagrant box over all size. That reduces the size almost from 2 GB down to 1.5 GB.

The last step is to upload this packaged box then to the Vagrant Cloud registry (authentication has to be provided).

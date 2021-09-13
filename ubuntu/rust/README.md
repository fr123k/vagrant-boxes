# rust

This box provides a full rust development installation. Including the following rust tools.

* rust package (rustc, cargo, ..)
* rustup package
* gcc package

# Vagrant Box

[ubuntu21-rust](https://app.vagrantup.com/fr123k/boxes/ubuntu21-rust)

# Usage

Use one of the following examples to use this rust vagrant base box. After the vagrant virtual machine is started just use `vagrant ssh` to start a interactive user session.

```
  vagrant ssh
```

The current folder from where the vagrant machine was started is mounted at `/vagrant` folder.

## Vagrantfile

```
  Vagrant.configure("2") do |config|
    config.vm.box = "fr123k/ubuntu21-rust"
    config.vm.box_version = "1.0.0"
  end
```

If you want to start your session in the `/vagrant` folder then use the following.

```
  Vagrant.configure("2") do |config|
    config.vm.box = "fr123k/ubuntu21-rust"
    config.vm.box_version = "1.0.0"
    config.ssh.extra_args = ["-t", "cd /vagrant/; rm -rf ./build; mkdir -p /tmp/vagrant/target; ln -s /tmp/vagrant/target/ ./build; bash --login"]
  end
```

You can change `cd /vagrant` to any folder you like to start you `vagrant ssh` session from.

### Error within in Sync Folder

The following error were raised running the compiled rust executable binaries
```
  bash: ./main: Invalid argument
```

In order to solve this quite easily just compile the binaries outside of the sync folder. That is achieved with the additional command below applied to the `config.ssh.extra_args ` vagrant configuration.

```
  mkdir -p /tmp/vagrant/target; ln -s /tmp/vagrant/target/`
```

## Vagrant Command line

```
  vagrant init fr123k/ubuntu21-rust --box-version 1.0.0
  vagrant up
```

# Packages

Installation with `apt-get`
* VirtualBox Guest Additions (latest)
* curl (latest)
* gcc (latest)
* git (latest)
* docker (latest)
* docker-compose (latest)
* rust (latest)

# Development

Prerequisites:
* [vagrant](https://www.vagrantup.com/)
* [virtualbox](https://www.virtualbox.org/)
* [make](https://www.gnu.org/software/make/)

## Build

To build the ubuntu rust vagrant box local run the following command.
```
 make build
```
After this build you have a running version of this rust vagrant box. The build time is roughly around 5 minutes.

## Package

> **:information_source:&nbsp; INFO: The package make target takes a long time roughly 10 minutes to finish.**
>
> It's builds the vagrant box from scratch and performs couple of cleanup task to shrink the final base box size by running the compress make target.

To package the ubuntu rust vagrant box run the following command.
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
This will remove any previous build artifacts and run the make `package` target to build a fresh vagrant machine and export the vagrant box from it. After this it runs the make `compress` target to remove unnecessary files and software packages to reduce the vagrant box over all size.

The last step is to upload this packaged box then to the Vagrant Cloud registry (authentication has to be provided).

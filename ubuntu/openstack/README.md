# openstack

This box provides a full Openstack single vm installation. The size of the base box is roughly 10 GB. 

# Vagrant Box

[ubuntu21-openstack](https://app.vagrantup.com/fr123k/boxes/ubuntu21-openstack)

# Usage

Use one of the following examples to use this Openstack vagrant base box. After the vagrant virtual machine is started just use `vagrant ssh` to start a interactive user session.

```
  vagrant ssh
```

The current folder from where the vagrant machine was started is mounted at `/vagrant` folder.

# Vagrant

## Disks for Openstack cinder

To keep the vagrant box slim the disk to store cinder volumes is not created in the base box has to be provided later. The disk feature in vagrant is experimental.

To enable it just set the following environment variable before running an vagrant commands.
```
export VAGRANT_EXPERIMENTAL="disks"
```

## Vagrantfile

```
  Vagrant.configure("2") do |config|
    config.vm.box = "fr123k/ubuntu21-openstack"
    config.vm.disk :disk, name: "cinder-volume", size: "10GB"
  end
```

If you want to start your session in the `/vagrant` folder then use the following.

```
  Vagrant.configure("2") do |config|
    config.vm.box = "fr123k/ubuntu21-openstack"
    config.ssh.extra_args = ["-t", "cd /vagrant; bash --login"]
  end
```

You can change `cd /vagrant` to any folder you like to start you `vagrant ssh` session from.


## Vagrant Command line

```
  vagrant init fr123k/ubuntu21-openstack
  vagrant up
```

# Packages

Installation of Openstack is done via [devstack](https://docs.openstack.org/devstack/latest/index.html#quick-start)

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

### Workarounds

#### Cinder

No lvm cinder volume defined use the following commands to create one.

Prerequisite:
* existing disk at /dev/sdc (for different location adjust the command accordingly)

```bash
# creates the physical disk
pvcreate /dev/sdc
# creates the logical disk group
vgcreate stack-volumes-lvmdriver-1 /dev/sdc
# restart the cinder service to pick up the new volume
systemctl restart devstack@c-vol.service
```

#### Neutron
```
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: DEBUG oslo.privsep.daemon [-] privsep: Exception during request[2763f187-062c-471b-914d-058300456a99]: No module name>
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: Traceback (most recent call last):
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]:   File "/usr/local/lib/python3.9/dist-packages/oslo_privsep/daemon.py", line 472, in _process_cmd
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]:     func = importutils.import_class(name)
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]:   File "/usr/local/lib/python3.9/dist-packages/oslo_utils/importutils.py", line 30, in import_class
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]:     __import__(mod_str)
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ModuleNotFoundError: No module named 'neutron.privileged.agent'
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: DEBUG oslo.privsep.daemon [-] privsep: reply[2763f187-062c-471b-914d-058300456a99]: (5, 'builtins.ModuleNotFoundError>
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: CRITICAL neutron [-] Unhandled error: ModuleNotFoundError: No module named 'neutron.privileged.agent'
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron Traceback (most recent call last):
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron   File "/usr/local/bin/neutron-ovn-metadata-agent", line 10, in <module>
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron     sys.exit(main())
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron   File "/opt/stack/neutron/neutron/cmd/eventlet/agents/ovn_metadata.py", line 24, in main
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron     metadata_agent.main()
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron   File "/opt/stack/neutron/neutron/agent/ovn/metadata_agent.py", line 39, in main
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron     agt.start()
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron   File "/opt/stack/neutron/neutron/agent/ovn/metadata/agent.py", line 251, in start
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron     self.sync()
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron   File "/opt/stack/neutron/neutron/agent/ovn/metadata/agent.py", line 57, in wrapped
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron     return f(*args, **kwargs)
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron   File "/opt/stack/neutron/neutron/agent/ovn/metadata/agent.py", line 309, in sync
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron     for ns in ip_lib.list_network_namespaces())
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron   File "/opt/stack/neutron/neutron/agent/linux/ip_lib.py", line 911, in list_network_namespaces
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron     return privileged.list_netns(**kwargs)
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron   File "/usr/local/lib/python3.9/dist-packages/oslo_privsep/priv_context.py", line 271, in _wrap
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron     return self.channel.remote_call(name, args, kwargs,
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron   File "/usr/local/lib/python3.9/dist-packages/oslo_privsep/daemon.py", line 216, in remote_call
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron     raise exc_type(*result[2])
Sep 10 12:40:39 ubuntu-hirsute neutron-ovn-metadata-agent[394499]: ERROR neutron ModuleNotFoundError: No module named 'neutron.privileged.agent'
```

# Solution

In the `/etc/neutron/neutron_ovn_metadata_agent.ini` configuration file add the following section.

```ini
[agent]
...
use_helper_for_ns_read = false

```

The following code just overwrites the `configure_root_helper_options` function within the devstack `lib/neutron` bash script.
```
function configure_root_helper_options {
    local conffile=$1
    echo "Frank Ittermann overwrote this"
    iniset $conffile agent use_helper_for_ns_read "false"
    iniset $conffile agent root_helper "sudo $NEUTRON_ROOTWRAP_CMD"
    iniset $conffile agent root_helper_daemon "sudo $NEUTRON_ROOTWRAP_DAEMON_CMD"
}
export -f configure_root_helper_options
```

If possible you can also just change the original `lib/neutron` file in the devstack github repository.

https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/8/html/configuration_reference_guide/block-storage-sample-configuration-files

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

# Further Reading

https://docs.openstack.org/devstack/latest/
https://docs.openstack.org/sahara/latest/contributor/devstack.html
https://www.youtube.com/watch?v=qgQARDfVrs8
https://github.com/cmusatyalab/elijah-openstack/issues/8
https://www.rdoproject.org/testday/workarounds/
https://computingforgeeks.com/adding-images-openstack-glance/

VAGRANT_EXPERIMENTAL="disks"

build:
	vagrant up

clean:
	vagrant destroy -f

shell: build
	vagrant ssh

all: clean build shell

clean:
	vagrant destroy -f

vagrant:
	vagrant up

full: vagrant deploy
	curl http://neo.192.168.33.10.nip.io/status
	curl http://neo.192.168.33.10.nip.io/liveness
	curl http://neo.192.168.33.10.nip.io/neo/week
	curl http://neo.192.168.33.10.nip.io/neo/next

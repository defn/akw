all: cidata/user-data cidata/user-data-fast
	@true

cidata/user-data: ../provision/cidata/user-data-lxd.template ../provision/.ssh/ssh-container Makefile
	@cat "$<" | env CONTAINER_SSH_KEY="$(shell cat ../provision/.ssh/ssh-container.pub)" envsubst '$$USER $$CONTAINER_SSH_KEY $$CACHE_VIP' | tee "$@.tmp"
	mv "$@.tmp" "$@"

cidata/user-data-fast: ../provision/cidata/user-data-lxd-clone.template ../provision/.ssh/ssh-container Makefile
	@cat "$<" | env CONTAINER_SSH_KEY="$(shell cat ../provision/.ssh/ssh-container.pub)" envsubst '$$USER $$CONTAINER_SSH_KEY $$CACHE_VIP' | tee "$@.tmp"
	mv "$@.tmp" "$@"

include ../base/Makefile.docker

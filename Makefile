all: cidata/user-data
	@true

cidata/user-data: cidata/user-data.template .ssh/ssh-container Makefile
	@cat "$<" | env CONTAINER_SSH_KEY="$(shell cat .ssh/ssh-container.pub)" envsubst '$$USER $$CONTAINER_SSH_KEY $$CACHE_VIP' | tee "$@.tmp"
	mv "$@.tmp" "$@"

.ssh/ssh-container:
	@mkdir -p $(shell dirname $@)
	@ssh-keygen -f $@ -P '' -C "lxd@$(shell uname -n)"

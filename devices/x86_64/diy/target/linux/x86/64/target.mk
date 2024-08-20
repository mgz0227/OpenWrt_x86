ARCH:=x86_64
BOARDNAME:=x86_64
DATE := $(shell date +%m.%d.%Y)
define Target/Description
        Build images for 64 bit systems including virtualized guests.
endef

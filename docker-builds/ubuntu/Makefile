.PHONY: all image start stop

TAG:=$(if $(TAG),$(TAG),$(shell basename `pwd`))
UPSTREAMTAG:=$(subst 32,,$(TAG))
IMG:=$(TAG)-dev
CTR:=$(TAG)-build

ifneq (,$(findstring 32,$(TAG)))
    ARCH:=i386/
else
    ARCH:=
endif

all:
	@echo "Try: make [Dockerfile|image|rmimage|start|stop|attach|rmcont]"

image: Dockerfile
	docker build --tag=$(IMG) .

rmimage:
	docker image rm $(IMG)

attach: start
	# Attach to the container
	docker exec -i -t $(CTR) /bin/bash

start: mk-cont start-cont

rmcont: stop
	docker container rm $(CTR)

stop:
	docker stop $(CTR)

# Startup helper rules
mk-cont:
	docker container ls -a -f name=$(CTR) | grep $(CTR) || make install-cont

install-cont:	
	docker container create -it --name $(CTR) $(IMG)


start-cont:
	docker container ls -f name=$(CTR) | grep $(CTR) || make startup-cont

startup-cont:
	docker start $(CTR)
	sleep 3

Dockerfile: .SHELLFLAGS = -c eval
Dockerfile: SHELL = bash -c 'eval "$${@//\\\\/}"'
Dockerfile:
	cat > $@ <<- EOF \
	FROM $(ARCH)ubuntu:$(UPSTREAMTAG)\
	\
	ENV TERM linux\
	ENV DEBIAN_FRONTEND noninteractive\
	\
	RUN apt-get update && apt-get install -y wget build-essential python\
	\
	CMD ["/bin/bash"]\
	EOF


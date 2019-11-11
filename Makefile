REPO_ADDR=
DATE=$(shell date -u +"%Y-%m-%d")
PUSH_CMD=

ifeq (, $(shell which podman))
  ifeq (, $(shell which docker))
    $(error 'docker' and 'podman' not found in PATH)
  else
    CONTAINER_RT:=docker
  endif
else
  CONTAINER_RT:=podman
endif

BUILD_CMD=podman build \
	-t ${REPO_ADDR}$@:latest \
	-t ${REPO_ADDR}$@:${DATE} \
        dist/$@

cts1-broadwell: ;       ${BUILD_CMD}; ${PUSH_CMD}

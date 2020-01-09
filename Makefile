# User-defined variables
REPO_ADDR=
PUSH_CMD=
HTTP_PROXY=
HTTPS_PROXY=
DATE=$(shell date -u +"%Y-%m-%d")

# Find Podman (preferred) or Docker
ifeq (, $(shell which podman))
  ifeq (, $(shell which docker))
    $(error 'docker' and 'podman' not found in PATH)
  else
    CONTAINER_RT:=docker
  endif
else
  CONTAINER_RT:=podman
endif

BUILD_CMD=${CONTAINER_RT} build \
	-t ${REPO_ADDR}$@:latest \
	-t ${REPO_ADDR}$@:${DATE} \
        --build-arg HTTP_PROXY=${HTTP_PROXY} \
        --build-arg HTTPS_PROXY=${HTTPS_PROXY} \
        dist/$@

ifneq ($(REPO_ADDR),)
PUSH_CMD:=${CONTAINER_RT} push ${REPO_ADDR}$@:latest; \
          ${CONTAINER_RT} push ${REPO_ADDR}$@:${DATE}
else
$(echo REPO_ADDR not set, will not push)
endif


###############################################################################
# Build rules
cts1-broadwell: ;           ${BUILD_CMD}; ${PUSH_CMD}
cts1-broadwell-gpu: ;       ${BUILD_CMD}; ${PUSH_CMD}

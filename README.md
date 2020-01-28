# optimized-base
A set of base images optimised for specific HPC architectures
- Based on RHEL UBI 8 
- Spack-installed libraries
- Optimized compiler flags for machine micro-architecture
- Includes a compatible MPI

#### Building an image
See `dists/` for available distributions. Use the makefile to build a
container. To build cts1-broadwell e.g.
```
make cts1-broadwell
```

#### Configuring the build Makefile
The makefile will try to select sensible defaults, however those can be
configured using environment variables on the commandline or modifying the
Makefile. See the top of the Makefile for available options. e.g.

```
make \
  REPO_ADDR=mydockerregistry.com \
  HTTP_PROXY=http://proxy:80/ \
  HTTPS_PROXY=http://proxy:80/ \
  CONTAINER_RT=docker \
  cts1-broadwell
```

#### TODO
- Narrowly define compiler toolchain. Currenlty uses UBI 8 default (gcc 8.3.1)
- Move back to a mainline spack commit once some fixes make it to upstream

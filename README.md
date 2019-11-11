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

#### Configuring the Makefile
- To tag images with a registry name set `REPO_ADDR` in the makefile
- Makefile targets Podman, then falls back to Docker. Explicitly set with `COMPILER_RT=<runtime>`

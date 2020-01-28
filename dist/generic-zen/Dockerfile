ARG SPACK_CHECKOUT=08d0267c9a6877b65208d732f0d5319b0fcc0bd7
ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG FORCE_UNSAFE_CONFIGURE=1

FROM registry.access.redhat.com/ubi8/ubi-minimal:8.1 as base
# Required packages
RUN microdnf install \
      gcc \
      gcc-c++ \
      gcc-gfortran \
      python36

# Installing spack
FROM base as add_spack
# Dependencies required for spack that will be discarded once finished
RUN microdnf install \
      bzip2 \
      git \
      gzip \
      make \
      patch \
      tar \
      xz
RUN git clone https://github.com/spack/spack.git /opt/spack
RUN (cd /opt/spack; git checkout $SPACK_CHECKOUT)
COPY spack.yaml /opt/spack/var/spack/environments/mpich-env/

# Configuring CLI to use Spack, then installing MPICH stack
COPY bashrc-addon /.bashrc-addon
RUN echo "source /.bashrc-addon" >> ~/.bashrc

# install the mpich-env Spack environment
RUN ( source /opt/spack/share/spack/setup-env.sh \
      && spack env activate mpich-env \
      && spack -k install \
      && spack gc -y \
      && spack clean -a )

# Prune installation directory
COPY shrink-spack.sh /
RUN /shrink-spack.sh

# Compact the installation history
FROM base as compress_spack
COPY --from=add_spack /opt/spack /opt/spack
COPY --from=add_spack /shrink-spack.sh /
COPY --from=add_spack /.bashrc-addon /.bashrc-addon

RUN echo "source /.bashrc-addon" >> ~/.bashrc

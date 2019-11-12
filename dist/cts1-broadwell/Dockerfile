ARG SPACK_CHECKOUT=76a042134d8d969cfe967e033d239cd1c38af5ed
ARG HTTP_PROXY
ARG HTTPS_PROXY

# Required packages
FROM registry.access.redhat.com/ubi8/ubi-minimal:8.1 as base
RUN microdnf install \
      bzip2 \
      gcc \
      gcc-c++ \
      gcc-gfortran \
      gzip \
      make \
      patch \
      python36 \
      tar \
      xz

# Installing spack
FROM base as add_spack
RUN microdnf install git
RUN git clone https://github.com/sknigh/spack.git -b missing-system-utilities /opt/spack
RUN (cd /opt/spack; git checkout $SPACK_CHECKOUT)
COPY spack.yaml /opt/spack/var/spack/environments/mpich-env/

# Configuring CLI to use Spack, then installing MPICH stack
FROM base as install_mpich
COPY --from=add_spack /opt/spack /opt/spack
COPY bashrc-addon /.bashrc-addon
RUN echo "source /.bashrc-addon" >> ~/.bashrc

# install the mpich-env Spack environment
RUN ( source /opt/spack/share/spack/setup-env.sh \
      && spack env activate mpich-env \
      && spack -k install \
      && spack clean -a )

# Prune installation directory
COPY shrink-spack.sh /
RUN /shrink-spack.sh

# Compact the installation history
FROM base AS compress_spack
COPY --from=install_mpich /opt/spack /opt/spack
COPY --from=install_mpich /shrink-spack.sh /
COPY --from=install_mpich /.bashrc-addon /.bashrc-addon

RUN echo "source /.bashrc-addon" >> ~/.bashrc

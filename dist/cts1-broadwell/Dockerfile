ARG SPACK_CHECKOUT=tags/v0.13.1

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
      procps \
      python36 \
      tar \
      xz

RUN microdnf install vim

# Installing spack
FROM base as add_spack
RUN microdnf install git
RUN git clone https://github.com/spack/spack.git /opt/spack
RUN (cd /opt/spack; git checkout $SPACK_CHECKOUT)
COPY spack.yaml /opt/spack/var/spack/environments/mpich-env/

# Configuring CLI to use Spack, then installing MPICH stack
FROM base as install_mpich
COPY --from=add_spack /opt/spack /opt/spack
COPY bashrc-addon /.bashrc-addon
RUN echo "source /.bashrc-addon" >> ~/.bashrc

RUN ( source /opt/spack/share/spack/setup-env.sh \
      && spack env activate mpich-env \
      && spack -k install \
      && spack clean -a )


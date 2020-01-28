FROM spack/centos7 as builder

ADD spack.yaml /opt/spack-environment/spack.yaml

RUN cd /opt/spack-environment && /opt/spack/bin/spack -k install

FROM registry.access.redhat.com/ubi7/ubi

COPY --from=builder /opt/spack-environment /opt/spack-environment
COPY --from=builder /opt/software /opt/software
COPY --from=builder /opt/view /opt/view

ENV PATH=/opt/view/bin:${PATH}

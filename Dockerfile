# Build the manager binary
FROM registry.redhat.io/openshift4/ose-helm-operator:v4.7


### Required OpenShift Labels
LABEL name="Intel\u00ae AIKit Operator" \
      maintainer="kam.d.kasravi@intel.com" \
      vendor="Intel Corporation" \
      version="v1.0" \
      release="1.0.0" \
      summary="AIKit Operator" \
      description="AIKit Operator."

COPY licenses /licenses

USER root
RUN yum -y update-minimal --security --sec-severity=Important --sec-severity=Critical
USER 1001

ENV HOME=/opt/helm
COPY watches.yaml ${HOME}/watches.yaml
COPY helm-charts  ${HOME}/helm-charts

WORKDIR ${HOME}

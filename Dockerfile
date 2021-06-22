# Build the manager binary
FROM registry.redhat.io/openshift4/ose-helm-operator:v4.7

### Required OpenShift Labels
LABEL name="Intel\u00ae AIKit Operator" \
      maintainer="kam.d.kasravi@intel.com" \
      vendor="Intel Corporation" \
      version="v2021.2.0" \
      release="2021.2.0" \
      summary="AIKit Operator" \
      description="AIKit Operator."

USER root
RUN yum -y update-minimal --security --sec-severity=Important --sec-severity=Critical
USER 1001

ENV HOME=/opt/helm

COPY licenses /licenses
COPY watches.yaml ${HOME}/watches.yaml
COPY helm-charts  ${HOME}/helm-charts

WORKDIR ${HOME}

# Build the manager binary
FROM registry.redhat.io/openshift4/ose-helm-operator:v4.7

### Required OpenShift Labels
LABEL name="Intel\u00ae OneAPI Analytics Toolkit Operator" \
      maintainer="kam.d.kasravi@intel.com" \
      vendor="Intel Corporation" \
      version="v1.0" \
      release="1.0.0" \
      summary="Intel OneAPI Analytics Toolkit Operator" \
      description="Intel OneAPI Analytics Toolkit Operator"


ENV HOME=/opt/helm

COPY licenses /licenses
COPY watches.yaml ${HOME}/watches.yaml
COPY helm-charts  ${HOME}/helm-charts

WORKDIR ${HOME}

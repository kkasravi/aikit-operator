# Build the manager binary
FROM quay.io/operator-framework/helm-operator:v1.8.0

### Required OpenShift Labels
LABEL name="Intel\u00ae AIKit Operator" \
      maintainer="kam.d.kasravi@intel.com" \
      vendor="Intel Corporation" \
      version="v1.0" \
      release="1.0.0" \
      summary="AIKit Operator" \
      description="AIKit Operator."


ENV HOME=/opt/helm
COPY watches.yaml ${HOME}/watches.yaml
COPY helm-charts  ${HOME}/helm-charts
WORKDIR ${HOME}

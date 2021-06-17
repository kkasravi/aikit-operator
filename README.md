# aikit-operator

## using the operator-sdk cli
operator-sdk run bundle -n kam quay.io/kamkasravi/aikit-operator-bundle:v1.0.6

### commands created
    CONTAINER_IMAGE=quay.io/kamkasravi/aikit-operator-bundle:v1.0.6 opm alpha bundle extract -m /bundle/ -n kam -c 1fc2e049859f738dad8ed6ecfd068a17f98baa20e16c2b86b146b435bf2adae

### cleanup
operator-sdk cleanup aikit-operator


## create index
opm -u docker index add --bundles quay.io/kamkasravi/aikit-operator-bundle:v1.0.6 --tag quay.io/kamkasravi/aikit-operator-index:v1.0.0
docker push quay.io/kamkasravi/aikit-operator-index:v1.0.0

## register with cluster
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: aikit-operator
  namespace: operator
spec:
  sourceType: grpc
  image: quay.io/kamkasravi/aikit-operator-index:v1.0.0
  displayName: AIKit Operator
  publisher: Intel
  updateStrategy:
    registryPoll:
      interval: 10m

## list operators available to install on the cluster
kubectl get packagemanifest -n <namespace>


## install operator
- create operatorgroup
```
---
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: intel-operators
  namespace: kam
---
```

- create subscription
```
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: aikit-operator-subscription
  namespace: kam
spec:
  channel: stable
  name: dikit-operator
  source: intel-operators
  sourceNamespace: kam
  approval: Manual
```


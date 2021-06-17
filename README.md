# aikit-operator

## using the operator-sdk cli

1. install <br/>
   `operator-sdk run bundle -n <namespace> quay.io/kamkasravi/aikit-operator-bundle:2021.2`
1. cleanup <br/>
   `operator-sdk cleanup aikit-operator`


## manual steps
1. create a catalog index <br/>
   opm -u docker index add --bundles quay.io/kamkasravi/aikit-operator-bundle:2021.2 --tag quay.io/kamkasravi/aikit-operator-index:2021.2 <br/>
   docker push quay.io/kamkasravi/aikit-operator-index:2021.2 <br/>
1. register the catalog index with cluster <br/>

```
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: aikit-operator
  namespace: <namespace>
spec:
  sourceType: grpc
  image: quay.io/kamkasravi/aikit-operator-index:2021.2
  displayName: AIKit Operator
  publisher: Intel
  updateStrategy:
    registryPoll:
      interval: 10m
```
1. validate the catalog index is registered in the cluster <br/>
   `kubectl get packagemanifest -n <namespace>
1. create an OperatorGroup for the operator <br/>
```
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: intel-operators
  namespace: kam
```
1. create a subscription
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

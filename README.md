# aikit-operator

## env vars
- OC_PROJECT=kam
- IMAGE_TAG_BASE=registry.connect.redhat.com/intel
- VERSION=2021.2.0

## using the operator-sdk cli

1. install <br/>
   `operator-sdk run bundle -n $OC_PROJECT ${IMAGE_TAG_BASE}-bundle:v$VERSION`

   ```
   I0619 08:42:37.067270   40732 request.go:655] Throttling request took 1.200891329s, request: GET:https://api.openvino5.3q12.p1.openshiftapps.com:6443/apis/route.openshift.io/v1?timeout=32s
   INFO[0021] Successfully created registry pod: quay-io-kamkasravi-aikit-operator-bundle-v2021-2-0-10
   INFO[0021] Created CatalogSource: aikit-operator-catalog
   INFO[0021] OperatorGroup "operator-sdk-og" created
   INFO[0021] Created Subscription: aikit-operator-v2021-2-0-10-sub
   INFO[0044] Approved InstallPlan install-bqqn8 for the Subscription: aikit-operator-v2021-2-0-10-sub
   INFO[0044] Waiting for ClusterServiceVersion "kam/aikit-operator.v2021.2.0-10" to reach 'Succeeded' phase
   INFO[0044]   Waiting for ClusterServiceVersion "kam/aikit-operator.v2021.2.0-10" to appear
   INFO[0078]   Found ClusterServiceVersion "kam/aikit-operator.v2021.2.0-10" phase: Pending
   INFO[0080]   Found ClusterServiceVersion "kam/aikit-operator.v2021.2.0-10" phase: InstallReady
   INFO[0085]   Found ClusterServiceVersion "kam/aikit-operator.v2021.2.0-10" phase: Installing
   INFO[0098]   Found ClusterServiceVersion "kam/aikit-operator.v2021.2.0-10" phase: Succeeded
   INFO[0098] OLM has successfully installed "aikit-operator.v2021.2.0-10"
   ```

1. cleanup <br/>
   `operator-sdk cleanup aikit-operator`


## manual steps
1. create a catalog index <br/>
   opm -u docker index add --bundles ${IMAGE_TAG_BASE}-bundle:v$VERSION --tag ${IMAGE_TAG_BASE}-index:v$VERSION <br/>
   docker push ${IMAGE_TAG_BASE}-index:v$VERSION <br/>
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

## Preparing before installing scss

Install core:
```
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
```

Check storage classes:
```
kubectl get storageclasses
```

for Minikube:
```
kubectl create configmap config-artifact-pvc \
                         --from-literal=size=10Gi \
                         --from-literal=storageClassName=standard \
                         -o yaml -n tekton-pipelines \
                         --dry-run=client | kubectl replace -f -
```


Install triggers:
```
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
```

Dashboard (optional):
```
kubectl apply --filename https://github.com/tektoncd/dashboard/releases/latest/download/tekton-dashboard-release.yaml
kubectl proxy --port=8080
```

# Install scss

```bash
./install.sh
```

Docker registry access:
```bash
kubectl -n sscs create secret docker-registry regcred \
                    --docker-server=<your-registry-server> \
                    --docker-username=<your-name> \
                    --docker-password=<your-pword> \
                    --docker-email=<your-email>
```

# Tektok chains

```bash
kubectl apply --filename https://storage.googleapis.com/tekton-releases/chains/latest/release.yaml
```

Prepare chains:
```bash
kubectl patch configmap chains-config -n tekton-chains -p='{"data":{"artifacts.taskrun.format": "in-toto"}}'
kubectl patch configmap chains-config -n tekton-chains -p='{"data":{"artifacts.taskrun.storage": "oci"}}'
kubectl patch configmap chains-config -n tekton-chains -p='{"data":{"transparency.enabled": "true"}}'
```
 
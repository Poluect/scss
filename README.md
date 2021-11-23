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
kubectl create namespace sscs
kubectl -n sscs apply -f ./infrastructure/rbac/admin-role.yaml \
            -f ./infrastructure/rbac/clusterrolebinding.yaml
kubectl -n sscs apply -f ./infrastructure/rbac/webhook-role.yaml
kubectl -n sscs apply -f ./ci/pipeline.yaml
kubectl -n sscs apply -f ./ci/triggers.yaml

# expose ingress for webhook
kubectl -n sscs apply -f ./infrastructure/create-ingress.yaml
kubectl -n sscs apply -f ./infrastructure/create-webhook.yaml
# replate external dns
kubectl -n sscs apply -f ./infrastructure/ingress-run.yaml
# replace github token
kubectl -n sscs apply -f ./infrastructure/secret.yaml
# replace github org, user, external domain
kubectl -n sscs apply -f ./infrastructure/webhook-run.yaml
```

Docker registry access:
```bash
kubectl create secret docker-registry regcred \
                    --docker-server=<your-registry-server> \
                    --docker-username=<your-name> \
                    --docker-password=<your-pword> \
                    --docker-email=<your-email>
```
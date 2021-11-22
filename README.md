## setting up

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

Dashboard:
```
kubectl apply --filename https://github.com/tektoncd/dashboard/releases/latest/download/tekton-dashboard-release.yaml
kubectl proxy --port=8080
```
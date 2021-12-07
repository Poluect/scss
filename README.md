## Github actions

When pushing a tag ti github, github actions automatically creates release for it, with signing of release assets using github workflow identity (see [this](https://shibumi.dev/posts/first-look-into-cosign/) and [this](https://shibumi.dev/posts/keyless-signatures-with-github-actions/) for more info)

So then binary files can be validated using cosign (with checksums.txt and checksubs.txt.sig upload from github release assets):

```bash
COSIGN_EXPERIMENTAL=1 cosign verify-blob -signature ~/Downloads/checksums.txt.sig ~/Downloads/checksums.txt
```

### Fork instructions:

1. Set following secrets in your repo:

- DOCKER_USERNAME
- DOCKER_PASSWORD
- COSIGN_KEY
- COSIGN_PASSWORD
- CODECOV_TOKEN

In order to generate cosign token:
```bash
# in case cosign not installed
go install github.com/sigstore/cosign/cmd/cosign@v1.4.0

cosign generate-key-pair
```
, then copy generated key and password to github secrets

2. In `.github/workflows/github-actions-demo.yml` replace `skifdh/test` with your own docker image path.

3. Codecov step is standalone, impact only build step, and can be easily commented

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

set -x

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
# kubectl -n sscs apply -f ./infrastructure/ingress-run.yaml
kubectl -n sscs apply -f ./infrastructure/ingress-nginx.yaml
# replace github token
kubectl -n sscs apply -f ./infrastructure/secret.yaml
# replace github org, user, external domain
kubectl -n sscs apply -f ./infrastructure/webhook-run.yaml

kubectl create namespace sscs-app
kubectl label namespaces sscs-app securesystemsengineering.connaisseur/webhook=validate


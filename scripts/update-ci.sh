set -x

kubectl -n sscs apply -f ./ci/pipeline.yaml
kubectl -n sscs apply -f ./ci/triggers.yaml

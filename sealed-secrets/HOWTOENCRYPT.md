# How To Encrypt Secrets

## Fetch certificate (optional)

Create kubeseal directory
```
mkdir ~/kubeseal
```

Fetch public certificate
```
kubeseal --controller-name=sealed-secrets \
--controller-namespace=sealed-secrets \
--fetch-cert >  ~/kubeseal/kubeseal.crt
```

You can now use the local offline certificate with `kubeseal --cert ~/kubeseal/kubeseal.crt` in the following steps.

## Create and encrypt generic secret
```
kubectl create secret generic secret-example \
--from-literal=password=$ECRET! \
--dry-run \
-oyaml > secret-example.yaml
```

```
kubeseal --cert https://raw.githubusercontent.com/baloise-incubator/getting-started/master/sealed-secrets/kubeseal.crt \
--namespace=<target-namespace> -oyaml \
< secret-example.yaml > namespaced-sealed-secret-example.yaml
```

## Create and encrypt pull secret
```
kubectl create secret docker-registry harbor-pull-secret \
--docker-server=harbor.apps.baloise.dev \
--docker-username=admin \
--docker-password=Harbor12345 \
--dry-run -oyaml > pull-secret-example.yaml
```
```
kubeseal --cert https://raw.githubusercontent.com/baloise-incubator/getting-started/master/sealed-secrets/kubeseal.crt \
--namespace=<target-namespace> -oyaml \
< pull-secret-example.yaml > sealed-pull-secret-example.yaml
```
### Add pull secret to ServiceAccount
```
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "harbor-pull-secret"}]}'
```

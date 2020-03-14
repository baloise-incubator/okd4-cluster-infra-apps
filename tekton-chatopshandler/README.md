# tekton-chatopshandler

In order for the chatops handler to work, you need to create a secret in the same namespace as your pipeline is running with a GitHub API token.

`kubectl create secret generic github --from-literal token=<MY_GITHUB_API_TOKEN>`

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
Replace "$ECRET!" with your github token.

## Create and encrypt generic secret
```
kubectl create secret generic github-token \
--from-literal=password=$ECRET! \
--dry-run \
-oyaml > secret-temporary.yaml
```

```
kubeseal --cert ~/kubeseal/kubeseal.crt \
--namespace=tekton-chatopshandler -oyaml \
< secret-temporary.yaml > github-token.secret.yaml
```

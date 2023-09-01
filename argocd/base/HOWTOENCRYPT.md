```bash
kubeseal --cert ~/kubeseal/kubeseal.crt -oyaml < argocd-secret.yaml.ignore > argocd-sealed-secret.yaml
```
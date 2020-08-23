```
kubeseal --cert ~/kubeseal/kubeseal.crt --namespace=monitoring-stack -oyaml < alertmanager-secret.yaml.ignore > alertmanager-sealed-secret.yaml
```
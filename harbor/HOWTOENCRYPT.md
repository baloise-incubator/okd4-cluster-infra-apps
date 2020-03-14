Chartmuseum
```bash
# Chartmuseum
kubeseal --cert ~/kubeseal/kubeseal.crt -oyaml --namespace=harbor < templates/chartmuseum-secret.yaml.ignore > templates/chartmuseum-sealed-secret.yaml
# Clair Config Map
kubeseal --cert ~/kubeseal/kubeseal.crt -oyaml --namespace=harbor < templates/clair-cm-secret.yaml.ignore > templates/clair-cm-sealed-secret.yaml
# Clair
kubeseal --cert ~/kubeseal/kubeseal.crt -oyaml --namespace=harbor < templates/clair-secret.yaml.ignore > templates/clair-sealed-secret.yaml
# Core Envvars
kubeseal --cert ~/kubeseal/kubeseal.crt -oyaml --namespace=harbor < templates/core-envvars-secret.yaml.ignore > templates/core-envvars-sealed-secret.yaml
# Core
kubeseal --cert ~/kubeseal/kubeseal.crt -oyaml --namespace=harbor < templates/core-secret.yaml.ignore > templates/core-sealed-secret.yaml
# Jobsservice Envvars
kubeseal --cert ~/kubeseal/kubeseal.crt -oyaml --namespace=harbor < templates/jobservice-envvars-secret.yaml.ignore > templates/jobservice-envvars-sealed-secret.yaml
# Jobsservice
kubeseal --cert ~/kubeseal/kubeseal.crt -oyaml --namespace=harbor < templates/jobservice-secret.yaml.ignore > templates/jobservice-sealed-secret.yaml
# PostgreSQL
kubeseal --cert ~/kubeseal/kubeseal.crt -oyaml --namespace=harbor < templates/postgresql-secret.yaml.ignore > templates/postgresql-sealed-secret.yaml
# Registry
kubeseal --cert ~/kubeseal/kubeseal.crt -oyaml --namespace=harbor < templates/registry-secret.yaml.ignore > templates/postgresql-sealed-secret.yaml

```

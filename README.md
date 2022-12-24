# OKD4 Cluster Infra Apps

[![App Status](https://argocd.baloise.dev/api/badge?name=okd4-cluster-infra-apps-apps)](https://argocd.baloise.dev/applications/okd4-cluster-infra-apps-apps)

This repository contains the configuration-as-code for [Argo CD](https://argoproj.github.io/argo-cd/) and all the apps
managed by it.

## Applications managed by Argo CD

Every application has its own subfolder where the configuration is located. See the README.md files for a short
explanation in every subfolder.

### Adding a new app

Create a directory and commit your plain YAML, Helm Charts or kustomization.yaml files in there. The application is then
automatically deployed.

To verify if the new directory is successfuly registered look at
the [config repository configuration](https://github.com/baloise-incubator/okd4-apps-root-config/blob/master/apps/okd4-cluster-infra-apps.yaml#L24)
.

### Secrets Management

Secrets like passwords or API tokens can be managed using the
Kubernetes [secrets](https://kubernetes.io/docs/concepts/configuration/secret/) resource type. However, it is not a good
idea to store those secrets in the repository since they are only base64 encoded. We are
using [Bitnami Sealed Secrets](sealed-secrets) to encrypt those secrets.

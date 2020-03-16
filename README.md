# OKD4 Cluster Infra Apps

[![App Status](https://argocd.apps.origin.baloise.dev/api/badge?name=okd4-cluster-infra-apps-apps)](https://argocd.apps.origin.baloise.dev/applications/okd4-cluster-infra-apps-apps)

This repository contains the configuration-as-code for [Argo CD](https://argoproj.github.io/argo-cd/) and all the apps managed by it.

## Applications managed by Argo CD
Every application has its own subfolder where the configuration is located. See the README.md files for a short explanation in every subfolder.

The following deployments are currently in the cluster, managed by ArgoCD:

| App Name              | Folder                                        | Sync Status                         |
| --------------------- | --------------------------------------------- | ------------------------------------| 
| Argo CD               |[argocd](argocd)                               |[![App Status](https://argocd.apps.origin.baloise.dev/api/badge?name=argocd)](https://argocd.apps.origin.baloise.dev/applications/argocd)|
| Sealed Secrets        |[Sealed Secrets](sealed-secrets)               |[![App Status](https://argocd.apps.origin.baloise.dev/api/badge?name=sealed-secrets)](https://argocd.apps.origin.baloise.dev/applications/sealed-secrets)|
| Harbor                |[Harbor](harbor)                               |[![App Status](https://argocd.apps.origin.baloise.dev/api/badge?name=harbor)](https://argocd.apps.origin.baloise.dev/applications/harbor)|
| Tekton Chatopshandler |[tekton-chatopshandler](tekton-chatopshandler) |[![App Status](https://argocd.apps.origin.baloise.dev/api/badge?name=tekton-chatopshandler)](https://argocd.apps.origin.baloise.dev/applications/tekton-chatopshandler)|
| Tekton Dashboard      |[tekton-dashboard](tekton-dashboard)           |[![App Status](https://argocd.apps.origin.baloise.dev/api/badge?name=tekton-dashboard)](https://argocd.apps.origin.baloise.dev/applications/tekton-dashboard)|
  
### Adding a new app
Every app needs to be referenced in the [applications property](https://github.com/baloise-incubator/okd4-apps-root-config/blob/master/apps/okd4-cluster-infra-apps.yaml#L24).

### Secrets Management
Secrets like passwords or API tokens can be managed using the Kubernetes [secrets](https://kubernetes.io/docs/concepts/configuration/secret/) resource type. However, it is not a good idea to store those secrets in the repository since they are only base64 encoded. We are using [Bitnami Sealed Secrets](sealed-secrets) to encrypt those secrets.



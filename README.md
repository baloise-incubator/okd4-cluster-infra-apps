# OKD4 Cluster Infra Apps

[![App Status](https://argocd.baloise.dev/api/badge?name=okd4-cluster-infra-apps-apps)](https://argocd.baloise.dev/applications/okd4-cluster-infra-apps-apps)

This repository contains the configuration-as-code for [Argo CD](https://argoproj.github.io/argo-cd/) and all the apps
managed by it.

## Applications managed by Argo CD

Every application has its own subfolder where the configuration is located. See the README.md files for a short
explanation in every subfolder.

The following deployments are currently in the cluster, managed by ArgoCD:

| App Name                   | Folder                                             | Sync Status                         |
| -------------------------- | -------------------------------------------------- | ------------------------------------|
| Argo CD                    |[argocd](argocd)                                    |[![App Status](https://argocd.baloise.dev/api/badge?name=argocd)](https://argocd.baloise.dev/applications/argocd)|
| Argo Workflow              |[argo-workflows](argo-workflows)                    |[![App Status](https://argocd.baloise.dev/api/badge?name=argo-workflows)](https://argocd.baloise.dev/applications/argo-workflows)|
| Cert Manager               |[cert-manager](cert-manager)                        |[![App Status](https://argocd.baloise.dev/api/badge?name=cert-manager)](https://argocd.baloise.dev/applications/cert-manager)|
| Crossplane                 |[crossplane](crossplane)                            |[![App Status](https://argocd.baloise.dev/api/badge?name=crossplane)](https://argocd.baloise.dev/applications/crossplane)|
| Harbor                     |[harbor](harbor)                                    |[![App Status](https://argocd.baloise.dev/api/badge?name=harbor)](https://argocd.baloise.dev/applications/harbor)|
| Keycloak Operator          |[keycloak-operator](keycloak-operator)              |[![App Status](https://argocd.baloise.dev/api/badge?name=keycloak-operator)](https://argocd.baloise.dev/applications/keycloak-operator)|
| Kubernetes OOM Event Generator        |[kubernetes-oom-event-generator](kubernetes-oom-event-generator)                    |[![App Status](https://argocd.baloise.dev/api/badge?name=kubernetes-oom-event-generator)](https://argocd.baloise.dev/applications/kubernetes-oom-event-generator)|
| Moon                       |[moon](.disabled/moon-test)                                        |[![App Status](https://argocd.baloise.dev/api/badge?name=moon-test)](https://argocd.baloise.dev/applications/moon-test)|
| Nexus                      |[nexus](nexus)                                      |[![App Status](https://argocd.baloise.dev/api/badge?name=nexus)](https://argocd.baloise.dev/applications/nexus)|
| Nexus Operator             |[nexus-operator](nexus-operator)                    |[![App Status](https://argocd.baloise.dev/api/badge?name=nexus-operator)](https://argocd.baloise.dev/applications/nexus-operator)|
| OpenShift ACME             |[openshift-acme](openshift-acme)                    |[![App Status](https://argocd.baloise.dev/api/badge?name=openshift-acme)](https://argocd.baloise.dev/applications/openshift-acme)|
| Rook Ceph                  |[rook-ceph](rook-ceph)                              |[![App Status](https://argocd.baloise.dev/api/badge?name=rook-ceph)](https://argocd.baloise.dev/applications/rook-ceph)|
| Sealed Secrets             |[sealed-secrets](sealed-secrets)                    |[![App Status](https://argocd.baloise.dev/api/badge?name=sealed-secrets)](https://argocd.baloise.dev/applications/sealed-secrets)|
| Sonarqube                  |[sonarqube](.disabled/sonarqube)                              |[![App Status](https://argocd.baloise.dev/api/badge?name=sonarqube)](https://argocd.baloise.dev/applications/sonarqube)|
| Tekton ChatOps Handler     |[tekton-chatopshandler](.disabled/tekton-chatopshandler)      |[![App Status](https://argocd.baloise.dev/api/badge?name=tekton-chatopshandler)](https://argocd.baloise.dev/applications/tekton-chatopshandler)|
| Tekton Dashboard           |[tekton-dashboard](.disabled/tekton-dashboard)                |[![App Status](https://argocd.baloise.dev/api/badge?name=tekton-dashboard)](https://argocd.baloise.dev/applications/tekton-dashboard)|
| Tekton Pipelines           |[tekton-pipelines](.disabled/tekton-pipelines)                |[![App Status](https://argocd.baloise.dev/api/badge?name=tekton-pipelines)](https://argocd.baloise.dev/applications/tekton-pipelines)|
| Camel K                    |[camel-k](camel-k)                                  |[![App Status](https://argocd.baloise.dev/api/badge?name=camel-k)](https://argocd.baloise.dev/applications/camel-k)|

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



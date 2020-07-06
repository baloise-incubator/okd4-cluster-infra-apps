# Argo CD

This folder contains the configuration-as-code for managing Argo CD itself.

It uses [Kustomize](https://kustomize.io/) for the config management.
See the [kustomization.yaml](kustomization.yaml) for the referenced configurations.

The Argo CD instance can be reached at [https://argocd.baloise.dev](https://argocd.baloise.dev).

## Role Based Access Control (RBAC) 
ArgoCD comes with a Bundled Dex OIDC Provider that has several connectors, we use the GitHub connector to manage RBAC.
See the [SSO Overview](https://argoproj.github.io/argo-cd/operator-manual/sso/) part in the Argo CD docs.

The dex GitHub connector options are descibed on [this dex GitHub page](https://github.com/dexidp/dex/blob/master/Documentation/connectors/github.md).
You can find our confiugration in [overlays/argocd-cm.yaml](overlays/argocd-cm.yaml) at `dex.config` part.

For Role Base Access Control (RBAC) see [the RBAC docs for Argo CD](https://argoproj.github.io/argo-cd/operator-manual/rbac/).
Our configuration is located in [overlays/argocd-rbac-cm.yaml](overlays/argocd-rbac-cm.yaml).
We are heavily relying on the default RBAC config, you can view it [here](https://github.com/argoproj/argo-cd/blob/master/assets/builtin-policy.csv).

The config does basically these things: 
- grant read access for anonymouse users
- allow synchronization of repositories under the `baloise-incubator` organisation for members of this org
- grant Argo CD admin access to a list of specific users

## Secrets
Secrets are managed by [sealed-secrets](https://github.com/bitnami-labs/sealed-secrets).
See the [docs for our sealed secret app](../.disabled/sealed-secrets) for details. 

The secret instances itself are managed by Argo CD, the configuration is located in the [base/argocd-sealed-secret.yaml](base/argocd-sealed-secret.json).
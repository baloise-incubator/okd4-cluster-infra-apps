# OKD4 Cluster Infra Apps

[![App Status](https://argocd.baloise.dev/api/badge?name=okd4-cluster-infra-apps-apps)](https://argocd.baloise.dev/applications/okd4-cluster-infra-apps-apps)

This repository contains the configuration-as-code for [Argo CD](https://argoproj.github.io/argo-cd/) and all the apps managed by it.

## Applications managed by Argo CD
Every application has its own subfolder where the configuration is located. See the README.md files for a short explanation in every subfolder.

The following deployments are currently in the cluster, managed by ArgoCD:

| App Name              | Folder                                        | Sync Status                         |
| --------------------- | --------------------------------------------- | ------------------------------------| 
| Argo Workflow         |[argo](.disabled/argo)                                        |[![App Status](https://argocd.baloise.dev/api/badge?name=argo)](https://argocd.baloise.dev/applications/argo)|
| Argo CD               |[argocd](argocd)                                    |[![App Status](https://argocd.baloise.dev/api/badge?name=argocd)](https://argocd.baloise.dev/applications/argocd)|
| Eclipse Che           |[che](.disabled/che)                                          |[![App Status](https://argocd.baloise.dev/api/badge?name=che)](https://argocd.baloise.dev/applications/che)|
| Harbor                |[harbor](.disabled/harbor)                                    |[![App Status](https://argocd.baloise.dev/api/badge?name=harbor)](https://argocd.baloise.dev/applications/argocd)|
| Hetzner Cloud CSI     |[hcloud-csi](.disabled/hcloud-csi)                            |[![App Status](https://argocd.baloise.dev/api/badge?name=hcloud-csi)](https://argocd.baloise.dev/applications/hcloud-csi)|
| IPTables Config       |[iptables-config](iptables-config)                  |[![App Status](https://argocd.baloise.dev/api/badge?name=iptables-config)](https://argocd.baloise.dev/applications/iptables-config)|
| Istio Operator        |[istio-operator](.disabled/istio-operator)                    |[![App Status](https://argocd.baloise.dev/api/badge?name=istio-operator)](https://argocd.baloise.dev/applications/istio-operator)|
| Jaeger Operator       |[jaeger-operator](.disabled/jaeger-operator)                  |[![App Status](https://argocd.baloise.dev/api/badge?name=jaeger-operator)](https://argocd.baloise.dev/applications/jaeger-operator)|
| Keycloak              |[keycloak](.disabled/keycloak)                                |[![App Status](https://argocd.baloise.dev/api/badge?name=keycloak)](https://argocd.baloise.dev/applications/keycloak)|
| Keycloak Operator     |[keycloak-operator](.disabled/keycloak-operator)              |[![App Status](https://argocd.baloise.dev/api/badge?name=keycloak-operator)](https://argocd.baloise.dev/applications/keycloak-operator)|
| Kiali Operator        |[kiali-operator](.disabled/kiali-operator)                    |[![App Status](https://argocd.baloise.dev/api/badge?name=kiali-operator)](https://argocd.baloise.dev/applications/kiali-operator)|
| Kubecost              |[kubecost](kubecost)                                |[![App Status](https://argocd.baloise.dev/api/badge?name=kubecost)](https://argocd.baloise.dev/applications/kubecost)|
| KubeVirt              |[kubevirt-hyperconverged](.disabled/kubevirt-hyperconverged)  |[![App Status](https://argocd.baloise.dev/api/badge?name=kubevirt-hyperconverged)](https://argocd.baloise.dev/applications/kubevirt-hyperconverged)|
| Minio                 |[minio](.disabled/minio)                                      |[![App Status](https://argocd.baloise.dev/api/badge?name=minio)](https://argocd.baloise.dev/applications/minio)|
| OpenShift ACME        |[openshift-acme](.disabled/openshift-acme)                    |[![App Status](https://argocd.baloise.dev/api/badge?name=openshift-acme)](https://argocd.baloise.dev/applications/openshift-acme)|
| Rook Ceph             |[rook-ceph](rook-ceph)                              |[![App Status](https://argocd.baloise.dev/api/badge?name=rook-ceph)](https://argocd.baloise.dev/applications/rook-ceph)|
| Sealed Secrets        |[Sealed Secrets](sealed-secrets)                    |[![App Status](https://argocd.baloise.dev/api/badge?name=sealed-secrets)](https://argocd.baloise.dev/applications/sealed-secrets)|
| Strimzi Kafka Operator|[strimzi-kafka-operator](.disabled/strimzi-kafka-operator)    |[![App Status](https://argocd.baloise.dev/api/badge?name=strimzi-kafka-operator)](https://argocd.baloise.dev/applications/strimzi-kafka-operator)|
| Tekton Chatopshandler |[tekton-chatopshandler](tekton-chatopshandler)      |[![App Status](https://argocd.baloise.dev/api/badge?name=tekton-chatopshandler)](https://argocd.baloise.dev/applications/tekton-chatopshandler)|
| Tekton Dashboard      |[tekton-dashboard](tekton-dashboard)                |[![App Status](https://argocd.baloise.dev/api/badge?name=tekton-dashboard)](https://argocd.baloise.dev/applications/tekton-dashboard)|
  
### Adding a new app
Create a directory and commit your plain YAML, Helm Charts or kustomization.yaml files in there. The application is then automatically deployed.

To verify if the new directory is successfuly registered look at the [config repository configuration](https://github.com/baloise-incubator/okd4-apps-root-config/blob/master/apps/okd4-cluster-infra-apps.yaml#L24).

### Secrets Management
Secrets like passwords or API tokens can be managed using the Kubernetes [secrets](https://kubernetes.io/docs/concepts/configuration/secret/) resource type. However, it is not a good idea to store those secrets in the repository since they are only base64 encoded. We are using [Bitnami Sealed Secrets](sealed-secrets) to encrypt those secrets.



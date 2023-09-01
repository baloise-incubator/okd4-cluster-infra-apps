# angular-base

![Version: 1.0.6](https://img.shields.io/badge/Version-1.0.6-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A base chart for all Angular Helm charts

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| usisschobe | <samuel.schober@usu.com> |  |
| uzijaltman | <jiri.altman@usu.com> |  |

## Source Code

* <https://gitlab.devops.usu.group/usu-shared/usu-helm-base-charts/angular-base-helm-chart>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | ^1.0.0 |
| https://helm.devops.usu.group/repository/helm-usu-shared/ | usu-common | ^1.0.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.enabled | bool | `false` | (Boolean) Enable autoscaling |
| autoscaling.maxReplicas | int | `100` | (Number) The maximum number of replicas |
| autoscaling.minReplicas | int | `1` | (Number) The minimum number of replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | (Number) The CPU utilization percentage which should be reached |
| autoscaling.targetMemoryUtilizationPercentage | Number | `nil` | The memory utilization percentage which should be reached |
| clusterDomain | string | `"cluster.local"` | (String) Kubernetes cluster domain name |
| commonAnnotations | object | `{}` | (String) Annotations to add to all deployed objects |
| commonLabels | object | `{}` | (String) labels to add to all deployed objects |
| componentName | string | `"server"` | (String) The component type within the architecture |
| deployment.affinity | object | `{}` | (Object) Affinity for pods assignment. NOTE: `deployment.podAffinityPreset`, `deployment.podAntiAffinityPreset`, and `deployment.nodeAffinityPreset` will be ignored when it's set ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity |
| deployment.containerPort | int | `8080` | (Number) The port the container is listening on. |
| deployment.containerSecurityContext.enabled | bool | `true` | (Boolean) Enable containers' Security Context |
| deployment.containerSecurityContext.runAsUser | int | `1001` | (String) Set containers' Security Context runAsUser |
| deployment.hostAliases | list | `[]` | (Object[]) pods host aliases; ref: https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/ |
| deployment.livenessProbe.enabled | bool | `true` | (Boolean) Enable livenessProbe on nodes |
| deployment.livenessProbe.failureThreshold | int | `10` | (Number) Failure threshold for livenessProbe |
| deployment.livenessProbe.initialDelaySeconds | int | `30` | (Number) Initial delay seconds for livenessProbe |
| deployment.livenessProbe.periodSeconds | int | `10` | (Number) Period seconds for livenessProbe |
| deployment.livenessProbe.successThreshold | Number | `nil` | Success threshold for livenessProbe |
| deployment.livenessProbe.timeoutSeconds | Number | `nil` | Timeout seconds for livenessProbe |
| deployment.nodeAffinityPreset.key | string | `""` | Node label key to match. Ignored if `deployment.affinity` is set |
| deployment.nodeAffinityPreset.type | string | `""` | (soft / hard) Node affinity preset type. Ignored if `deployment.affinity` is set. |
| deployment.nodeAffinityPreset.values | list | `[]` | (String[]) Node label values to match. Ignored if `deployment.affinity` is set |
| deployment.nodeSelector | object | `{}` | (Object) Node labels for pods assignment; ref: https://kubernetes.io/docs/user-guide/node-selection/ |
| deployment.podAffinityPreset | string | `""` | (soft / hard) Pod affinity preset. Ignored if `deployment.affinity` is set. ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity |
| deployment.podAnnotations | object | `{}` | (Object) Annotations for pods ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| deployment.podAntiAffinityPreset | string | `"soft"` | (soft / hard) Pod anti-affinity preset. Ignored if `deployment.affinity` is set. ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity |
| deployment.podLabels | object | `{}` | (Object) Extra labels for pods; ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| deployment.podSecurityContext.enabled | bool | `true` | (Boolean) Enable pods' Security Context |
| deployment.podSecurityContext.fsGroup | int | `1001` | (String) Set pod's Security Context fsGroup |
| deployment.priorityClassName | string | `""` | pods' priorityClassName |
| deployment.readinessProbe.enabled | bool | `true` | (Boolean) Enable readinessProbe on nodes |
| deployment.readinessProbe.failureThreshold | int | `10` | (Number) Failure threshold for readinessProbe |
| deployment.readinessProbe.initialDelaySeconds | int | `30` | (Number) Initial delay seconds for readinessProbe |
| deployment.readinessProbe.periodSeconds | int | `10` | (Number) Period seconds for readinessProbe |
| deployment.readinessProbe.successThreshold | Number | `nil` | Success threshold for readinessProbe |
| deployment.readinessProbe.timeoutSeconds | Number | `nil` | Timeout seconds for readinessProbe |
| deployment.replicaCount | int | `1` | (Number) Number of replicas to deploy |
| deployment.resources.limits | object | `{}` | (Object) The resources limits for the containers |
| deployment.resources.requests | object | `{"cpu":"100m","memory":"128Mi"}` | (Object) The requested resources for the containers |
| deployment.startupProbe.enabled | bool | `true` | (Boolean) Enable startupProbe on nodes |
| deployment.startupProbe.failureThreshold | int | `30` | (Number) Failure threshold for startupProbe |
| deployment.startupProbe.initialDelaySeconds | int | `30` | (Number) Initial delay seconds for startupProbe |
| deployment.startupProbe.periodSeconds | int | `10` | (Number) Period seconds for startupProbe |
| deployment.startupProbe.successThreshold | Number | `nil` | Success threshold for startupProbe |
| deployment.startupProbe.timeoutSeconds | Number | `nil` | Timeout seconds for startupProbe |
| deployment.tolerations | list | `[]` | (Object) Tolerations for pods assignment; ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| deployment.updateStrategy.type | string | `"Recreate"` | (RollingUpdate / OnDelete) Statefulset strategy type; ref: https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#update-strategies |
| env.apiUrl | String | `nil` | The API_URL environment variable |
| env.baseUrl | String | `nil` | The BASE_URL environment variable; defaults to {{ingress.path}}/ |
| env.keycloakUrl | String | `nil` | The KEYCLOAK_URL environment variable |
| extraEnv | object | `{}` | (Object) An map of extra provided environment variables |
| fullnameOverride | string | `""` | (String) Fully override common.names.fullname |
| global.env.keycloakUrl | String | `nil` | global value for env.keycloakUrl |
| global.imagePullSecrets | list | `[]` | (String[]) global value for image.pullSecrets |
| global.ingress.certManager | Boolean | `nil` | global value for ingress.certManager |
| global.ingress.className | String | `nil` | global value for ingress.className |
| global.ingress.hostname | String | `nil` | global value for ingress.hostname |
| global.ingress.selfSigned | Boolean | `nil` | global value for ingress.selfSigned |
| global.ingress.tls | Boolean | `nil` | global value for ingress.tls |
| image.pullPolicy | Always / Never / IfNotPresent | `nil` | image pull policy; ref: http://kubernetes.io/docs/user-guide/images/#pre-pulling-images |
| image.pullSecrets | list | `[]` | (String[]) Optionally specify an array of imagePullSecrets; ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| image.registry | string | `"docker.devops.usu.group"` | (String) image registry |
| image.repository | String | `nil` | image repository |
| image.tag | string | `"latest"` | image tag (immutable tags are recommended) |
| ingress.annotations | object | `{}` | (Object) Additional custom annotations for the ingress record. NOTE: If `ingress.certManager=true`, annotation `kubernetes.io/tls-acme: "true"` will automatically be added |
| ingress.apiVersion | String | `nil` | Force Ingress API version (automatically detected if not set) |
| ingress.certManager | bool | `false` | (Boolean) Add the corresponding annotations for cert-manager integration |
| ingress.className | string | `""` | (String) The class name of the ingress class |
| ingress.enabled | bool | `true` | (Boolean) Enable ingress record generation |
| ingress.hostname | string | `""` | (String) Default host for the ingress record |
| ingress.path | string | `""` | (String) Default path for the ingress record. NOTE: You may need to set this to '/*' in order to use this with ALB ingress controllers |
| ingress.pathType | string | `"ImplementationSpecific"` | (ImplementationSpecific / Exact / Prefix) Ingress path type |
| ingress.secrets | list | `[]` | (Object[]) Custom TLS certificates as secrets. NOTE: 'key' and 'certificate' are expected in PEM format. NOTE: 'name' should line up with a 'secretName' set further up. If it is not set and you're using cert-manager, this is unneeded, as it will create a secret for you with valid certificates. If it is not set and you're NOT using cert-manager either, self-signed certificates will be created valid for 365 days. It is also possible to create and manage the certificates outside of this helm chart. Please see README.md for more information e.g: secrets:   - name: %%COMPONENT_NAME%%.local-tls     key: |-       -----BEGIN RSA PRIVATE KEY-----       ...       -----END RSA PRIVATE KEY-----     certificate: |-       -----BEGIN CERTIFICATE-----       ...       -----END CERTIFICATE----- |
| ingress.selfSigned | bool | `false` | (Boolean) Create a TLS secret for this ingress record using self-signed certificates generated by Helm |
| ingress.tls | bool | `false` | (Boolean) Enable TLS configuration for the host defined at `ingress.hostname` parameter. TLS certificates will be retrieved from a TLS secret with name: `{{- printf "%s-tls" .Values.ingress.hostname }}` You can:   - Use the `ingress.secrets` parameter to create this TLS secret   - Relay on cert-manager to create it by setting `ingress.certManager=true`   - Relay on Helm to create self-signed certificates by setting `ingress.selfSigned=true` |
| initContainers | object | `{}` |  |
| nameOverride | string | `""` | (String) Partially override common.names.fullname |
| rbac.create | bool | `false` | (Boolean) Specifies whether RBAC resources should be created |
| service.annotations | object | `{}` | (Object) Additional custom annotations for service |
| service.clusterIP | String | `nil` | service Cluster IP |
| service.enabled | bool | `true` | (Boolean) Enable sevice creation |
| service.externalTrafficPolicy | string | `"Cluster"` | ( Cluster / Local) service external traffic policy ref http://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip |
| service.loadBalancerIP | String | `nil` | service Load Balancer IP ref: https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer |
| service.loadBalancerSourceRanges | list | `[]` | (String[]) service Load Balancer sources ref: https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/#restrict-access-for-loadbalancer-service |
| service.nodePorts.http | Number | `nil` | service HTTP port |
| service.nodePorts.https | Number | `nil` | service HTTPS port |
| service.port | int | `80` | (Number) service HTTP port |
| service.type | string | `"ClusterIP"` | (ClusterIP / NodePort / LoadBalancer / ExternalName ) service type |
| serviceAccount.create | bool | `true` | (Boolean) Specifies whether a ServiceAccount should be created |
| serviceAccount.name | string | `""` | (String) The name of the ServiceAccount to use. If not set and create is true, a name is generated using the common.names.fullname template |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.8.1](https://github.com/norwoodj/helm-docs/releases/v1.8.1)

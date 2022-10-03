# usu-portal

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2-4-1](https://img.shields.io/badge/AppVersion-2--4--1-informational?style=flat-square)

A Helm chart for USU Portal

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mariadb | ^11.0.0 |
| https://helm.devops.usu.group/repository/helm-usu-shared/ | user-management | ^6.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| _configuration.imagePullSecrets | string | `"usu-regcred"` |  |
| _configuration.portal.endpoints.dbJdbcUrl | string | `"jdbc:mariadb://mariadb:3306/portal"` |  |
| _configuration.portal.endpoints.portalHostname | string | `"portal.usu.local.gd"` |  |
| _configuration.user-management.endpoints.adminHostname | string | `"admin.portal.usu.local.gd"` |  |
| _configuration.user-management.endpoints.adminUrl | string | `"http://admin.portal.usu.local.gd/"` |  |
| _configuration.user-management.endpoints.apiUrl | string | `"http://portal.usu.local.gd/user-management-service/"` |  |
| _configuration.user-management.endpoints.keycloakUrl | string | `"http://portal.usu.local.gd/auth"` |  |
| _configuration.user-management.endpoints.profileHostname | string | `"profile.portal.usu.local.gd"` |  |
| _configuration.user-management.endpoints.profileUrl | string | `"http://profile.portal.usu.local.gd/"` |  |
| containerSecurityContext | object | `{"enabled":false}` | Container securityContext (see https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container) |
| global.imagePullSecrets[0].name | string | `"usu-regcred"` |  |
| global.ingress.className | string | `"nginx"` |  |
| global.ingress.enabled | bool | `true` |  |
| global.ingress.hostname | string | `"portal.usu.local.gd"` |  |
| mariadb | object | `{"architecture":"standalone","auth":{"database":"portal","password":"password","rootPassword":"password","username":"portal"},"fullnameOverride":"mariadb","volumePermissions":{"enabled":true}}` | Configuration for the mariadb Helm chart (see https://github.com/bitnami/charts/tree/master/bitnami/mariadb/) |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{"enabled":false}` | Pod securityContext (see https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod) |
| service.type | string | `"ClusterIP"` |  |
| user-management.keycloak.deployment.containerSecurityContext.enabled | bool | `false` |  |
| user-management.keycloak.deployment.livenessProbe.enabled | bool | `true` |  |
| user-management.keycloak.deployment.livenessProbe.initialDelaySeconds | int | `0` |  |
| user-management.keycloak.deployment.podSecurityContext.enabled | bool | `false` |  |
| user-management.keycloak.deployment.readinessProbe.enabled | bool | `false` |  |
| user-management.keycloak.deployment.readinessProbe.initialDelaySeconds | int | `0` |  |
| user-management.keycloak.deployment.startupProbe.enabled | bool | `true` |  |
| user-management.keycloak.deployment.startupProbe.failureThreshold | int | `120` |  |
| user-management.keycloak.deployment.startupProbe.initialDelaySeconds | int | `20` |  |
| user-management.keycloak.deployment.startupProbe.periodSeconds | int | `5` |  |
| user-management.keycloak.deployment.startupProbe.successThreshold | int | `1` |  |
| user-management.keycloak.enabled | bool | `true` |  |
| user-management.keycloak.env.admin.password | string | `"admin"` |  |
| user-management.keycloak.env.admin.user | string | `"admin"` |  |
| user-management.keycloak.env.db.createDatabase | bool | `true` | create the database in the DB |
| user-management.keycloak.env.db.database | string | `"keycloak"` | DB name |
| user-management.keycloak.env.db.host | string | `"mariadb"` | DB hostname or IP |
| user-management.keycloak.env.db.password | string | `"keycloak"` | DB password |
| user-management.keycloak.env.db.root.password | string | `"password"` |  |
| user-management.keycloak.env.db.user | string | `"keycloak"` | DB user |
| user-management.keycloak.env.db.vendor | string | `"mariadb"` | vendor of the DB |
| user-management.keycloak.env.loggingLevelRoot | string | `"INFO"` |  |
| user-management.keycloak.extraEnv[0] | object | `{"name":"KEYCLOAK_FRONTEND_URL","value":"http://portal.usu.local.gd/auth"}` | Explicitly specify Keycloak Frontend URL accessible by external client - needed for USM |
| user-management.keycloak.fullnameOverride | string | `"um-keycloak"` |  |
| user-management.keycloak.ingress.enabled | bool | `true` |  |
| user-management.keycloak.ingress.path | string | `"/"` |  |
| user-management.mariadb.enabled | bool | `false` |  |
| user-management.minio.enabled | bool | `false` |  |
| user-management.redis.enabled | bool | `false` |  |
| user-management.um-admin-ui.angular-base.deployment.containerSecurityContext.enabled | bool | `false` |  |
| user-management.um-admin-ui.angular-base.deployment.podSecurityContext.enabled | bool | `false` |  |
| user-management.um-admin-ui.angular-base.env.apiUrl | string | `"http://portal.usu.local.gd/user-management-service/"` |  |
| user-management.um-admin-ui.angular-base.env.baseUrl | string | `"/"` |  |
| user-management.um-admin-ui.angular-base.fullnameOverride | string | `"um-admin-ui"` |  |
| user-management.um-admin-ui.angular-base.ingress.enabled | bool | `true` |  |
| user-management.um-admin-ui.angular-base.ingress.hostname | string | `"admin.portal.usu.local.gd"` |  |
| user-management.um-admin-ui.angular-base.ingress.path | string | `"/"` |  |
| user-management.um-admin-ui.enabled | bool | `true` |  |
| user-management.um-profile-ui.angular-base.deployment.containerSecurityContext.enabled | bool | `false` |  |
| user-management.um-profile-ui.angular-base.deployment.podSecurityContext.enabled | bool | `false` |  |
| user-management.um-profile-ui.angular-base.env.apiUrl | string | `"http://portal.usu.local.gd/user-management-service/"` |  |
| user-management.um-profile-ui.angular-base.env.baseUrl | string | `"/"` |  |
| user-management.um-profile-ui.angular-base.fullnameOverride | string | `"um-profile-ui"` |  |
| user-management.um-profile-ui.angular-base.ingress.enabled | bool | `true` |  |
| user-management.um-profile-ui.angular-base.ingress.hostname | string | `"profile.portal.usu.local.gd"` |  |
| user-management.um-profile-ui.angular-base.ingress.path | string | `"/"` |  |
| user-management.um-profile-ui.enabled | bool | `true` |  |
| user-management.user-management-service.deployment.containerSecurityContext.enabled | bool | `false` |  |
| user-management.user-management-service.deployment.podSecurityContext.enabled | bool | `false` |  |
| user-management.user-management-service.enabled | bool | `true` |  |
| user-management.user-management-service.env.caching.type | string | `"simple"` |  |
| user-management.user-management-service.env.kcConnection.auth.password | string | `"admin"` |  |
| user-management.user-management-service.env.kcConnection.auth.user | string | `"admin"` |  |
| user-management.user-management-service.env.kcConnection.externalUrl | string | `"http://portal.usu.local.gd/auth"` |  |
| user-management.user-management-service.env.kcConnection.internalUrl | string | `"http://um-keycloak/auth"` |  |
| user-management.user-management-service.env.kcConnection.realm | string | `"usu"` |  |
| user-management.user-management-service.env.minio.enabled | bool | `false` |  |
| user-management.user-management-service.fullnameOverride | string | `"um-service"` |  |
| user-management.user-management-service.image.tag | string | `"3.0.0"` |  |
| user-management.user-management-service.ingress.enabled | bool | `true` |  |
| user-management.user-management-service.ingress.path | string | `"/user-management-service"` |  |
| usuportal.adapters.ua.enabled | bool | `true` |  |
| usuportal.adapters.ua.image | string | `"docker.devops.usu.group/usu-portal/portal/vma-portal-adapter"` |  |
| usuportal.adapters.ua.legacyAuth | bool | `true` |  |
| usuportal.adapters.ua.pentahoExternalUrl | string | `""` |  |
| usuportal.adapters.ua.pentahoInternalUrl | string | `""` |  |
| usuportal.adapters.ua.tag | string | `"2-4-1"` |  |
| usuportal.adapters.usm.enabled | bool | `true` |  |
| usuportal.adapters.usm.image | string | `"docker.devops.usu.group/usu-portal/portal/valuemation-portal-adapter"` |  |
| usuportal.adapters.usm.tag | string | `"2-4-1"` |  |
| usuportal.adapters.usm.webExternalUrl | string | `""` |  |
| usuportal.adapters.usm.webInternalUrl | string | `""` |  |
| usuportal.backend.dbJdbcUrl | string | `"jdbc:mariadb://mariadb:3306/portal"` | jdbc url to use for the backend container |
| usuportal.backend.extHostWhitelist | string | `"usu.com"` |  |
| usuportal.backend.image | string | `"docker.devops.usu.group/usu-portal/portal/backend"` |  |
| usuportal.backend.injectJdbc | object | `{}` | a list of jdbc driver images to inject into the backend container injectJdbc:   oracle: busybox:latest   mssql: busybox:latest |
| usuportal.backend.tag | string | `"2-4-1"` |  |
| usuportal.client.image | string | `"docker.devops.usu.group/usu-portal/portal/client"` |  |
| usuportal.client.tag | string | `"2-4-1"` |  |
| usuportal.fallbackLang | string | `"en"` |  |
| usuportal.helpPageUrl | string | `"https://www.google.com"` |  |
| usuportal.hostname | string | `"portal.usu.local.gd"` |  |
| usuportal.ingress.<<.className | string | `"nginx"` |  |
| usuportal.ingress.<<.enabled | bool | `true` |  |
| usuportal.ingress.<<.hostname | string | `"portal.usu.local.gd"` |  |
| usuportal.portalVersion | string | `"2-4-1"` |  |
| usuportal.schemas.image | string | `"docker.devops.usu.group/usu-portal/portal/json-schemas"` |  |
| usuportal.schemas.tag | string | `"2-4-1"` |  |
| usuportal.schemas.themeName | string | `"green"` |  |
| usuportal.um.adminUrl | string | `"http://admin.portal.usu.local.gd/"` |  |
| usuportal.um.keycloakUrl | string | `"http://portal.usu.local.gd/auth"` |  |
| usuportal.um.profileUrl | string | `"http://profile.portal.usu.local.gd/"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)

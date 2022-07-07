# user-management

![Version: 5.0.2](https://img.shields.io/badge/Version-5.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.1.0](https://img.shields.io/badge/AppVersion-2.1.0-informational?style=flat-square)

The full user-management deployment

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| usisschobe | <samuel.schober@usu.com> |  |
| usindietz | <nicholas.dietz@usu.com> |  |
| uzijaltman | <jiri.altman@usu.com> |  |

## Source Code

* <https://gitlab.devops.usu.group/usu-shared/usu-user-management/user-management-chart>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mariadb | ^10.0.0 |
| https://helm.devops.usu.group/repository/helm-usu-shared/ | keycloak | ^4.0.0-g62d8c36 |
| https://helm.devops.usu.group/repository/helm-usu-shared/ | um-admin-ui | ^2.1.0 |
| https://helm.devops.usu.group/repository/helm-usu-shared/ | um-profile-ui | ^2.1.0 |
| https://helm.devops.usu.group/repository/helm-usu-shared/ | user-management-service | ^2.0.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.imagePullSecrets[0] | string | `"usu-regcreds"` |  |
| global.ingress.hostname | string | `"um.local.gd"` |  |
| keycloak.enabled | bool | `true` | whether the Keycloak is enabled |
| keycloak.env.admin.password | string | `"admin"` |  |
| keycloak.env.admin.user | string | `"admin"` |  |
| keycloak.env.db.createDatabase | bool | `true` |  |
| keycloak.env.db.host | string | `"um-mariadb.um"` |  |
| keycloak.env.db.root.password | string | `"changeme"` |  |
| keycloak.env.db.vendor | string | `"mariadb"` |  |
| keycloak.env.deployment.livenessProbe.enabled | bool | `false` |  |
| keycloak.env.deployment.livenessProbe.initialDelaySeconds | int | `100` |  |
| keycloak.env.deployment.readinessProbe.enabled | bool | `false` |  |
| keycloak.env.deployment.resources | object | `{}` |  |
| keycloak.env.deployment.startupProbe.enabled | bool | `false` |  |
| keycloak.env.deployment.startupProbe.failureThreshold | int | `120` |  |
| keycloak.env.deployment.startupProbe.periodSeconds | int | `5` |  |
| keycloak.env.deployment.startupProbe.successThreshold | int | `1` |  |
| keycloak.fullnameOverride | string | `"um-keycloak"` |  |
| keycloak.image.pullPolicy | string | `"IfNotPresent"` |  |
| keycloak.image.tag | string | `"3.0.2"` |  |
| keycloak.ingress.enabled | bool | `true` |  |
| keycloak.ingress.path | string | `"/"` |  |
| mariadb.architecture | string | `"standalone"` |  |
| mariadb.auth.rootPassword | string | `"changeme"` |  |
| mariadb.enabled | bool | `true` | whether the mariadb is enabled |
| mariadb.fullnameOverride | string | `"um-mariadb"` |  |
| mariadb.primary.configuration | string | `"[mysqld]\nbasedir=/opt/bitnami/mariadb\nplugin_dir=/opt/bitnami/mariadb/plugin\nsocket=/opt/bitnami/mariadb/tmp/mysql.sock\ntmpdir=/opt/bitnami/mariadb/tmp\nmax_allowed_packet=16M\nbind-address=*\npid-file=/opt/bitnami/mariadb/tmp/mysqld.pid\nlog-error=/opt/bitnami/mariadb/logs/mysqld.log\ncharacter-set-server=UTF8\ncollation-server=utf8_general_ci\nslow_query_log_file=/opt/bitnami/mariadb/logs/mysqld.log\nexplicit_defaults_for_timestamp \nlong_query_time=10.0\nport=3306\nskip-name-resolve \nslow_query_log=0\n\ninnodb_stats_on_metadata=OFF\nquery_cache_size=0\ntable_open_cache=2200\n# join_buffer_size=512K\ninnodb_log_file_size=32M\ntable_definition_cache=1900\n# innodb_log_buffer_size=512K\ninnodb_flush_method=O_DIRECT_NO_FSYNC\n# performance_schema\n\n[client]\nsocket=/opt/bitnami/mariadb/tmp/mysql.sock\ndefault-character-set=UTF8\nplugin_dir=/opt/bitnami/mariadb/pluginport=3306\n\n[manager]\nsocket=/opt/bitnami/mariadb/tmp/mysql.sock\npid-file=/opt/bitnami/mariadb/tmp/mysqld.pid\nport=3306"` |  |
| mariadb.primary.resources | object | `{}` |  |
| mariadb.volumePermissions.enabled | bool | `true` |  |
| mariadb.volumePermissions.updateStrategy.type | string | `"OnDelete"` |  |
| um-admin-ui.angular-base.deployment.resources | object | `{}` |  |
| um-admin-ui.angular-base.env.apiUrl | string | `"/user-management-service/"` |  |
| um-admin-ui.angular-base.env.baseUrl | string | `"/um-admin-ui/"` |  |
| um-admin-ui.angular-base.env.keycloakUrl | string | `"/auth"` |  |
| um-admin-ui.angular-base.fullnameOverride | string | `"um-admin-ui"` |  |
| um-admin-ui.angular-base.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$2"` |  |
| um-admin-ui.angular-base.ingress.enabled | bool | `true` |  |
| um-admin-ui.angular-base.ingress.path | string | `"/um-admin-ui(/|$)(.*)"` |  |
| um-admin-ui.enabled | bool | `true` | whether the um admin ui is enabled |
| um-admin-ui.image.pullPolicy | string | `"Always"` |  |
| um-admin-ui.image.tag | string | `"latest"` |  |
| um-profile-ui.angular-base.deployment.resources | object | `{}` |  |
| um-profile-ui.angular-base.env.apiUrl | string | `"/user-management-service/"` |  |
| um-profile-ui.angular-base.env.baseUrl | string | `"/um-profile-ui/"` |  |
| um-profile-ui.angular-base.env.keycloakUrl | string | `"/auth"` |  |
| um-profile-ui.angular-base.fullnameOverride | string | `"um-profile-ui"` |  |
| um-profile-ui.angular-base.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$2"` |  |
| um-profile-ui.angular-base.ingress.enabled | bool | `true` |  |
| um-profile-ui.angular-base.ingress.path | string | `"/um-profile-ui(/|$)(.*)"` |  |
| um-profile-ui.enabled | bool | `true` |  |
| um-profile-ui.image.pullPolicy | string | `"Always"` |  |
| um-profile-ui.image.tag | string | `"latest"` |  |
| user-management-service.deployment.livenessProbe.initialDelaySeconds | int | `150` |  |
| user-management-service.deployment.readinessProbe.initialDelaySeconds | int | `150` |  |
| user-management-service.deployment.resources | object | `{}` |  |
| user-management-service.enabled | bool | `true` |  |
| user-management-service.env.dummyUsers.count | int | `0` |  |
| user-management-service.env.kcConnection.externalUrl | string | `"/auth"` |  |
| user-management-service.env.kcConnection.internalUrl | string | `"um-keycloak/auth"` |  |
| user-management-service.env.kcConnection.realm | string | `"usu"` |  |
| user-management-service.fullnameOverride | string | `"um-service"` |  |
| user-management-service.image.pullPolicy | string | `"Always"` |  |
| user-management-service.image.tag | string | `"3.0.0-unified-keycloak"` |  |
| user-management-service.ingress.enabled | bool | `true` |  |
| user-management-service.ingress.path | string | `"/user-management-service"` |  |
| user-management-service.initContainers[0].env[0].name | string | `"URL"` |  |
| user-management-service.initContainers[0].env[0].value | string | `"um-service/user-management-service/"` |  |
| user-management-service.initContainers[0].image | string | `"docker.devops.usu.group/usu-shared/usu-prototypes/wait-for-200:0.0.2"` |  |
| user-management-service.initContainers[0].name | string | `"wait-for-service"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.8.1](https://github.com/norwoodj/helm-docs/releases/v1.8.1)

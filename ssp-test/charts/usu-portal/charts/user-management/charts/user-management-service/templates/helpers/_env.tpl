{{/*
Return an array of environments for the server configuration
{{ include "userManagementService.env.serverEnvironment" . }}
*/}}
{{- define "userManagementService.env.generalEnvironment" -}}
- name: MODULES_KCADMINCLIENT_AUTHURL
  value: {{ .Values.env.kcConnection.internalUrl |quote}}
- name: MODULES_KCADMINCLIENT_WORKREALM
  value: {{ .Values.env.kcConnection.realm | quote }}
- name: MODULES_KCADMINCLIENT_USERNAME
  value: {{ .Values.env.kcConnection.auth.user | quote }}
- name: MODULES_KCADMINCLIENT_PASSWORD
  value: {{ .Values.env.kcConnection.auth.password | quote }}
- name: MODULES_IMPORTER_LOCAL_LEGACY_ENABLED
  value: "false"
- name: COM_USU_KEYCLOAK_ISSUERURLS
  value: "{{ .Values.env.kcConnection.internalUrl }}/realms/{{ .Values.env.kcConnection.realm}}, {{ .Values.env.kcConnection.externalUrl }}/realms/{{ .Values.env.kcConnection.realm}}"
- name: COM_USU_KEYCLOAK_REALM
  value: {{ .Values.env.kcConnection.realm | quote }}
- name: COM_USU_KEYCLOAK_AUTHSERVERURL
  value: {{ .Values.env.kcConnection.internalUrl | quote }}
- name: SERVER_SERVLET_CONTEXTPATH
  value: "{{ .Values.ingress.path }}"
- name: LOGGING_LEVEL_WEB
  value: {{ .Values.env.logging.webLogLevel | quote }}
- name: LOGGING_LEVEL_ORG_SPRINGFRAMEWORK_SECURITY
  value: {{ .Values.env.logging.securityLogLevel | quote }}
- name: LOGGING_LEVEL_COM_USU_USERMANAGEMENT
  value: {{ .Values.env.logging.userManagementLogLevel | quote }}
- name: LOGGING_LEVEL_COM_USU_KEYCLOAKSTARTER
  value: {{ .Values.env.logging.keycloakStarterLogLevel | quote }}
- name: COM_USU_KEYCLOAK_AUTHSERVERURLSWAGGER
  value: {{ .Values.env.kcConnection.externalUrl | quote }}
- name: MODULES_IMPORTER_DUMMYUSERS_COUNT
  value: {{ .Values.env.dummyUsers.count | quote }}
- name: MODULES_IMPORTER_DUMMYUSERS_REALMS
  value: {{ .Values.env.dummyUsers.realms | quote }}
- name: MODULES_IMPORTER_DUMMYUSERS_GROUPNAME
  value: {{ .Values.env.dummyUsers.groupName | quote }}
- name: MODULES_IMPORTER_DUMMYUSERS_FIRSTNAME
  value: {{ .Values.env.dummyUsers.firstname | quote }}
- name: MODULES_IMPORTER_DUMMYUSERS_LASTNAME
  value: {{ .Values.env.dummyUsers.lastname | quote }}
- name: MODULES_IMPORTER_DUMMYUSERS_PASSWORD
  value: {{ .Values.env.dummyUsers.password | quote }}
- name: SPRING_CACHE_TYPE
  value: {{ .Values.env.caching.type | quote }}
- name: SPRING_REDIS_HOST
  value: {{ .Values.env.caching.redis.host | quote }}
- name: SPRING_REDIS_PORT
  value: {{ .Values.env.caching.redis.port | quote }}
- name: SPRING_REDIS_PASSWORD
  value: {{ .Values.env.caching.redis.password | quote }}
- name: COM_USU_PERSISTENCE_FILE_MINIO_ENABLED
  value: {{ .Values.env.minio.enabled | quote }}
- name: COM_USU_PERSISTENCE_FILE_S3INSTANCEURL
  value: {{ .Values.env.minio.url | quote }}
- name: COM_USU_PERSISTENCE_FILE_S3ACCESSKEY
  value: {{ .Values.env.minio.accesskey | quote }}
- name: COM_USU_PERSISTENCE_FILE_S3SECRETKEY
  value: {{ .Values.env.minio.secretkey  | quote }}
- name: COM_USU_PERSISTENCE_FILE_BUCKETNAME
  value: {{ .Values.env.minio.bucketname  | quote }}
- name: COM_USU_PERSISTENCE_FILE_S3EXTERNALINSTANCEURL
  value: {{ .Values.env.minio.externalUrl | quote }}
{{- end -}}

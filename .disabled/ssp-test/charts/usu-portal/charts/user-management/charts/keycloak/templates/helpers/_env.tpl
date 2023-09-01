{{/*
Return an array of environments for the server configuration
{{ include "keycloak.env.generalEnvironment" . }}
*/}}
{{- define "keycloak.env.generalEnvironment" -}}
{{- $globalSecretName := printf "%s" (tpl (include "common.secrets.name" (dict "existingSecret" .Values.env.existingSecret "context" $)) $) -}}
- name: PROXY_ADDRESS_FORWARDING
  value: {{ .Values.env.proxyAddressForwarding | quote }}
- name: DB_VENDOR
  {{- if not .Values.env.db.host }}
  value: h2
  {{- else }}
  value: {{ .Values.env.db.vendor | quote }}
  {{- end }}
{{- if .Values.env.db.host }}
- name: DB_ADDR
  value: {{ .Values.env.db.host | quote }}
- name: DB_DATABASE
  value: {{ include "keycloak.db.name" . | quote }}
- name: DB_PORT
  value: {{ .Values.env.db.port | quote }}
- name: DB_USER
  value: {{ .Values.env.db.user | quote }}
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
    {{- if .Values.env.existingSecretPerPassword }}
      name: {{ tpl (include "common.secrets.name" (dict "existingSecret" .Values.env.existingSecretPerPassword.databasePassword "context" $)) $ }}
      key: {{ include "common.secrets.key" (dict "existingSecret" .Values.env.existingSecretPerPassword "key" "databasePassword") }}
    {{- else }}
      name: {{ include "keycloak.db.secretName" . }}
      key: {{ include "keycloak.db.secretKey" . }}
    {{- end }}
{{- end }}
- name: KEYCLOAK_USER
  value: {{ .Values.env.admin.user | quote }}
- name: KEYCLOAK_PASSWORD
  valueFrom:
    secretKeyRef:
      {{- if .Values.env.existingSecretPerPassword }}
        name: {{ tpl (include "common.secrets.name" (dict "existingSecret" .Values.env.existingSecretPerPassword.adminPassword "context" $)) $ }}
        key: {{ include "common.secrets.key" (dict "existingSecret" .Values.env.existingSecretPerPassword "key" "adminPassword") }}
      {{- else }}
        name: {{ $globalSecretName }}
        key: {{ include "common.secrets.key" (dict "existingSecret" .Values.env.existingSecret "key" "admin-password") }}
      {{- end }}
- name: LOGGING_LEVEL_ROOT
  value: {{ .Values.env.loggingLevelRoot | quote}}
- name: WEB_CONTEXT
  value: {{ (include "keycloak.webContext" .) | trimPrefix "/" }}
{{- end -}}

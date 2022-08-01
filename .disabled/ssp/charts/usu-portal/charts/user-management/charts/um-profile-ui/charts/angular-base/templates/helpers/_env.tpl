{{/*
Return an array of environments for the server configuration
{{ include "usuAngularCommon.env.generalEnvironment" . }}
*/}}
{{- define "usuAngularCommon.env.generalEnvironment" -}}
- name: BASE_URL
  value: {{ .Values.env.baseUrl | default ( printf "%s/" .Values.ingress.path ) | quote }}
- name: KEYCLOAK_URL
  value: {{ .Values.env.keycloakUrl | default .Values.global.env.keycloakUrl | quote }}
- name: API_URL
  value: {{ .Values.env.apiUrl | quote }}
{{- end -}}

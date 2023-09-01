{{/*
Return the secret containing AppName TLS certificates
*/}}
{{- define "keycloak.tlsSecretName" -}}
{{- $secretName := coalesce .Values.auth.tls.existingSecret .Values.auth.tls.jksSecret -}}
{{- if $secretName -}}
    {{- printf "%s" (tpl $secretName $) -}}
{{- else -}}
    {{- printf "%s-crt" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a TLS secret object should be created
*/}}
{{- define "keycloak.createTlsSecret" -}}
{{- if and .Values.auth.tls.enabled .Values.auth.tls.autoGenerated (not .Values.auth.tls.existingSecret) (not .Values.auth.tls.jksSecret) }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/* Validate values of Keycloak - Auth TLS enabled */}}
{{- define "keycloak.validateValues.auth.tls" -}}
{{- if and .Values.auth.tls.enabled (not .Values.auth.tls.autoGenerated) (not .Values.auth.tls.existingSecret) (not .Values.auth.tls.jksSecret) }}
keycloak: auth.tls.enabled
    In order to enable TLS, you also need to provide
    an existing secret containing the Keystore and Truststore or
    enable auto-generated certificates.
{{- end -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names (deprecated: use common.images.renderPullSecrets instead)
{{ include "common.images.pullSecrets" ( dict "images" (list .Values.path.to.the.image1, .Values.path.to.the.image2) "global" .Values.global) }}
*/}}
{{- define "keycloak.common.images.pullSecrets" -}}
  {{- $pullSecrets := list }}

  {{- if .global }}
    {{- range .global.imagePullSecrets -}}
      {{- if eq (typeOf .) "string" -}}
        {{- $pullSecrets = append $pullSecrets . -}}
      {{- else -}}
        {{- $pullSecrets = append $pullSecrets .name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- range .images -}}
    {{- range .pullSecrets -}}
      {{- if eq (typeOf .) "string" -}}
        {{- $pullSecrets = append $pullSecrets . -}}
      {{- else -}}
        {{- $pullSecrets = append $pullSecrets .name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if (not (empty $pullSecrets)) }}
imagePullSecrets:
    {{- range $pullSecrets }}
  - name: {{ . }}
    {{- end }}
  {{- end }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "keycloak.imagePullSecrets" -}}
{{- include "keycloak.common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) -}}
{{- end -}}


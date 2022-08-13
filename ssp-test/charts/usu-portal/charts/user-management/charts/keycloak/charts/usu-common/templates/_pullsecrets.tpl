{{/*
Return the proper Docker Image Registry Secret Names (deprecated: use common.images.renderPullSecrets instead)
{{ include "common.images.pullSecrets" ( dict "images" (list .Values.path.to.the.image1, .Values.path.to.the.image2) "global" .Values.global) }}
*/}}
{{- define "usuCommon.images.pullSecrets" -}}
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
{{- define "usuCommon.imagePullSecrets" -}}
{{- include "usuCommon.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) -}}
{{- end -}}

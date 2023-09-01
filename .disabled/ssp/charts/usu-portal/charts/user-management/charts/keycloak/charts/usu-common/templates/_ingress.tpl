{{/*
Returns true if the ingressClassname field is supported, otherwise false
Usage:
{{ include "usuCommon.ingress.supportsIngressClassname" . }}
*/}}
{{- define "usuCommon.ingress.supportsIngressClassName" -}}
{{- if semverCompare "<1.18-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "false" -}}
{{- else -}}
{{- print "true" -}}
{{- end -}}
{{- end -}}

{{/*
Prints the ingressClassName definition
Usage:
{{ include "usuCommon.ingress.className" . }}
*/}}
{{- define "usuCommon.ingress.className" -}}
{{- if and (or .Values.ingress.className .Values.global.ingress.className) (semverCompare ">=1.18-0" .Capabilities.KubeVersion.GitVersion) }}
ingressClassName: {{ .Values.ingress.className | default .Values.global.ingress.className }}
{{- end }}
{{- end -}}

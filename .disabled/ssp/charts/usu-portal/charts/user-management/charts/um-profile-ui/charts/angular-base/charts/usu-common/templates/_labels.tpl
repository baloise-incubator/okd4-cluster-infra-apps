{{/*
Kubernetes standard labels
Usage:
{{ include "usuCommon.labels.standard" . }}
*/}}
{{- define "usuCommon.labels.standard" -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
helm.sh/chart: {{ include "usuCommon.names.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
Usage:
{{ include "usuCommon.labels.matchLabels" . }}
*/}}
{{- define "usuCommon.labels.matchLabels" -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Returns the component name
Usage:
{{ include "usuCommon.labels.componentName" . }}
*/}}
{{- define "usuCommon.labels.componentName" -}}
app.kubernetes.io/component: {{ .Values.componentName }}
{{- end -}}

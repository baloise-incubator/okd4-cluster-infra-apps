{{/*
Create chart name and version as used by the chart label.
Usage:
{{ include "usuCommon.names.chart" . }}
*/}}
{{- define "usuCommon.names.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
Usage:
{{ include "usuCommon.names.serviceAccount" . }}
*/}}
{{- define "usuCommon.names.serviceAccount" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

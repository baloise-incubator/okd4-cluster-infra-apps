{{/*
Create chart name and version as used by the chart label.
Usage:
{{ include "usuCommon.names.chart" . }}
*/}}
{{- define "usuCommon.names.chart" -}}
{{- printf "%s-%s" (.Values.nameOverride | default .Chart.Name) .Values.image.tag | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
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

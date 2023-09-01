{{/*
Return the notes section for how to reach the pod
{{ include "usuCommon.notes.reachPod" . }}
*/}}
{{- define "usuCommon.notes.reachPod" -}}
{{- $fullName := include "common.names.fullname" . -}}
{{- if .Values.ingress.enabled }}
  http{{ if (or .Values.ingress.tls .Values.global.ingress.tls) }}s{{ end }}://{{ .Values.ingress.hostname }}{{ .Values.ingress.path }}
{{- else }}
Get the application URL for {{ $fullName }} by running these commands:
{{- if contains "NodePort" .Values.service.type }}
  export NODE_PORT=$(kubectl get --namespace {{ .Release.Namespace }} -o jsonpath="{.spec.ports[0].nodePort}" services {{ include "common.names.fullname" . }})
  export NODE_IP=$(kubectl get nodes --namespace {{ .Release.Namespace }} -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT
{{- else if contains "LoadBalancer" .Values.service.type }}
   NOTE: It may take a few minutes for the LoadBalancer IP to be available.
         You can watch the status of by running 'kubectl get --namespace {{ .Release.Namespace }} svc -w {{ include "common.names.fullname" . }}'

  export SERVICE_IP=$(kubectl get svc --namespace {{ .Release.Namespace }} {{ include "common.names.fullname" . }} --template "{{"{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}"}}")
  echo http://$SERVICE_IP:{{ .Values.service.port }}
{{- else if contains "ClusterIP" .Values.service.type }}
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace {{ .Release.Namespace }} port-forward service/{{$fullName}} 8080:{{ .Values.service.port }}
{{- end }}
{{- end }}
{{- end -}}

{{/*
Return the notes section for info
{{ include "usuCommon.notes.info" . }}
*/}}
{{- define "usuCommon.notes.info" -}}
** Please be patient while the chart is being deployed **
{{- end -}}

{{/*
Return the notes section for warnings
{{ include "usuCommon.notes.warning" . }}
*/}}
{{- define "usuCommon.notes.warning" -}}
{{- if eq (.Values.image.tag | toString) "latest" }}
WARNING: Latest tag detected ({{ .Values.image.repository }}:{{ .Values.image.tag }}),
please note that it is strongly recommended to avoid using latest tags in a production environment.
{{- end }}
{{- end }}

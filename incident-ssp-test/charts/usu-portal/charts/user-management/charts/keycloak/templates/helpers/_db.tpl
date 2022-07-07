{{/*
Create a default database name.
We truncate at 63 chars since the db identifier is limited to 64 characters. 
(https://mariadb.com/kb/en/identifier-names/#:~:text=Databases%2C%20tables%2C%20columns%2C%20indexes,maximum%20length%20of%2064%20characters.)

If release name contains chart name it will be used as a database name. Otherwise name will be composed with
{release name}-{chart name}.
*/}}
{{- define "keycloak.db.name" -}}
{{- if .Values.env.db -}}
    {{- if .Values.env.db.database -}}
        {{- .Values.env.db.database | trunc 63 | trimSuffix "_" -}}
    {{- else if and .Release.Name .Chart.Name -}}
        {{- $name := default .Chart.Name .Values.nameOverride -}}
        {{- if contains $name .Release.Name -}}
            {{- .Release.Name | trunc 63 | trimSuffix "_" -}}
        {{- else -}}
            {{- printf "%s_%s" .Release.Name $name | trunc 63 | trimSuffix "_" -}}
        {{- end -}}
    {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Return the Database encrypted password
*/}}
{{- define "keycloak.db.secretName" -}}
    {{- default (include "common.secrets.name" (dict "existingSecret" .Values.env.existingSecret "context" $)) (tpl .Values.env.db.existingSecret $) -}}
{{- end -}}

{{/*
Add environment variables to configure database values
*/}}
{{- define "keycloak.db.secretKey" -}}
{{- if .Values.env.db.existingSecret -}}
    {{- if .Values.env.db.existingSecretPasswordKey -}}
        {{- printf "%s" .Values.env.db.existingSecretPasswordKey -}}
    {{- else -}}
        {{- print "password" -}}
    {{- end -}}
{{- else -}}
    {{- print "password" -}}
{{- end -}}
{{- end -}}

{{/*
Return the database initialization SQL script
*/}}
{{- define "keycloak.db.init.sql" -}}
CREATE DATABASE IF NOT EXISTS {{ include "keycloak.db.name" . }};
CREATE USER IF NOT EXISTS '{{ .Values.env.db.user }}'@'%' IDENTIFIED BY '${KEYCLOAK_DB_PWD}';
GRANT ALL ON {{ include "keycloak.db.name" . }}.* TO '{{ .Values.env.db.user }}'@'%';
FLUSH PRIVILEGES;
{{- end -}}

{{/*
Return the database initialization script
*/}}
{{- define "keycloak.db.init.sh" -}}
if ! mysql --silent --host={{ .Values.env.db.host }} --port={{ .Values.env.db.port }} --user={{ .Values.env.db.user }} --password=${KEYCLOAK_DB_PWD} {{ include "keycloak.db.name" . }}; then
    mysql --silent --batch --host={{ .Values.env.db.host }} --port={{ .Values.env.db.port }} --user={{ .Values.env.db.root.user }} --execute={{ include "keycloak.db.init.sql" . | quote -}} || exit 1
fi
exit 0
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "swift-deployment-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "swift-deployment-service.namespace" -}}
  {{- default .Release.Namespace .Values.forceNamespace -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "swift-deployment-service.fullname" -}}
{{- if .Values.fullnameOverride }}
    {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else if .Values.nameOverride }}
    {{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
    {{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "swift-deployment-service.chart" -}}
{{- $fullname := include "swift-deployment-service.fullname" . -}}
{{- $version := include "swift-deployment-service.version" . -}}
{{- printf "%s-%s" $fullname $version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "swift-deployment-service.labels" -}}
helm.sh/chart: {{ include "swift-deployment-service.chart" . }}
{{ include "swift-deployment-service.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/release: {{ .Release.Name }}
app.kubernetes.io/version: {{ include "swift-deployment-service.version" . }}
{{- end }}

{{/*
Version
*/}}
{{- define "swift-deployment-service.version" -}}
{{- .Values.deployment.image.tag | default .Chart.AppVersion }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "swift-deployment-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "swift-deployment-service.fullname" . }}
app.kubernetes.io/organization: {{ .Values.organization }}
app.kubernetes.io/environment: {{ .Values.environmentName }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "swift-deployment-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "swift-deployment-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

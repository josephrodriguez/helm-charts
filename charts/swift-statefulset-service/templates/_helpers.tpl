{{/*
Expand the name of the chart.
*/}}
{{- define "swift-statefulset-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Version
*/}}
{{- define "swift-statefulset-service.version" -}}
{{- .Values.statefulset.image.tag | default .Chart.AppVersion }}
{{- end }}

{{- define "swift-statefulset-service.namespace" -}}
  {{- default .Release.Namespace .Values.forceNamespace -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "swift-statefulset-service.fullname" -}}
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
{{- define "swift-statefulset-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "swift-statefulset-service.labels" -}}
helm.sh/chart: {{ include "swift-statefulset-service.chart" . }}
{{ include "swift-statefulset-service.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/release: {{ .Release.Name }}
app.kubernetes.io/version: {{ include "swift-statefulset-service.version" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "swift-statefulset-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "swift-statefulset-service.fullname" . }}
app.kubernetes.io/organization: {{ .Values.organization }}
app.kubernetes.io/environment: {{ .Values.environmentName }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "swift-statefulset-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "swift-statefulset-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
{{/*
Expand the name of the chart.
*/}}
{{- define "argo-rollouts.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "argo-rollouts.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "argo-rollouts.fullname.preview" -}}
{{- $fullName := include "argo-rollouts.fullname" . }}
{{- printf "%s-preview" $fullName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "argo-rollouts.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "argo-rollouts.labels" -}}
helm.sh/chart: {{ include "argo-rollouts.chart" . }}
{{ include "argo-rollouts.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Preview label
*/}}
{{- define "argo-rollouts.labels.preview" -}}
{{ include "argo-rollouts.labels" . }}
{{ include "argo-rollouts.selectorLabels.preview" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "argo-rollouts.selectorLabels" -}}
app: {{ include "argo-rollouts.name" . }}
app.kubernetes.io/name: {{ include "argo-rollouts.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "argo-rollouts.selectorLabels.preview" -}}
{{ include "argo-rollouts.selectorLabels" . }}
preview: "true"
app.kubernetes.io/preview: "true"
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "argo-rollouts.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "argo-rollouts.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

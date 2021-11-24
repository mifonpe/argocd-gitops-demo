{{/*
Expand the name of the chart.
*/}}
{{- define "argo-rollout-demo.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "argo-rollout-demo.fullname" -}}
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

{{- define "argo-rollout-demo.fullname.preview" -}}
{{- $fullName := include "argo-rollout-demo.fullname" . }}
{{- printf "%s-preview" $fullName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "argo-rollout-demo.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "argo-rollout-demo.labels" -}}
helm.sh/chart: {{ include "argo-rollout-demo.chart" . }}
{{ include "argo-rollout-demo.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Preview label
*/}}
{{- define "argo-rollout-demo.labels.preview" -}}
helm.sh/chart: {{ include "argo-rollout-demo.chart" . }}
{{ include "argo-rollout-demo.selectorLabels.preview" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
preview: "true"
app.kubernetes.io/preview: "true"
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "argo-rollout-demo.selectorLabels" -}}
app: {{ include "argo-rollout-demo.name" . }}
app.kubernetes.io/name: {{ include "argo-rollout-demo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "argo-rollout-demo.selectorLabels.preview" -}}
{{ include "argo-rollout-demo.selectorLabels" . }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "argo-rollout-demo.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "argo-rollout-demo.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "accessible-pdf.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "accessible-pdf.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}

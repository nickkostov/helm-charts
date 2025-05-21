{{/* ########### Datadog Configuration ########### */}}
{{/* Service Name: */}}

{{- define "service-name" -}}
{{- printf "%s" (include "service.fullname" .) }}
{{- end -}}

{{/* Job Manager Labels: */}}

{{- define "dictonary-labels-jobmanager" -}}
{{- $labels := default (dict) .Values.datadog.labels.jobmanager }}
{{- if not (hasKey $labels "version")}}
{{- $_ := set $labels "version" (default "latest" .Values.image.tag) }}
{{- end }}
{{- if not (hasKey $labels "service") }}
{{- $_ := set $labels "service" (include "service-name" .) }}
{{- end }}
{{- mustToJson $labels  }}
{{- end }}


{{- define "generate-datadog-labels-jobmanager" -}}
{{- range $key, $value := . }}{{( print "tags.datadoghq.com/" $key ":" $value ", " ) }}{{- end }}
{{- end -}}

 
{{- define "datadog-library.jobmanager-labels" -}}
{{- include "generate-datadog-labels-jobmanager" (mustFromJson (include "dictonary-labels-jobmanager" .)) | trimSuffix ", "}}
{{- end }}

{{/* Task Manager Labels: */}}

{{- define "dictonary-labels-taskmanager" -}}
{{- $labels := default (dict) .Values.datadog.labels.taskmanager }}
{{- if not (hasKey $labels "version")}}
{{- $_ := set $labels "version" (default "latest" .Values.image.tag) }}
{{- end }}
{{- if not (hasKey $labels "service") }}
{{- $_ := set $labels "service" (include "service-name" .) }}
{{- end }}
{{- mustToJson $labels  }}
{{- end }}


{{- define "generate-datadog-labels-taskmanager" -}}
{{- range $key, $value := . }}{{( print "tags.datadoghq.com/" $key ":" $value ", " ) }}{{- end }}
{{- end -}}

 
{{- define "datadog-library.taskmanager-labels" -}}
{{- include "generate-datadog-labels-taskmanager" (mustFromJson (include "dictonary-labels-taskmanager" .)) | trimSuffix ", "}}
{{- end }}

{{/* Datadog Metrics Labels: */}}

{{- define "dictonary-metrics-labels" -}}
{{- $labels := default (dict) .Values.datadog.labels.taskmanager }}
{{- if not (hasKey $labels "version")}}
{{- $_ := set $labels "version" (default "latest" .Values.image.tag) }}
{{- end }}
{{- if not (hasKey $labels "service") }}
{{- $_ := set $labels "service" (include "service-name" .) }}
{{- end }}
{{- mustToJson $labels  }}
{{- end }}

{{- define "generate-datadog-metrics-labels" -}}
{{- range $key, $value := . }}{{( print "" $key ":" $value ", " ) }}{{- end }}
{{- end -}}

{{- define "datadog-library.metric-tags" -}}
{{- include "generate-datadog-metrics-labels" (mustFromJson (include "dictonary-metrics-labels" .)) | trimSuffix ", "}}
{{- end }}
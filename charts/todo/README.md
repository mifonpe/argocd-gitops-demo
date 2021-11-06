# todo

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

This charts deploy a sample ToDo application to help you exercise with Kubernetes

**Homepage:** <https://github.com/gitops-helm-summit>

## How to install this chart

Add this demo public chart repo:

```console
helm repo add migueles http://a6412244e5de940e7ba0eb62fa02eb36-1300587414.eu-west-1.elb.amazonaws.com:8080
```

A simple install with default values:

```console
helm install migueles/todo
```

To install the chart with the release name `my-release`:

```console
helm install my-release migueles/todo
```

To install with some set values:

```console
helm install my-release migueles/todo --set values_key1=value1 --set values_key2=value2
```

To install with custom values file:

```console
helm install my-release migueles/todo -f values.yaml
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `true` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `50` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"prydonius/todo"` |  |
| image.tag | string | `"1.0.0"` | Overrides the image tag whose default is the chart version. |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].host | string | `"todo.migueles.com"` |  |
| ingress.hosts[0].paths[0] | string | `"/"` |  |
| ingress.hosts[0].paths[1] | string | `"/todo"` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` | Number of replicas to run |
| resources.limits.cpu | string | `"1000m"` |  |
| resources.limits.memory | string | `"500Mi"` |  |
| resources.requests.cpu | string | `"1000m"` |  |
| resources.requests.memory | string | `"500Mi"` |  |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. -- If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` |  |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| mmingorance-dh |  |  |
| mifonpe |  |  |

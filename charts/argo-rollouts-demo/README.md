# argo-rollout-demo

![Version: 0.3.2](https://img.shields.io/badge/Version-0.3.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: blue](https://img.shields.io/badge/AppVersion-blue-informational?style=flat-square)

This chart deploys a sample Argo Rollout application

**Homepage:** <https://github.com/mifonpe/argocd-gitops-demo>

## How to install this chart

Add this demo public chart repo:

```console
helm repo add migueles http://a6412244e5de940e7ba0eb62fa02eb36-1300587414.eu-west-1.elb.amazonaws.com:8080
```

A simple install with default values:

```console
helm install migueles/argo-rollout-demo
```

To install the chart with the release name `my-release`:

```console
helm install my-release migueles/argo-rollout-demo
```

To install with some set values:

```console
helm install my-release migueles/argo-rollout-demo --set values_key1=value1 --set values_key2=value2
```

To install with custom values file:

```console
helm install my-release migueles/argo-rollout-demo -f values.yaml
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| argo-rollouts.enabled | bool | `true` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"argoproj/rollouts-demo"` |  |
| image.tag | string | `"blue"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations."ingress.kubernetes.io/app-root" | string | `"/"` |  |
| ingress.annotations."ingress.kubernetes.io/proxy-body-size" | string | `"100M"` |  |
| ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].host | string | `"canary.dev.argoproj.io"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| ingressCanary.annotations."ingress.kubernetes.io/app-root" | string | `"/"` |  |
| ingressCanary.annotations."ingress.kubernetes.io/proxy-body-size" | string | `"100M"` |  |
| ingressCanary.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| ingressCanary.className | string | `""` |  |
| ingressCanary.enabled | bool | `true` |  |
| ingressCanary.hosts[0].host | string | `"canary-preview.dev.argoproj.io"` |  |
| ingressCanary.hosts[0].paths[0].path | string | `"/"` |  |
| ingressCanary.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingressCanary.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| rollout.blueGreen | object | `{}` |  |
| rollout.canary.analysis.args[0].name | string | `"ingress"` |  |
| rollout.canary.analysis.args[0].value | string | `"argo-rollout"` |  |
| rollout.canary.maxSurge | string | `"50%"` |  |
| rollout.canary.steps[0].setWeight | int | `20` |  |
| rollout.canary.steps[1].pause | object | `{}` |  |
| rollout.canary.steps[2].setWeight | int | `40` |  |
| rollout.canary.steps[3].pause.duration | int | `10` |  |
| rollout.canary.steps[4].setWeight | int | `60` |  |
| rollout.canary.steps[5].pause.duration | int | `10` |  |
| rollout.canary.steps[6].setWeight | int | `80` |  |
| rollout.canary.steps[7].pause.duration | int | `10` |  |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| mmingorance-dh |  | https://github.com/mmingorance-dh |
| mifonpe |  | https://github.com/mifonpe |

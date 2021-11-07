Installing ArgoCD

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

```
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
# or locally:
kubectl port-forward svc/argocd-server -n argocd 8082:443
```

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
argocd login <ARGOCD_SERVER>  
argocd account update-password
```


## Contributing to Charts - This is just an Example!
Here is an example of how you could ensure quality in your Helm Charts prior being merged.

### Example Instructions
This repository has multiple Github Actions to ensure quality is high, these include:

- [chart-testing](https://github.com/helm/chart-testing): lint and install tests
- [markdown-lint](https://github.com/avto-dev/markdown-lint): lint all markdown files
- [helm-docs](https://github.com/norwoodj/helm-docs): check all chart `README.md` have all values documented
- [helm-conftest](https://github.com/instrumenta/helm-conftest): Ensures standard labels are present

All chart `README.md` files are generated from a template. This ensures all values are documented and that formatting is consistent. See [here](https://github.com/norwoodj/helm-docs#valuesyaml-metadata) about how the table of values is produced and how to add descriptions to your chart values.

### Running CI tests locally

All commands to be run from the root of this repo.

`chart-testing`:

  ```console
  brew install chart-testing
  pip3 install yamale yamllint
  ct lint --charts charts/<chart>
  ```

`markdown-lint`:

  ```console
  docker run --rm -v "$PWD:/charts" avtodev/markdown-lint:v1.5.0 --config /helm-charts/ci-charts/markdown-lint.yaml /charts/charts/**/*.md
  ```

`helm-docs`:

  To generate chart `README.md` files from the [template](ci-charts/README.md.gotmpl):

  ```console
  docker run --rm -v "$PWD:/helm-docs" jnorwood/helm-docs:v1.5.0 --template-files ./ci-charts/README.md.gotmpl
  ```

`helm-conftest`:

  ```console
  brew tap instrumenta/instrumenta
  brew install conftest
  helm template charts/<chart> | conftest -p ci-charts/helm-conftest-policies test - && echo "OK"
  ```

## License

Contents of this repository and any charts without a specific license are licensed under the Apache-2.0 License. 
Some charts may have their own respective license at `<chart>/LICENSE`. 
When adding a new chart to this repository and the chart is copied from another repository then include the license 
from the source if is not Apache-2.0 and include a link to the source under the `sources` section in `<chart>/Chart.yaml`.

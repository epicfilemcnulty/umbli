# Umbrella Linter

## Description

`umbli` is a docker container with a bunch of linters and security checkers installed:
* [ansible-lint](https://github.com/ansible/ansible-lint)
* [shellcheck](https://www.shellcheck.net/)
* [gitleaks](https://github.com/zricethezav/gitleaks)
* [tfsec](https://github.com/liamg/tfsec)
* [helm](https://helm.sh/)
* [kube-score](https://github.com/zegl/kube-score)

The container's [entrypoint](entrypoint.bash) bash script is configured to
look for the config file (specified by the **CONFIG"** env var, **.umbli.sh** by default),
and run the linting & security checks mentioned in the config against your project files.

## Usage

### Locally

```
docker run --rm -v $(pwd):/app -w /app epicfile/umbli:latest "${@}"
```

### As a CI step in Github Actions

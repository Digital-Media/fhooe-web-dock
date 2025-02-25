# How to Contribute

## Pull Requests

1. Fork the *fhooe-web-dock* repository.
2. Create a new branch for each feature, improvement, or bug fix.
3. Send a pull request from each feature branch against the main branch. Creating a separate branch for each issue allows for an easier review and merging process.

## Style Guide

All pull requests must adhere to the respective file standards:

- Dockerfiles: [Dockerfile reference](https://docs.docker.com/engine/reference/builder/).
- Docker Compose files: [Compose specification](https://github.com/compose-spec/compose-spec/blob/master/spec.md) and valid [YAML 1.1](https://yaml.org/spec/1.1/).
- Lint the Dockerfiles using [FROM:latest](https://www.fromlatest.io/) and [hadolint](https://hadolint.github.io/hadolint/).
- Lint `compose.yaml` with [DCLint](https://github.com/zavoloklom/docker-compose-linter/) (configuration is included).

## Report Issues

If you don't feel like submitting your fix for a problem or writing your feature code, please [submit an issue](https://github.com/Digital-Media/fhooe-web-dock/issues) describing your request in detail.

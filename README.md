# devcontainer-go

Go development container image for Agynio services.

## Image

`ghcr.io/agynio/devcontainer-go`

## Architectures

- `linux/amd64`
- `linux/arm64`

## Included tooling

| Tool | Version (default) | Notes |
| --- | --- | --- |
| Go | 1.22 (golang:1.22-bookworm) | Base image |
| buf | 1.64.0 | Multi-arch binary via `BUF_VERSION` |
| air | 1.61.7 | Go hot-reload via `AIR_VERSION` |
| oapi-codegen | 2.4.1 | OpenAPI code generation via `OAPI_CODEGEN_VERSION` |
| git, curl, bash, openssh-client, inotify-tools | Debian packages | Installed via apt |

## Usage

Run an interactive shell:

```sh
docker run --rm -it ghcr.io/agynio/devcontainer-go:1 bash
```

Use as a devcontainer image:

```json
{
  "image": "ghcr.io/agynio/devcontainer-go:1"
}
```

## Versioning

- `main` publishes tags: `main`, `sha-<short>`
- Semver tags `vX.Y.Z` publish: `X.Y.Z`, `X.Y`, `X`
- Pin to a major version tag (e.g. `:1`) for automatic minor/patch updates

## Updating tool versions

1. Edit the `ARG` values in `Dockerfile`.
2. Commit to `main` and confirm the image is published.
3. Create a semver tag (e.g. `v1.1.0`) to publish stable tags.

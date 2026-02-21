# Duoauthproxy in a Docker Container

[![Build and Push](https://github.com/metril/docker-duoauthproxy/actions/workflows/build.yml/badge.svg)](https://github.com/metril/docker-duoauthproxy/actions/workflows/build.yml)

Container Image: `ghcr.io/metril/docker-duoauthproxy`

## Usage

Pull the latest image:

```bash
docker pull ghcr.io/metril/docker-duoauthproxy:latest
```

Or use a specific version:

```bash
docker pull ghcr.io/metril/docker-duoauthproxy:6.6.0
```

## Configuration

See `example-config/authproxy.cfg` for an example configuration file.

A valid configuration must be copied to the config volume or bind mount location before the container will run successfully.

See `docker-compose.yml` for volume/bind mount locations.

## Docker Compose

```bash
docker-compose up -d
```

## Automated Builds

This image is automatically rebuilt:
- On every push to `master`
- Weekly (to pick up new Duo Authentication Proxy releases)
- Manually via workflow dispatch

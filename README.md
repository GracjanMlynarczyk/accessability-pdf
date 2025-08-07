# Accessible PDF

`accessible-pdf` is a containerized application that can be run locally using Docker Compose and deployed to a Kubernetes cluster using Helm Charts.

## Requirements

- Docker + Docker Compose
- Helm
- A Kubernetes cluster (e.g. minikube, k3s, AKS, EKS, GKE)
- (Optional) Docker image registry (e.g. Harbor, Docker Hub)

## Configuration Variables

- `APP_NAME` – application name (default: `accessible-pdf`)
- `IMAGE_TAG` – Docker image tag (default: `latest`)
- `REGISTRY_URL` – Docker registry URL (e.g. `registry.com/accessible-pdf`)
- `DOMAIN` - Domain for k8s application

You can override these variables when running `make`, e.g.:

```bash
make deploy IMAGE_TAG=1.0.0 REGISTRY_URL=harbor.example.com/accessible-pdf DOMAIN=accessability-pdf.com
```

## Makefile Commands

### Local development (Docker Compose)

| Command        | Description                                        |
|----------------|----------------------------------------------------|
| `make up`      | Start containers in detached mode (Docker Compose) |
| `make down`    | Stop and remove containers                         |
| `make restart` | Restart the containers                             |
| `make rebuild` | Rebuild containers without using cache             |
| `make logs`    | Follow container logs                              |
| `make sh`      | Open a shell inside the `app` container            |

### Docker build & publish

| Command              | Description                                                    |
|----------------------|----------------------------------------------------------------|
| `make docker-build`  | Build Docker image using `buildx` for `linux/amd64`            |
| `make docker-push`   | Push the built image to the configured Docker registry         |
| `make docker-publish`| Shortcut for running both `docker-build` and `docker-push`     |

### Kubernetes deployment (Helm)

| Command            | Description                                                   |
|--------------------|---------------------------------------------------------------|
| `make helm-deploy` | Deploy the app using the Helm chart from the `./helm` directory |
| `make helm-delete` | Remove the release from the cluster                           |
| `make deploy`      | Complete pipeline: build → push → deploy                      |

---

## Usage Example

```bash
# Start local dev environment
make up

# Build image and push to the registry
make docker-publish IMAGE_TAG=1.0.0 REGISTRY_URL=harbor.example.com/accessible-pdf

# Deploy to a Kubernetes cluster
make helm-deploy IMAGE_TAG=1.0.0 REGISTRY_URL=harbor.example.com/accessible-pdf DOMAIN=accessability-pdf.com

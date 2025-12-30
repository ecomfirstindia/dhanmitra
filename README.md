# dhanmitra

Minimal scaffold for deployments (Firebase Hosting + Cloud Run) and CI.

## Quickstart

1. Create a Google Cloud project and a Firebase project.
2. Set up Workload Identity (recommended) or create a service account key.
3. Add GitHub Secrets (or configure OIDC) as described in `.github/copilot-instructions.md`.

## Local deploy (Firebase Hosting)

- Install firebase-tools: `npm i -g firebase-tools`
- Login and init: `firebase login` and `firebase init` (hosting or functions as needed)
- Build and deploy: `npm ci && npm run build && firebase deploy --only hosting --project PROJECT_ID`

## Build & Deploy (Cloud Run)
- Build container: `docker build -t gcr.io/PROJECT_ID/REPO_NAME:TAG .`
- Push: `docker push gcr.io/PROJECT_ID/REPO_NAME:TAG`
- Deploy: `gcloud run deploy SERVICE --image gcr.io/PROJECT_ID/REPO_NAME:TAG --region REGION --platform managed`
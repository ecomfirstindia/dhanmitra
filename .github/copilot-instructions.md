# Copilot / AI Agent Instructions for ecomfirstindia/dhanmitra

**Status:** repository currently contains no source files (recent commits removed files). Use these instructions to discover project structure once code is added, or to guide maintainers on what to add next.

## Goal (what an AI agent should do)
- Help contributors get productive quickly by locating build/test scripts and CI workflows, inferring the language/runtime, and proposing small, well-scoped PRs (fixes, tests, or docs).
- When code is absent, produce a checklist and sample scaffolding to make the repo ready for development (README, LICENSE, basic CI, simple build/test targets).

## Quick discovery checklist (actions for an agent)
1. Inspect repository tree and recent commits (git log / git ls-tree). Note: this repo currently has no tracked files beyond `.git`.
2. Search for common build/test/CI files and patterns:
   - Files: `README.md`, `package.json`, `pyproject.toml`, `go.mod`, `pom.xml`, `Makefile`, `Dockerfile`, `.github/workflows/*`, `.env.example`, `tests/`, `src/`, `cmd/`, `internal/`, `pkg/`
   - Commands: `rg -n "package.json|pyproject.toml|go.mod|pom.xml|Makefile|Dockerfile|README.md"`
3. If language/runtime can be inferred, list exact build and test commands (see examples below).
4. Open CI workflow files at `.github/workflows/*` to find additional build/test commands and matrixes.

## Example command mappings (use these when you find matching files)
- Node.js (package.json): `npm ci && npm test` or `pnpm install && pnpm test` (look for `scripts` keys)
- Python (pyproject.toml / setup.py / requirements.txt): `python -m venv .venv && .venv/bin/pip install -r requirements.txt && pytest`
- Go (go.mod): `go test ./...` and `gofmt -s -w .` or `go vet ./...`
- Java/Maven (pom.xml): `mvn -B -DskipTests=false test`
- Docker-based projects: inspect `Dockerfile` and `.dockerignore`, run `docker build` locally for reproducibility

## Project-specific conventions to document (if/when present)
- Where source code lives (e.g., `src/`, `cmd/`, `packages/`) and module layout
- Test placement and naming patterns (e.g., `*_test.go`, `tests/`, `spec/`)
- Linting and formatting tools (e.g., `eslint`, `prettier`, `black`, `gofmt`) and how to run them
- Environment and secrets patterns (presence of `.env.example`, vault usage, or CI secret names)
- CI gate requirements (required checks, code owners, branch protection rules)

## Integration points to check
- External APIs and services referenced in code or sample env files (add names and minimal auth instructions)
- Packages or submodules hosted externally (git submodules, private package registries)
- Any infra-as-code (Terraform, CloudFormation) or container orchestration manifests

## Examples to include in PRs (when repo is empty)
- Add a minimal `README.md` explaining purpose, language, and minimal build/test commands
- Create a simple `Makefile` or `scripts/` folder with `build`, `test`, `fmt`, `lint` targets
- Add a CI workflow `.github/workflows/ci.yml` that runs build + tests on push/PR
- Add `.editorconfig` and basic lint configs to encode formatting rules

## Firebase & Google Cloud deployment (scaffold added)
- This repo includes example workflows and configs to deploy to **Firebase Hosting** and **Cloud Run** (see `.github/workflows/firebase-deploy.yml` and `.github/workflows/cloudrun-deploy.yml`).
- Workflows use **OIDC / Workload Identity** (recommended) via `google-github-actions/auth@v1`. To enable OIDC:
  1. In GCP, create a Workload Identity Pool and Provider and note the provider resource name.
  2. Create a GCP service account `github-actions@PROJECT_ID.iam.gserviceaccount.com` and grant least-privilege roles (e.g., `roles/firebasehosting.admin`, `roles/run.admin`, `roles/storage.admin` depending on targets).
  3. Create a service account binding to the provider so GitHub can impersonate the SA.
  4. In GitHub, add the following repository secrets:
     - `WORKLOAD_IDENTITY_PROVIDER`: the provider resource name (projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/POOL/providers/PROVIDER)
     - `GCP_SA_EMAIL`: the service account email
     - `GCP_PROJECT`: the GCP project id
     - `CLOUD_RUN_SERVICE` and `CLOUD_RUN_REGION` (optional)
- For environments where OIDC isn't available, you can create a short-lived service account key and store it securely in `GCP_SA_KEY` as a GitHub secret (less secure; rotate often).

## Files added by the scaffold
- `README.md` – Quickstart + local deploy notes
- `Makefile` – helper targets (`deploy-firebase`, `deploy-cloudrun`)
- `firebase.json`, `.firebaserc` – minimal Firebase hosting config
- `.github/workflows/firebase-deploy.yml` – build, preview (PR), and prod deploy to Firebase Hosting
- `.github/workflows/cloudrun-deploy.yml` – container build and deploy to Cloud Run (PRs deploy as a preview revision)

---


## When unsure — ask these clarifying questions
- What language or runtime is intended for this project?
- Are there existing internal tooling or registries (private npm, PyPI, container registry) we should use?
- What CI checks or release process should be considered required for PRs?

## Safety & PR rules for agents
- Only make small, focused PRs; include tests or documented manual test steps
- Don't add or commit secrets or real credentials; use placeholders and `.env.example`
- Run linters and unit tests locally in the same environment as CI before opening a PR

---

If you want, I can:
- Add a minimal `README.md`, `Makefile`, and a starter `.github/workflows/ci.yml` to make this repo buildable; or
- Wait for you to push the existing source and then update these instructions with concrete commands discovered in the codebase.

Please tell me which option you prefer or share the missing source code so I can refine the instructions with concrete examples. ✅

# Simple build/test/deploy helpers

.PHONY: build test fmt deploy-firebase deploy-cloudrun

build:
	# replace with your build command
	@echo "No build command defined. Edit the Makefile."

test:
	@echo "No tests defined. Edit the Makefile."

fmt:
	@echo "No formatter defined. Edit the Makefile."

# Local Firebase hosting deploy
deploy-firebase:
	firebase deploy --only hosting --project ${PROJECT_ID}

# Local Cloud Run deploy (docker must be configured)
deploy-cloudrun:
	@echo "Build and push container, then run gcloud run deploy"
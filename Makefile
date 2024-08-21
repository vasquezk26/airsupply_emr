.DEFAULT: help
help:
	@echo "make sync:"
	@echo "    syncs t8emr/bootstrap-files/emr-handler to s3://cof-tc-dev-dataservices/emr-handler using local aws credentials."

dev:
	@. ./utils/cloudsentry-auto.sh; refresh_credentials
	@python3 t8emr/EmrProcessor.py --env "dev-us-east-1"

qa:
	@. ./utils/cloudsentry-auto.sh; refresh_credentials
	@python3 t8emr/EmrProcessor.py --env "qa-us-east-1"
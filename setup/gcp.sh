#!/bin/bash

curl https://sdk.cloud.google.com | bash

gcloud init
gcloud config list
gcloud components install app-engine-go

# setup
# see https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu

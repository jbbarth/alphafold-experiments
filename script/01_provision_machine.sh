#!/bin/bash
set -euo pipefail

if ! which gcloud >/dev/null; then
  echo "Please install Gcloud CLI: https://cloud.google.com/sdk/docs/install" >&2
  exit 1
fi

MACHINE_TYPE=a2-ultragpu-1g # recommended
MACHINE_TYPE=a2-highgpu-1g # cheaper, supported
MACHINE_TYPE=g2-standard-12 # trying

gcloud compute instances create alphafold3 \
    --machine-type $MACHINE_TYPE \
    --zone us-central1-b \
    --image-family ubuntu-2204-lts \
    --image-project ubuntu-os-cloud \
    --maintenance-policy TERMINATE \
    --boot-disk-size 1000 \
    --boot-disk-type pd-balanced

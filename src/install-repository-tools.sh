#!/bin/bash

# Exit immediately if a command exits with a non-zero status
# This ensures the Docker build fails if any command fails
set -e

# Fail if any command in a pipeline fails
# This is useful for catching errors in piped commands
set -o pipefail

echo "## Updating package lists and installing repository management tools ##"

# Update package lists
apt-get update

# Install software-properties-common
apt-get install -y software-properties-common

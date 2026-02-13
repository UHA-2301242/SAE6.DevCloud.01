#!/bin/bash
set -eufx

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v tofu >/dev/null 2>&1
then
    echo "OpenTofu (tofu) could not be found on your system. Please install it."
    exit 1
fi

chmod -R 600 "$SCRIPT_DIR/keys"

cd "$SCRIPT_DIR/terraform"
tofu init -upgrade
tofu destroy -auto-approve

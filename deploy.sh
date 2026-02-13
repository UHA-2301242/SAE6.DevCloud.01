#!/bin/bash
set -eufx

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! [ -f "$SCRIPT_DIR/keys/ansible.key" ]; then
  echo "Missing SSH key at 'keys/ansible.key'"
fi

if ! [ -f "$SCRIPT_DIR/keys/ansible.key" ]; then
  echo "Missing SSH key at 'keys/ansible.key.pub'"
fi

if ! command -v ansible-playbook >/dev/null 2>&1
then
    echo "The 'ansible-playbook' command could not be found on your system. Please install it."
    exit 1
fi

chmod -R 600 "$SCRIPT_DIR/keys"

# - This part is done, sir! -
cd "$SCRIPT_DIR/ansible"
ansible-playbook -i inventory.ini playbooks/99-deploy.yml

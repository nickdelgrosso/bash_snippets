#!/bin/bash

# Get this script's absolute directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "$SCRIPT_DIR"

# source helper modules
source "$SCRIPT_DIR/../lib/show.sh"

# Main code
show "neat"

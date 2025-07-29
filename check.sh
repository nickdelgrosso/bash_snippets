#!/usr/bin/env bash
set -euo pipefail

# Directories to search (default: current dir)
SEARCH_DIRS=("${@:-.}")

echo "🔍 Checking shell scripts in: ${SEARCH_DIRS[*]}"

# Find all .sh files (excluding .git and node_modules)
sh_files=$(
  find "${SEARCH_DIRS[@]}" -type f -name "*.sh" \
    ! -path "*/.git/*" ! -path "*/node_modules/*"
)

if [[ -z "$sh_files" ]]; then
  echo "✅ No .sh files found."
  exit 0
fi

exit_code=0

for file in $sh_files; do
  echo "📄 $file"

  # Check syntax
  if ! bash -n "$file"; then
    echo "❌ Syntax error in $file"
    exit_code=1
  fi

  # Lint with ShellCheck
  if ! shellcheck -x "$file"; then
    echo "❌ ShellCheck failed for $file"
    exit_code=1
  fi

  # Format with shfmt (optional: remove -d to auto-fix)
  if ! shfmt -d -i 2 -ci -w "$file"; then
    echo "❌ shfmt reports formatting issues in $file"
    exit_code=1
  fi
done

if [[ "$exit_code" -eq 0 ]]; then
  echo "✅ All checks passed."
else
  echo "❌ Issues found. Please fix above errors."
fi

exit "$exit_code"

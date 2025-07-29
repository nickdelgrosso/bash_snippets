#!/bin/bash
set -euo pipefail
trap 'echo "💥 Crash at line $LINENO"; exit 1' ERR

# note: shellcheck -x run.sh         # checker: check for common errors and pitfalls
# note: shfmt -i 2 -ci -w run.sh  # linter: format the code in-place

# sayName
# Description: print the same name that is put in.
# Arguments:
#   $1 - The name to return
# Returns: 0 on success (really can't fail)
# Output: prints the name given it
sayName() {
  printf '%s' "$1"
  return 0
}

# sayGreet
# Description: print the same name that is put in.
# Arguments:
#   $1 - The name to return
# Returns: 0 on success (really can't fail)
# Output: prints the name given it
sayGreet() {
  # local neat="ooh"
  printf "%s" "$1"
  return 0
}

main() {

  sayGreet "$1"
  printf ", "
  sayName "$2"
  printf "!\n"
}

[[ "${BASH_SOURCE[0]}" == "$0" ]] && main "$@"

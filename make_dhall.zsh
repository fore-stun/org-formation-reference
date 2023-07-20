#!/etc/profiles/per-user/db/bin/zsh
set -euo pipefail

setopt EXTENDED_GLOB
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt ERR_EXIT

export LANG="${LANG:-en_GB.UTF-8}"

make_dhall() {
  local -a custom_tags=(
    "FindInMap"
    "Include"
    "Ref"
  )

  local -a custom_fns=(
    "And"
    "Base64"
    "Cidr"
    "Equals"
    "GetAZs"
    "GetAtt"
    "If"
    "ImportValue"
    "Join"
    "Not"
    "Or"
    "Select"
    "Split"
    "Sub"
    "fn"
  )

  local OUTPUT="${${1?Input yaml file}:r}.dhall"
  sed -E -e $'s/<<: !Include ["\'](.+\\.yml)["\']/{"<<Include":"\\1"}/' \
    -e 's/!('"${(j:|:)custom_tags}"') (.+)/{"\1":"\2"}/' \
    -e 's/!('"${(j:|:)custom_fns}"') (.+)/{"Fn::\1":"\2"}/' \
    < "$1" \
    | tee >&2 \
    | yj \
    | json-to-dhall --records-loose \
    | sed -E -e 's/"(.?+\.dhall)"/\1/' \
    > "$OUTPUT"

  git add "$OUTPUT"
}

make_dhall "$@"

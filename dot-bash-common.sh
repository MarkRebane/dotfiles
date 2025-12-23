#!/usr/bin/env bash

function for_each_entry() {
    local IFS=:
    read -ra entries <<< "$1"
    for entry in "${entries[@]}"; do
        printf '%s\n' "$entry"
    done
}

# Output a copy of $1 with:
# - empty entries removed
# - invalid entries removed, i.e. not a directory or not searchable
# - duplicate entries removed
# - order is preserved
# $1 the directory entries to normalise
function normalise_entries() {
    local result=()
    declare -A seen
    while IFS= read -r entry; do
        if [[ -z "$entry" ]]; then
            printf 'Warning: Empty entry\n' "$entry" >&2
            continue
        fi
        if [[ ! -d "$entry" ]]; then
            printf 'Warning: Missing directory: %s\n' "$entry" >&2
            continue
        fi
        if [[ ! -x "$entry" ]]; then
            printf 'Warning: Directory not searchable: %s\n' "$entry" >&2
            continue
        fi
        if [[ ${seen[$entry]} ]]; then
            printf 'Warning: Duplicate entry: %s\n' "$entry" >&2
            continue
        fi
        seen[$entry]=1
        result+=("$entry")
    done < <(for_each_entry "$1")
    (IFS=:; echo "${result[*]}")
}

function setup_local() {
    local base="$1"
    [ ! -d "$base" ] && return

    [ -d "$base/bin" ]           && export PATH="$base/bin:$PATH"
    [ -d "$base/lib" ]           && export LD_LIBRARY_PATH="$base/lib:$LD_LIBRARY_PATH"
    [ -d "$base/lib/pkgconfig" ] && export PKG_CONFIG_PATH="$base/lib/pkgconfig:$PKG_CONFIG_PATH"
    [ -d "$base/share" ]         && export XDG_DATA_DIRS="$base/share:$XDG_DATA_DIRS"
    [ -d "$base/share/man" ]     && export MANPATH="$base/share/man:$MANPATH"
}

## { Local setup & paths }------------------------------------------------------

setup_local "$HOME/.local"
for file in "$HOME/.local/"*; do
    setup_local "$file"
done

# Load local machine's configuration
localbashrc="$HOME/.bashrc.local"
if [ -r "$localbashrc" ]; then
    source "$localbashrc"
else
    echo "Warning: $localbashrc not found." >&2
fi

export PATH=$(normalise_entries "$PATH")
export LD_LIBRARY_PATH=$(normalise_entries "$LD_LIBRARY_PATH")
export XDG_DATA_DIRS=$(normalise_entries "$XDG_DATA_DIRS")
export MANPATH=$(normalise_entries "$MANPATH")

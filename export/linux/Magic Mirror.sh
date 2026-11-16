#!/bin/sh
printf '\033c\033]0;%s\a' Magic Mirror
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Magic Mirror.x86_64" "$@"

#!/bin/sh
echo -ne '\033c\033]0;Cavern Crabber\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Cavern Crabber.arm64" "$@"

#!/bin/bash
#
# Run tcslog-sample against a throwaway directory.
#
# Creates a temporary directory, writes a sample log chain into it, lists
# what was written, then deletes the directory. Any arguments are passed
# through to the binary, e.g.:
#
#     ./run-sample.sh --verbose
#
set -euo pipefail

cd "$(dirname "$0")"

prefix=sample-
suffix=.tcslog

log_dir=$(mktemp -d -t tcslog-sample-XXXXXXXX)
trap 'rm -rf "$log_dir"' EXIT

echo "Log directory: $log_dir"
echo

cargo run --quiet -- "$log_dir" "$prefix" "$suffix" "$@"

echo
echo "Segment files written:"
ls -l "$log_dir"

echo
echo "Removing $log_dir"

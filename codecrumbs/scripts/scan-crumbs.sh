#!/usr/bin/env bash
# scan-crumbs.sh — extract codecrumbs breadcrumbs from a source tree.
# Usage: scan-crumbs.sh [dir]   (default: current directory)
# Output: file:line:<crumb comment> for every crumb found.
set -euo pipefail
DIR="${1:-.}"
grep -rInE '^[[:space:]]*(//|#|!|/\*|--)[[:space:]]*(cc|codecrumb):' "$DIR" \
  --exclude-dir={node_modules,.git,dist,build,vendor} || true

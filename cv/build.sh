#!/usr/bin/env bash
# Build the canonical CV and deploy it to the published location.
#
#   bash build.sh
#
# Resolves its own directory, so it works from anywhere. Needs a TeX install
# with pdflatex on PATH (TinyTeX on this machine).
set -euo pipefail
cd "$(dirname "$0")"

# Two passes so hyperref links / cross-references resolve.
pdflatex -interaction=nonstopmode -halt-on-error cv.tex >/dev/null
pdflatex -interaction=nonstopmode -halt-on-error cv.tex >/dev/null

cp cv.pdf ../assets/cv.pdf

# Clean intermediates only on success (set -e aborts before this on failure,
# leaving cv.log for inspection).
rm -f cv.aux cv.log cv.out cv.pdf cv.synctex.gz

echo "Built and deployed -> assets/cv.pdf"

#!/usr/bin/env bash
set -e # halt script on error

bundle exec jekyll build

bundle exec htmlproof ./_site --disable-external --file-ignore="./_site/examples/sharebuttons.html" --check-html

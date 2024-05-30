#!/bin/bash

hugo -d docs
rm .hugo_build.lock

git add -A
git commit -m "update"
git push -u origin main

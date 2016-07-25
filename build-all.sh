#!/usr/bin/env bash
ls -1 ./pkgs/ | xargs -I{} bash -c './build.sh "{}"';
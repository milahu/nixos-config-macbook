#! /usr/bin/env bash

set -x

find . -name "*.nix" | xargs nixpkgs-fmt

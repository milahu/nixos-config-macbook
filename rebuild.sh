#! /usr/bin/env bash

set -x

exec sudo nixos-rebuild switch --impure --print-build-logs --show-trace

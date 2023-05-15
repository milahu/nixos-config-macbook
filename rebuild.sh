#! /usr/bin/env bash

set -x

exec nixos-rebuild switch --impure --print-build-logs --show-trace

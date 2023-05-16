#!/bin/sh
nix eval --impure --json --expr 'with import <nixpkgs> {}; builtins.attrNames pkgs.gnomeExtensions' | jq -r '.[]'

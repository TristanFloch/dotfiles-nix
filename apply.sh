#!/bin/sh

pushd ~/.config/nixpkgs
sudo nixos-rebuild switch --flake '.#' --impure
popd

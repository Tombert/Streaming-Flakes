#!/bin/sh
unset LD_PRELOAD

nix run .#jellyfin

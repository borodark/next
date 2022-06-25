#!/bin/bash

# if merge conflicts - kill the file?
#rm -rf _build
#mix do deps.clean --all
mix local.hex --if-missing
export MIX_ENV=io
git checkout -- mix.lock
# mix deps.unlock --all
mix do deps.get, deps.compile, clean, compile
elixir --sname `id -un` --cookie `id -un` -S mix run --no-halt


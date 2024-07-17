#!/usr/bin/env bash

# https://stackoverflow.com/a/77682932/12555423
# Remove comments and any spaces in lines
heroku config:set --app $1 $(sed 's:#.*$::g' "$2" | tr -d ' ')

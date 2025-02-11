#!/bin/sh

# get all the currently made signals and delete them
signals_array=$(yabai -m signal --list | jq -r '.[].index')

# loop through those arrays and YEET
for i in $signals_array; do yabai -m signal --remove "$i"; done

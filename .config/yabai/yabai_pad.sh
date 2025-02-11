#!/bin/sh

# shell script to get the spaces array from the command yabai -m query --displays --display 3 and store it in a variable
main_spaces_array=$(yabai -m query --displays --display 1 | jq -r '.spaces[]')
secondary_spaces_array=$(yabai -m query --displays --display 2 | jq -r '.spaces[]')

top_padding=10
# loop through those arrays and apply a top padding to each space
for i in $main_spaces_array; do yabai -m config --space "$i" top_padding $top_padding; done
for i in $secondary_spaces_array; do yabai -m config --space "$i" top_padding $top_padding; done

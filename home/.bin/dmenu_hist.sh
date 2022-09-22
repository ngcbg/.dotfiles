#!/usr/bin/fish
history | dmenu -l 30 | xargs -r kitty -e

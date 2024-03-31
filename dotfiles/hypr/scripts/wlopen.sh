#!/bin/bash
xdg-open "$(rg --no-messages --files ~/doc ~/pc ~/pic ~/dwn ~/.config ~/vid \
    -g "!{*.srt,*.rar,*.txt,*.zip,*.nfo}" | bemenu -l 20 -i --line-height 25 --fn "JetBrainsMono Nerd Font 14" --tb \#4e9cb0 --tf \#1e1e1e --hb \#f0c674 --hf \#1e1e1e)"


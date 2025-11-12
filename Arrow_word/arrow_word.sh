#!/bin/bash
# A script to solve arrow word puzzles
echo "Enter a word replacing blank characters with dots '.'"; read input
echo "List of possible words:"

grep -i "^${input}$" /usr/share/dict/words # requires blanks to be '.'

# awk alternative using spaces instead of dots for the unknown characters eg "c t"
#awk 'FNR==NR {a[$0]++;next} $0 in a' /usr/share/dict/words <(eval echo $(sed 's/ /{a..z}/g' <<<"${input}")|tr " " \\n)

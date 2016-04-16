#!/bin/zsh

ST3_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages"

rsync -Pavuz --files-from=$DOT_DIR/sublimetext/st-pref-sync.conf "$ST3_DIR" $DOT_DIR/sublimetext/

for f in $DOT_DIR/sublimetext/User/Projects/{*.sublime-workspace,*.sublime-project,*.json}; do
    base64 -i $f -o  $DOT_DIR/sublimetext/User/Projects/$(echo $f | base64) && rm -vf $f
done
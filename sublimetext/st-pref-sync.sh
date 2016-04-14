#!/bin/bash

ST3_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages"

# rsync -Pavu --files-from=$DOT_DIR/sublimetext/st-pref-sync.conf $ST3_DIR $DOT_DIR/sublimetext/

rsync -Pavuz --files-from=$DOT_DIR/sublimetext/st-pref-sync.conf "$ST3_DIR" $DOT_DIR/sublimetext/

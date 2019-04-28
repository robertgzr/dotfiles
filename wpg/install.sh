#!/bin/sh

echo "[*] Installing gtk/icon templates..."
wpg-install.sh -g
wpg-install.sh -i

echo "[*] Installing custom templates..."
for tb in ./templates/*.base; do
    echo -n "Link $tb to: "
    read -r target
    if [[ -n "$target" ]]; then
        echo + wpg --link $tb $target 
        wpg --link "$tb" "$target"
    fi
done

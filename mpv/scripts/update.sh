#!/bin/sh

set -e

for d in ./*; do
    if [[ -d ${d} ]]; then
        echo ${d}
	cd ${d}
	git fetch
	git rebase origin/master
	cd ..
    fi
done

#!/bin/sh
# usage: ovl.sh COLORS ADDITIONAL_FILES...
set -e

colors_yml=$1 ; shift
[ -z "$colors_yml" ] && exit 1

set -x
yq m -x base.ovl.yml "$colors_yml" "$@"

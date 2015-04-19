#!/usr/bin/env bash

# https://github.com/juliangruber/vipe/blob/b437a3ae7ac771b264d24b8cf55f4af91dcae034/vipe.sh

#
# vipe(1) - Pipe in and out of $EDITOR
#
# (c) 2014 Julian Gruber <julian@juliangruber.com>.
#
# MIT licensed.
#
# Example:
#
#   $ echo foo | vipe | gist
#   $ vipe | gist
#
# This is a lightweight bash only version. For the original impementation in
# python, check https://github.com/madx/moreutils/blob/master/vipe
#

# version

VERSION="0.0.0"

# usage

if [ "-h" = "${1}" ]; then
  echo "usage: vipe [-hV]"
  exit 0
elif [ "-V" = "${1}" ]; then
  echo "${VERSION}"
fi

# temp file

t=/tmp/vipe.$$.txt
touch $t

# read from stdin

if [ ! -t 0 ]; then
  cat > $t
fi

# spawn editor with stdio connected

${EDITOR} $t < /dev/tty > /dev/tty || exit $?

# write to stdout

cat $t

# cleanup

rm $t

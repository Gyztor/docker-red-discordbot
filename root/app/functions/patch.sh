#!/usr/bin/env sh
set -euf

# Python 3.8, remove mongo dependencies
if ! [ -f "/home/container/venv/.pcxversion" ]; then
    rm -rf /home/container/venv
    mkdir -p /home/container/venv
    echo "2" >"/home/container/venv/.pcxversion"
fi

# Python 3.9, remove 3.8 dependencies
if [ "$(cat "/home/container/venv/.pcxversion")" = "1" ]; then
    rm -rf /home/container/venv
    mkdir -p /home/container/venv
    echo "2" >"/home/container/venv/.pcxversion"
fi

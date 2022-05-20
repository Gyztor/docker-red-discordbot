#!/usr/bin/env sh
set -euf

# Patch older versions of data if needed
/app/functions/patch.sh

# If config file doesn't exist, make one
if ! [ -f "/home/container/config.json" ]; then
    if [ -f "${HOME}/config.json" ]; then
        # Migrating old data
        echo "Moving ${HOME}/config.json to /home/container/config.json"
        mv "${HOME}/config.json" /home/container/config.json
    else
        # Default to JSON storage
        cp /defaults/config.json /home/container/config.json
    fi
fi

# If config symlink is broken because user mounted the home directory (/config or /root), make it
if [ "$(readlink -f "${HOME}/.config/Red-DiscordBot/config.json")" != "/home/container/config.json" ]; then
    rm -rf "${HOME}/.config/Red-DiscordBot/config.json"
    mkdir -p "${HOME}/.config/Red-DiscordBot"
    ln -s /home/container/config.json "${HOME}/.config/Red-DiscordBot/config.json"
fi

# Prepare and activate venv
echo "Activating Python virtual environment..."
mkdir -p /home/container/venv
python -m venv --upgrade --upgrade-deps /home/container/venv
python -m venv /home/container/venv
. /home/container/venv/bin/activate

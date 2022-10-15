#!/usr/bin/env bash

set -e

# Source fundtions from GOW utils
source /opt/gow/bash-lib/utils.sh

# Execute all container init scripts. Only run this if the container is started as the root user
if [ "$(id -u)" = "0" ]; then
    for init_script in /etc/cont-init.d/*.sh ; do
        gow_log
        gow_log "[ ${init_script}: executing... ]"
        sed -i 's/\r$//' "${init_script}"
        source "${init_script}"
    done
fi

# If a command was passed, run that instead of the usual init startup script
if [ ! -z "$@" ]; then
    exec $@
    exit $?
fi

# Launch startup script as 'UNAME' user (some services will run as root)
gow_log "Launching the container's startup script"
chmod +x /opt/gow/startup.sh
exec gosu ${UNAME} /opt/gow/startup.sh

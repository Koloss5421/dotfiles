#!/bin/bash

# NVIM Helper script to automatically add to current session or start a new one

NVIM_BIN=/usr/bin/nvim
NVIM_SESSION_FILE=/tmp/nvim-session
FORCE_NEW_SESSION=0

while getopts ":sn:" opt; do
    case $opt in
        n)
            FORCE_NEW_SESSION=1
            shift
            ;;
    esac
done

if [[ "$FORCE_NEW_SESSION" == 1 ]]; then
    $NVIM_BIN $1
    exit 0
fi


if [ -e "$NVIM_SESSION_FILE" ]; then
    $NVIM_BIN --server $NVIM_SESSION_FILE --remote $1 2>&1 > /dev/null
    printf "[+] Opened in existing nvim session!\n"
else
    $NVIM_BIN --listen $NVIM_SESSION_FILE $1
fi

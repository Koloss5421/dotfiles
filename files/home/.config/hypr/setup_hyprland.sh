#!/bin/bash
# Get Model IDs and set hyprland workspace

CONNECTED_MONITORS=()
RIGHT_MONITOR_HASH=ea3b7646c710cf0f696de2390dbf5f04
LEFT_MONITOR_HASH=8b514cce9a007aac44058d6e3ca11ba3


## TODO: Check if the monitors are even connected...
## Lets get both monitors

for d in /sys/class/drm/*/status; do
    MONITOR_STATUS=$(cat $d)
    CON=${d%/status}
    MONITOR_PORT=$(echo -n "${CON##*/}" | cut -d '-' -f 2-)
    MONITOR_TYPE=$(echo -n $MONITOR_PORT | cut -d '-' -f 1)
    if [[ "$MONITOR_STATUS" == "connected" ]] && [[ "$MONITOR_TYPE" == "DP" ]]; then
        CONNECTED_MONITORS+=("$MONITOR_PORT")
    fi
done

monitor_low=${CONNECTED_MONITORS[0]}
monitor_high=${CONNECTED_MONITORS[1]}

monitor_low_hash=$(cat /sys/class/drm/card0-$monitor_low/edid | md5sum - | cut -d ' ' -f 1)
monitor_high_hash=$(cat /sys/class/drm/card0-$monitor_high/edid | md5sum - | cut -d ' ' -f 1)

## Replace the hyprland conf with the template
cp ~/.config/hypr/hyprland.conf.template ~/.config/hypr/hyprland.config

## Replace based on the hash
if [[ "$monitor_low_hash" == "$LEFT_MONITOR_HASH" ]]; then
    sed -i -e "s/{{ LEFT_MONITOR }}/$monitor_low/g" ~/.config/hypr/hyprland.config
    sed -i -e "s/{{ RIGHT_MONITOR }}/$monitor_high/g" ~/.config/hypr/hyprland.config
else
    sed -i -e "s/{{ LEFT_MONITOR }}/$monitor_high/g" ~/.config/hypr/hyprland.config
    sed -i -e "s/{{ RIGHT_MONITOR }}/$monitor_low/g" ~/.config/hypr/hyprland.config
fi

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export WLR_NO_HARDWARE_CURSORS=1

exec Hyprland

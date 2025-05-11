#!/bin/bash
# Check if laptop lid is closed, triggers turn off display.
# Bind event does not seem to update unless you open / reclose the lid
if [[ "$(cat /proc/acpi/button/lid/LID0/state | awk '{print $2}')" -eq "closed" ]]; 
then 
    hyprctl keyword monitor "eDP-1, disable"
fi;
